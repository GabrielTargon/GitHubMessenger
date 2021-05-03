//
//  ChatSeeds.swift
//  GitHubMessengerTests
//
//  Created by Gabriel Targon on 02/05/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import XCTest
@testable import GitHubMessenger

struct ChatSeeds {

    static let ChatRequest = Chat.Message.Request(text: "Teste", type: .incoming, date: Date(), friend: "Testando")
    
    static let ChatUser = "Teste"
}
