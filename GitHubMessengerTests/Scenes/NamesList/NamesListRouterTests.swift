//
//  NamesListRouterTests.swift
//  GitHubMessengerTests
//
//  Created by Gabriel Targon on 30/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

@testable import GitHubMessenger
import XCTest

final class NamesListRouterTests: XCTestCase {

    private var sut: NamesListRouter!
    private var dataStoreSpy: NamesListInteractorSpy!
    private var viewControllerSpy: NamesListViewControllerSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        dataStoreSpy = NamesListInteractorSpy()
        viewControllerSpy = NamesListViewControllerSpy()
        sut = NamesListRouter(viewController: viewControllerSpy, dataStore: dataStoreSpy)
    }
    
    override func tearDown() {
        sut = nil
        dataStoreSpy = nil
        viewControllerSpy = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testRouteToChat() {
        sut.routeToChat()
    }
}
