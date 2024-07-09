//
//  FlickrError.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import Foundation

/// An enumeration representing different types of errors that can occur when fetching data from the Flickr API.
enum FlickrError: LocalizedError {
    /// Error indicating that the provided URL is invalid.
    case invalidURL
    
    /// Error indicating that the decoding of the response data failed.
    case decodingFailed
    
    /// Error indicating that the network request failed.
    case requestFailed
    
    /// Error indicating an unknown error.
    case unknown
    
    /// A description of the error that can be displayed to the user.
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .requestFailed:
            return "The network request failed."
        case .decodingFailed:
            return "Failed to decode the response."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
