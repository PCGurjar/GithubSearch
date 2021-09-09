//
//  GithubNetworkTests.swift
//  GithubSearchTests
//
//  Created by Poonamchand on 09/09/21.
//

import XCTest
@testable import GithubSearch

class GithubNetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK:- For search
    func testSearchValidText() {
        let expct = expectation(description: "Returns json response")
        
        SearchService().request("Pc") { (result) in
            
            switch result {
            case .Success(let results):
                if results != nil {
                    XCTAssert(true, "Success")
                    expct.fulfill()
                } else {
                    XCTFail("No results")
                }
            case .Failure(let message):
                XCTFail(message)
            case .Error(let error):
                XCTFail(error)
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
        
    func testSearchInvalidText() {
        let expct = expectation(description: "Returns error message")
        
        SearchService().request("") { (result) in
            switch result {
            case .Success( _):
                XCTFail("No results")
            case .Failure( _):
                XCTAssert(true, "Success")
                expct.fulfill()
            case .Error( _):
                XCTAssert(true, "Success")
                expct.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK:- for follower
    func testFollowerValidUrl() {
        let expct = expectation(description: "Returns json response")
        
        FollowerService().request("https://api.github.com/users/pc/followers") { (result) in
            
            switch result {
            case .Success(let results):
                if results != nil {
                    XCTAssert(true, "Success")
                    expct.fulfill()
                } else {
                    XCTFail("No results")
                }
            case .Failure(let message):
                XCTFail(message)
            case .Error(let error):
                XCTFail(error)
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testFollowerInValidUrl() {
        let expct = expectation(description: "Returns error message")
        
        FollowerService().request("https://api.github.com/users/pc/followerscjabsjfka") { (result) in
            switch result {
            case .Success( _):
                XCTFail("No results")
            case .Failure( _):
                XCTAssert(true, "Success")
                expct.fulfill()
            case .Error( _):
                XCTAssert(true, "Success")
                expct.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}
