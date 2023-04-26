//
//  ZeeMeeDemoTests.swift
//  ZeeMeeDemoTests
//
//  Created by Jason Jardim on 4/6/23.
//

import XCTest
@testable import ZeeMeeDemo

final class ZeeMeeDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    // sut = system under test
    @MainActor func test_search_API() {

        let sut = HomeSearchVM()

        sut.explicitSearch(term: "Blue Margarita")

        wait {
            XCTAssert(sut.searchResults.count >= 1, "Successful")
        }
        
    }
    
    @MainActor func test_detail_API() {
  
        let sut = DetailVM(drinkId: "1001")

        Task {
            try await sut.fetchCocktailDetails()
            
            wait {
                XCTAssert(sut.drinkDetails?.strDrink != nil)
            }
        }
    }
    
}

// Extension to XCTest to wait for API

extension XCTestCase {
    func wait(interval: TimeInterval = 5.0 , completion: @escaping (() -> Void)) {
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
            exp.fulfill()
        }
        waitForExpectations(timeout: interval + 0.1) // add 0.1 for sure `asyncAfter` called
    }
}

