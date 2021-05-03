//
//  NamesListInteractorSpy.swift
//  GitHubMessengerTests
//
//  Created by Gabriel Targon on 30/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

@testable import GitHubMessenger
import XCTest

final class NamesListInteractorSpy: NamesListDataStore {
    var user = NamesList.User(login: String(), id: Int(), avatar: String())
    
    var handleNameTouchedCalled = false
    var handleGetUserInfoCalled = false
}

extension NamesListInteractorSpy: NamesListBusinessLogic {
    func handleNameTouched(request: NamesList.Name.Request) {
        handleNameTouchedCalled = true
    }
    
    func handleGetUserInfo() {
        handleGetUserInfoCalled = true
    }
}
