//
//  NamesListWorkerTests.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 30/04/21.
//  Copyright (c) 2021 Gabriel Targon. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import GitHubMessenger
import XCTest

class NamesListWorkerTests: XCTestCase {
    // MARK: Subject under test
    
    private var sut: NamesListWorker!
//    private var dataProviderSpy: DataProviderMock!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = NamesListWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testRequestGitHubUserInfo() {
        let expectation = XCTestExpectation(description: "Wait for request")
        
        sut.requestGitHubUserInfo { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}