//
//  NameListCell.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 28/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import UIKit

class NameListCell: UITableViewCell {
    
    lazy var labelProfile: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageProfile: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}

extension NameListCell: ViewCode {
    func setupHierarchy() {
        addSubview(imageProfile)
        addSubview(labelProfile)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageProfile.heightAnchor.constraint(equalToConstant: 60),
            imageProfile.widthAnchor.constraint(equalToConstant: 60),
            imageProfile.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageProfile.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageProfile.trailingAnchor.constraint(equalTo: labelProfile.leadingAnchor, constant: -8),
            
            labelProfile.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor),
            labelProfile.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        ])
    }
    
    func setupConfigurations() {
        self.selectionStyle = .none
    }
}
