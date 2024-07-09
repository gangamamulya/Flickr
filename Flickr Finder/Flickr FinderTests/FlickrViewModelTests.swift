//
//  FlickrViewModelTests.swift
//  Flickr FinderTests
//
//  Created by Amulya Gangam on 6/28/24.
//

import XCTest
import Combine
@testable import Flickr_Finder

class FlickrViewModelTests: XCTestCase {
    var viewModel: FlickrViewModel!
    var mockService: MockFlickrService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockFlickrService()
        viewModel = FlickrViewModel(flickrService: mockService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchImagesSuccess() {
        // Given
        let items = [FlickrItem(
            title: "Test Image",
            link: "https://www.example.com",
            media: FlickrItem.Media(m: "https://www.example.com/image.jpg"),
            date_taken: "2024-06-27T06:12:31-08:00",
            description: "Test Description",
            published: "2024-06-27T10:17:53Z",
            author: "Test Author",
            author_id: "12345",
            tags: "test"
        )]
        let response = FlickrResponse(items: items)
        mockService.result = .success(response)
        
        let expectation = XCTestExpectation(description: "Fetch images successfully")
        
        // When
        viewModel.fetchImages(for: "test")
        
        // Then
        viewModel.$items
            .dropFirst()
            .sink { items in
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first?.title, "Test Image")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchImagesFailure() {
        // Given
        mockService.result = .failure(URLError(.badServerResponse))
        
        let expectation = XCTestExpectation(description: "Handle fetch images error")
        
        // When
        viewModel.fetchImages(for: "test")
        
        // Then
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testEmptyQuery() {
        // Given
        viewModel.searchText = ""
        
        // When
        viewModel.fetchImages(for: "")
        
        // Then
        XCTAssertTrue(viewModel.items.isEmpty)
    }
    
    func testSearchTextDebounce() {
        // Given
        let items = [FlickrItem(
            title: "Test Image",
            link: "https://www.example.com",
            media: FlickrItem.Media(m: "https://www.example.com/image.jpg"),
            date_taken: "2024-06-27T06:12:31-08:00",
            description: "Test Description",
            published: "2024-06-27T10:17:53Z",
            author: "Test Author",
            author_id: "12345",
            tags: "test"
        )]
        let response = FlickrResponse(items: items)
        mockService.result = .success(response)
        
        let expectation = XCTestExpectation(description: "Search text debounce")
        
        // When
        viewModel.searchText = "test"
        
        // Then
        viewModel.$items
            .dropFirst()
            .sink { items in
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first?.title, "Test Image")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.5) // Waiting for debounce
    }
}
