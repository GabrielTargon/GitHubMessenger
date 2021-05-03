//
//  ChatWorkerTests.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 30/04/21.
//  Copyright (c) 2021 Gabriel Targon. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import XCTest
@testable import GitHubMessenger

final class ChatWorkerTests: XCTestCase {
    // MARK: Subject under test
    private var sut: ChatWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = ChatWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testSaveMessage() {
        sut.saveMessage(msg: ChatSeeds.ChatRequest)
    }
    
    func testGetMessages() {
        let result = sut.getMessages()
        XCTAssertNotNil(result)
    }
}