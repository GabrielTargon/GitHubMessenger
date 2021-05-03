//
//  NamesListWorkerSpy.swift
//  GitHubMessengerTests
//
//  Created by Gabriel Targon on 02/05/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

@testable import GitHubMessenger
import XCTest

final class NamesListWorkerSpy {
    var requestGitHubUserInfoCalled = false
}

extension NamesListWorkerSpy: NamesListWorkLogic {
    func requestGitHubUserInfo(completionHandler: @escaping ([NamesList.User]?) -> Void) {
        requestGitHubUserInfoCalled = true
    }
}
