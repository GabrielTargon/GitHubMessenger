//
//  ChatFactory.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 29/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import UIKit

class ChatFactory {
    static func setupChat() -> UIViewController {
        let viewController = ChatViewController()
        let worker = ChatWorker()
        let presenter = ChatPresenter(viewController: viewController)
        let interactor = ChatInteractor(presenter: presenter, worker: worker)
        let router = ChatRouter(viewController: viewController, dataStore: interactor)
        viewController.setup(interactor: interactor, router: router)
        return viewController
    }
}
