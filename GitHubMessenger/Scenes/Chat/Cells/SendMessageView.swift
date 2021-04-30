//
//  SendMessageView.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 28/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import UIKit

class SendMessageView: UIView {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type text here"
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}

extension SendMessageView: ViewCode {
    func setupHierarchy() {
        addSubview(textField)
        addSubview(sendButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60),
            
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 13),
            textField.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor),
            
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 13),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 13)
        ])
    }
}
