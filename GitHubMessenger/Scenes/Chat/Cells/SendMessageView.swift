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
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Type text here"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        button.isEnabled = false
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
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.topAnchor.constraint(equalTo: textField.topAnchor),
            sendButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func setupConfigurations() {
        self.backgroundColor = .systemGray5
    }
}
