//
//  NamesListInteractor.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 12/03/20.
//  Copyright (c) 2020 Gabriel Targon. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NamesListBusinessLogic {
    func handleNameTouched(request: NamesList.Name.Request)
    func handleGetUserInfo()
}

protocol NamesListDataStore {
    //var name: String { get set }
}

class NamesListInteractor: NamesListBusinessLogic, NamesListDataStore {
    var presenter: NamesListPresentationLogic?
    var worker: NamesListWorker?
    
    init(presenter: NamesListPresentationLogic,
         worker: NamesListWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func handleNameTouched(request: NamesList.Name.Request) {
        let response = NamesList.Name.Response(user: request.user)
        presenter?.presentChat(response: response)
    }
    
    func handleGetUserInfo() {
        worker?.requestGitHubUserInfo { (users) in
            self.presenter?.presentUserList(response: users ?? [])
        }
    }
}