//
//  ChatViewController.swift
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
import CoreData

protocol ChatDisplayLogic: AnyObject {}

class ChatViewController: UIViewController, ChatDisplayLogic {
    typealias ChatRoutingProtocol = ChatRoutingLogic & ChatDataPassing
    var interactor: ChatBusinessLogic?
    var router: (ChatRoutingProtocol)?
    
    private var customView = ChatView()
    
    var user = String()
    var messages: [NSManagedObject] = []
    
    // MARK: Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInfos()
    }
    
    // MARK: Setup
    
    func setup(interactor: ChatBusinessLogic? = nil, router: ChatRoutingProtocol? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Functions
    
    func getInfos() {
        guard let userLogin = interactor?.returnUserLogin(),
              let msg = interactor?.getMessages() else {
            return
        }
        
        user = userLogin
        messages = msg
        
        self.title = user
    }
    
    func sendMessage() {
        if let text = customView.sendMessageView.textField.text {
            interactor?.saveMessage(request: Chat.Message.Request(text: text, type: .incoming, date: Date(), friend: user))
            interactor?.saveMessage(request: Chat.Message.Request(text: text, type: .outgoing, date: Date(), friend: user))
            
            getInfos()
            customView.sendMessage(messages: messages)
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeMsg = messages[indexPath.row]
        if typeMsg.value(forKeyPath: "friend") as? String == user {
            if typeMsg.value(forKeyPath: "type") as? String == "incoming" {
                let incomingCell = tableView.dequeueReusableCell(withIdentifier: BubbleCell.cellIdentifier) as! BubbleCell
                incomingCell.type = .incoming
                return incomingCell
            } else if typeMsg.value(forKeyPath: "type") as? String == "outgoing" {
                let outgoingCell = tableView.dequeueReusableCell(withIdentifier: BubbleCell.cellIdentifier) as! BubbleCell
                outgoingCell.type = .outgoing
                return outgoingCell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let messageText = messages[indexPath.row].value(forKeyPath: "text") as? String {
            let size = CGSize(width: 250, height: 100)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], context: nil)
            return estimatedFrame.height + 25
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let text = messages[indexPath.row].value(forKeyPath: "text") as? String else {
            return
        }
        
        guard let chatCell = cell as? BubbleCell else {
            return
        }
        
        chatCell.setLabelSize(messageText: text, type: chatCell.type)
    }
}

extension ChatViewController: ViewCode {
    func setupHierarchy() {
        view = customView
    }
    
    func setupConstraints() {
        //No constraints needed
    }
    
    func setupConfigurations() {
        view.backgroundColor = .white
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.scrollToBottom()
        customView.didTouchAtSendAction = sendMessage
    }
}
