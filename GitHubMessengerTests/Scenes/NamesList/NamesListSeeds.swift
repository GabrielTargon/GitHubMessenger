//
//  NamesListSeeds.swift
//  GitHubMessengerTests
//
//  Created by Gabriel Targon on 02/05/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import XCTest
@testable import GitHubMessenger

struct NamesListSeeds {

    static let User = NamesList.User(login: "Teste 1", id: 0, avatar: "Testando 1")
    
    static let UserListArray = [NamesList.User(login: "Teste 1", id: 0, avatar: "Testando 1"),
                                NamesList.User(login: "Teste 2", id: 1, avatar: "Testando 2"),
                                NamesList.User(login: "Teste 3", id: 2, avatar: "Testando 3"),
                                NamesList.User(login: "Teste 4", id: 3, avatar: "Testando 4")]
}
