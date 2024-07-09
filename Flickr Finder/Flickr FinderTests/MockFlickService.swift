//
//  MockFlickService.swift
//  Flickr FinderTests
//
//  Created by Amulya Gangam on 6/28/24.
//

import Combine
import Foundation

class MockFlickrService: FlickrService {
    var result: Result<FlickrResponse, Error>?
    
    override func fetchImages(for query: String) -> AnyPublisher<FlickrResponse, Error> {
        guard let result = result else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        return result.publisher.eraseToAnyPublisher()
    }
}

