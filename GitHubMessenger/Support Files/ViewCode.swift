//
//  ViewCode.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 27/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import Foundation

protocol ViewCode {
    
    /// Creation of the views hierarchy
    func setupHierarchy()
    
    /// Creation and activation of constraints
    func setupConstraints()
    
    /// Configurations of the view
    func setupConfigurations()
}

extension ViewCode {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }
    
    func setupConfigurations() {
        // Default implementation
    }
}
