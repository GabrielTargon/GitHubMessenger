//
//  ChatRouterSpy.swift
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

final class ChatRouterSpy: ChatDataPassing {
    var dataStore: ChatDataStore?
}

extension ChatRouterSpy: ChatRoutingLogic {}
