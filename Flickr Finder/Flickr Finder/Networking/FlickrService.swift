//
//  FlickrService.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import Combine
import Foundation

/// Service responsible for fetching Flickr data from the API.
class FlickrService: FlickrServiceProtocol {
    /// Fetches a list of Flickr items based on the search query.
    /// - parameter query: The search query to fetch items for.
    /// - returns: A publisher emitting a `FlickrResponse` object containing an array of `FlickrItem` objects, or an error if the data fetching fails.
    func fetchImages(for query: String) -> AnyPublisher<FlickrResponse, Error> {
        guard !query.isEmpty,
              let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(query)")
        else {
            return Fail(error: FlickrError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw FlickrError.requestFailed
                }
                return data
            }
            .decode(type: FlickrResponse.self, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError {
                    return FlickrError.requestFailed
                } else if let decodingError = error as? DecodingError {
                    return FlickrError.decodingFailed
                } else {
                    return FlickrError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
