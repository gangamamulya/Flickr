//
//  Flickr_FinderUITests.swift
//  Flickr FinderUITests
//
//  Created by Amulya Gangam on 6/28/24.
//

import XCTest

class FlickrFinderUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testSearchAndDisplayResults() {
        let searchField = app.textFields["Search"]
        XCTAssertTrue(searchField.exists)
        
        searchField.tap()
        searchField.typeText("nature\n")
        
        let firstResult = app.images.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: firstResult, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(firstResult.exists)
    }
    
}
