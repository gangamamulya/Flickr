//
//  FlickrViewModelProtocol.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import Combine
import Foundation

/// Protocol defining the ViewModel properties and methods for managing Flickr data.
protocol FlickrViewModelProtocol: ObservableObject {
    /// The current search text entered by the user.
    var searchText: String { get set }
    
    /// The array of fetched Flickr items to be displayed in the view.
    var items: [FlickrItem] { get }
    
    /// A boolean indicating whether the data is currently being loaded.
    var isLoading: Bool { get }
    
    /// Fetches images based on the current search text.
    func fetchImages(for query: String)
}

