//
//  CellInstantiatable.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 19/05/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import Foundation

protocol CellInstantiatable {
    static var cellIdentifier: String { get }
}

extension CellInstantiatable {
    static var cellIdentifier: String {
        return String(describing: type(of: self))
    }
}
