//
//  ChatView.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 19/05/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import UIKit
import CoreData

final class ChatView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var sendMessageView: SendMessageView = {
        let view = SendMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        view.sendButton.addTarget(self, action: #selector(didTouchAtSend), for: .touchUpInside)
        return view
    }()
    
    lazy var grayBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    var didTouchAtSendAction: (() -> Void)?
    
    private var keyboardSize = CGRect.zero
    private var sendMessageViewBottomConstraint = NSLayoutConstraint()
    
    // MARK: Lifecycle
    
    init() {
        super.init(frame: .zero)
        setupView()
        UIViewController().loadViewIfNeeded()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func sendMessage(messages: [NSManagedObject]) {
        tableView.reloadData()
        
        sendMessageView.textField.text = nil
        sendMessageView.sendButton.isEnabled = false
        tableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
    }
    
    // MARK: Actions
    
    @objc func editingChanged(sender: UITextField) {
        guard let name = sendMessageView.textField.text, !name.isEmpty else {
            sendMessageView.sendButton.isEnabled = false
            return
        }
        
        sendMessageView.sendButton.isEnabled = true
    }
    
    @objc func didTouchAtSend() {
        didTouchAtSendAction?()
    }
    
    // MARK: Keyboard behaviour

    @objc func keyboardDidShow(_ notification: NSNotification) {
        guard let info = notification.userInfo else{
            return
        }
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardSize = keyboardFrame
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let info = notification.userInfo {
            let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            sendMessageViewBottomConstraint.constant = -keyboardFrame.height + grayBottomView.frame.height
        }
    }

    @objc func keyboardDidHide(_ notification: NSNotification) {
        keyboardSize = CGRect.zero
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        sendMessageViewBottomConstraint.constant = 0
    }
}

extension ChatView: ViewCode {
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(sendMessageView)
        addSubview(grayBottomView)
    }
    
    func setupConstraints() {
        sendMessageViewBottomConstraint = NSLayoutConstraint(item: sendMessageView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            sendMessageView.heightAnchor.constraint(equalToConstant: 60),
            sendMessageView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            sendMessageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sendMessageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sendMessageViewBottomConstraint,
            
            grayBottomView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            grayBottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            grayBottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            grayBottomView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupConfigurations() {
        backgroundColor = .white
        
        // TableView
        tableView.register(BubbleCell.self, forCellReuseIdentifier: BubbleCell.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.allowsSelection = false
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}
