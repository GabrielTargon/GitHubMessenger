//
//  ChatInteractorTests.swift
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

final class ChatInteractorTests: XCTestCase {
    // MARK: Subject under test
    private var sut: ChatInteractor!
    private var presenterSpy: ChatPresenterSpy!
    private var workerSpy: ChatWorkerSpy!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        presenterSpy = ChatPresenterSpy()
        workerSpy = ChatWorkerSpy()
        sut = ChatInteractor(presenter: presenterSpy, worker: workerSpy)
    }
    
    override func tearDown() {
        presenterSpy = nil
        workerSpy = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testReturnUserLogin() {
        let result = sut.returnUserLogin()
        XCTAssertNotNil(result)
    }
    
    func testGetMessages() {
        let result = sut.getMessages()
        XCTAssertNotNil(result)
    }
    
    func testSaveMessage() {
        sut.saveMessage(request: ChatSeeds.ChatRequest)
        XCTAssert(workerSpy.saveMessageCalled)
    }
}
