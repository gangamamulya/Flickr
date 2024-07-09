//
//  FlickrServiceProtocol.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import Combine
import Foundation

/// Protocol defining the methods for fetching Flickr data using Combine publishers.
protocol FlickrServiceProtocol {
    /// Fetches a list of Flickr items based on the search query.
    /// - parameter query: The search query to fetch items for.
    /// - returns: A publisher emitting a `FlickrResponse` object containing an array of `FlickrItem` objects, or an error if the data fetching fails.
    func fetchImages(for query: String) -> AnyPublisher<FlickrResponse, Error>
}
