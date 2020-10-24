//
//  NamesListPresenter.swift
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

protocol NamesListPresentationLogic {
    func presentChat(response: NamesList.Name.Response)
    func presentUserList(response: [NamesList.User])
}

class NamesListPresenter: NamesListPresentationLogic {
    weak var viewController: NamesListDisplayLogic?
    
    // MARK: Do something
    
    func presentChat(response: NamesList.Name.Response) {
        let viewModel = NamesList.Name.ViewModel(user: response.user)
        viewController?.displayChat(viewModel: viewModel)
    }
    
    func presentUserList(response: [NamesList.User]) {
        viewController?.displayUserList(viewModel: response)
    }
    
    
}