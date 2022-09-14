//
//  NamesListView.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 14/09/22.
//  Copyright © 2022 Gabriel Targon. All rights reserved.
//

import UIKit

final class NamesListView: UIView {
    
    var cellIdentifier = String(describing: NameListCell.self)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NameListCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndicator.style = .large
        activityIndicator.center = self.center
        activityIndicator.backgroundColor = .white
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
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
}

extension NamesListView: ViewCode {
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(indicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
