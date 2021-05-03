//
//  NamesListViewControllerSpy.swift
//  GitHubMessengerTests
//
//  Created by Gabriel Targon on 30/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

@testable import GitHubMessenger
import XCTest

final class NamesListViewControllerSpy: UIViewController {
    var displayChatCalled = false
    var displayUserListCalled = false
}

extension NamesListViewControllerSpy: NamesListDisplayLogic {
    func displayChat() {
        displayChatCalled = true
    }
    
    func displayUserList(viewModel: [NamesList.User]) {
        displayUserListCalled = true
    }
}
