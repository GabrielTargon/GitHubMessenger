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
    //Architecture variables
    typealias ChatRoutingProtocol = ChatRoutingLogic & ChatDataPassing
    var interactor: ChatBusinessLogic?
    var router: (ChatRoutingProtocol)?
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var sendMessageTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    //Constraints
    @IBOutlet weak var sendMessageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendMessageViewBottomConstraint: NSLayoutConstraint!
    
    //Variables
    var user = String()
    private var messages: [NSManagedObject] = []
    private let sendMessageViewHeight: CGFloat = 60
    private let sendMessageViewHeightIphoneXAndLater: CGFloat = 94
    private let sendMessageViewWidth: CGFloat = UIScreen.main.bounds.width
    private var isKeyboardVisible: Bool = false
    private var willDismissKeyboard: Bool = false
    private var keyboardSize: CGRect = CGRect.init(x: 0, y: 0, width: 0, height: 0)
    private var cellIdentifier = String(describing: BubbleCell.self)
    
    // MARK: Object lifecycle
    
    class func instantiateNew() -> ChatViewController {
        guard let viewController = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as? ChatViewController
            else { fatalError("Couldn't instantiate \(String(describing: self))") }
        return viewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Setup
    
    func setup(interactor: ChatBusinessLogic? = nil, router: ChatRoutingProtocol? = nil) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Functions
    
    func getInfos() {
        guard let userLogin = interactor?.returnUserLogin(),
              let msg = interactor?.getMessages() else {
            return
        }
        
        user = userLogin
        messages = msg
    }
    
    private func adjustSendMessageViewForKeyboardAndScreenSize() {
        if let content = self.sendMessageView {
            if UIDevice.current.screenType == .iPhonesX {
                content.frame = CGRect.init(x: 0, y: (UIScreen.main.bounds.height - sendMessageViewHeightIphoneXAndLater), width: sendMessageViewWidth, height: sendMessageViewHeightIphoneXAndLater)
                sendMessageViewHeightConstraint.constant = sendMessageViewHeightIphoneXAndLater
            } else {
                content.frame = CGRect.init(x: 0, y: (UIScreen.main.bounds.height - sendMessageViewHeight), width: sendMessageViewWidth, height: sendMessageViewHeight)
                sendMessageViewHeightConstraint.constant = sendMessageViewHeight
            }
        }
    }
    
    private func sendOutgoingMessage(_ message: String) {
        interactor?.saveMessage(request: Chat.Message.Request(text: message, type: .outgoing, date: Date(), friend: user))
        tableView.reloadData()
    }
    
    @objc func editingChanged(sender: UITextField) {
        guard let name = sendMessageTextField.text, !name.isEmpty else {
            sendMessageButton.isEnabled = false
            return
        }
        
        sendMessageButton.isEnabled = true
    }
    
    private func scrollToBottom() {
        let point = CGPoint(x: 0, y: tableView.contentSize.height + tableView.contentInset.bottom - tableView.frame.height)
        if point.y >= 0 {
            tableView.setContentOffset(point, animated: true)
        }
        tableView.layoutIfNeeded()
    }
    
    // MARK: Keyboard behaviour

    @objc func keyboardDidShow(_ notification: NSNotification) {
        isKeyboardVisible = true
        guard let info = notification.userInfo else{
            return
        }
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardSize = keyboardFrame
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            sendMessageViewHeightConstraint.constant = sendMessageViewHeight
            sendMessageViewBottomConstraint.constant = keyboardFrame.height
            scrollToBottom()
        }
    }

    @objc func keyboardDidHide(_ notification: NSNotification) {
        isKeyboardVisible = false
        willDismissKeyboard = false
        keyboardSize = CGRect.init(x: 0, y: 0, width: 0, height: 0)
        adjustSendMessageViewForKeyboardAndScreenSize()
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        sendMessageViewBottomConstraint.constant = 0
    }
    
    // MARK: Actions
    
    @IBAction func sendMessage(_ sender: Any) {
        if let text = sendMessageTextField.text {
            interactor?.saveMessage(request: Chat.Message.Request(text: text, type: .incoming, date: Date(), friend: user))
            
            sendOutgoingMessage(text)
            
            sendMessageTextField.text = nil
            sendMessageButton.isEnabled = false
            scrollToBottom()
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
                let incomingCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! BubbleCell
                incomingCell.type = .incoming
                return incomingCell
            } else if typeMsg.value(forKeyPath: "type") as? String == "outgoing" {
                let outgoingCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! BubbleCell
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
        // No hierarchy needed
    }
    
    func setupConstraints() {
        // No constraints needed
    }
    
    func setupConfigurations() {
        interactor?.getMessages()
        getInfos()
        
        title = user
        
        // TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(BubbleCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        
        // Actions
        sendMessageTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        adjustSendMessageViewForKeyboardAndScreenSize()
    }
}
