//
//  NamesListRouter.swift
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

protocol NamesListRoutingLogic {
    func routeToChat(userInfo: NamesList.User)
}

protocol NamesListDataPassing {
    var dataStore: NamesListDataStore? { get }
}

class NamesListRouter: NSObject, NamesListRoutingLogic, NamesListDataPassing {
    weak var viewController: NamesListViewController?
    var dataStore: NamesListDataStore?
    
    // MARK: Routing
    
    func routeToChat(userInfo: NamesList.User) {
        let chatView = ChatViewController.instantiateNew()
        chatView.user = userInfo
        viewController?.navigationController?.pushViewController(chatView, animated: true)
    }
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: NamesListViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: NamesListDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}