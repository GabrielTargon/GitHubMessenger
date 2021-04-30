//
//  CellType.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 27/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import UIKit

enum BubbleType {
    case incoming
    case outgoing
    
    var image: String {
        switch self {
        case .outgoing:
            return "left_bubble"
        case .incoming:
            return "right_bubble"
        }
    }
    
    var bubbleEdgeLeft: CGFloat {
        switch self {
        case .outgoing:
            return 20
        case .incoming:
            return 13
        }
    }
    
    var bubbleEdgeRight: CGFloat {
        switch self {
        case .outgoing:
            return 13
        case .incoming:
            return 20
        }
    }
}
