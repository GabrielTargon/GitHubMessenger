//
//  NamesListPresenterSpy.swift
//  GitHubMessengerTests
//
//  Created by Gabriel Targon on 30/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

@testable import GitHubMessenger
import XCTest

final class NamesListPresenterSpy {
    var presentChatCalled = false
    var presentUserListCalled = false
}

extension NamesListPresenterSpy: NamesListPresentationLogic {
    func presentChat() {
        presentChatCalled = true
    }
    
    func presentUserList(response: [NamesList.User]) {
        presentUserListCalled = true
    }
}
