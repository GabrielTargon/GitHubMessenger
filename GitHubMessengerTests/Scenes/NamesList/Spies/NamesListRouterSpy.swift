//
//  NamesListRouterSpy.swift
//  GitHubMessengerTests
//
//  Created by Gabriel Targon on 30/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

@testable import GitHubMessenger
import XCTest

final class NamesListRouterSpy: NamesListDataPassing {
    var dataStore: NamesListDataStore?
    
    var routeToChatCalled = false
}

extension NamesListRouterSpy: NamesListRoutingLogic {
    func routeToChat() {
        routeToChatCalled = true
    }
}
