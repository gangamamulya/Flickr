//
//  FlickrViewModel.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import Combine
import Foundation

/// ViewModel responsible for managing Flickr data and state for the view.
class FlickrViewModel: FlickrViewModelProtocol {
    @Published var searchText = ""
    @Published private(set) var items: [FlickrItem] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let flickrService: FlickrServiceProtocol
    
    /// Initializes the ViewModel with a Flickr service.
    /// - parameter flickrService: The service conforming to `FlickrServiceProtocol` used for fetching data. Defaults to an instance of `FlickrService`.
    init(flickrService: FlickrServiceProtocol = FlickrService()) {
        self.flickrService = flickrService
        setupBindings()
    }
    
    /// Sets up bindings to react to changes in the search text.
    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.fetchImages(for: text)
            }
            .store(in: &cancellables)
    }
    
    /// Fetches images based on the current search text.
    func fetchImages(for query: String) {
        guard !query.isEmpty else {
            items = []
            return
        }
        
        isLoading = true
        
        flickrService.fetchImages(for: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = (error as? FlickrError)?.errorDescription ?? error.localizedDescription
                    print("Error fetching images: \(self?.errorMessage ?? "Unknown error")")
                }
            }, receiveValue: { [weak self] response in
                self?.items = response.items
            })
            .store(in: &cancellables)
    }
}
