//
//  DraggablePosition.swift
//  Popper
//
//  Created by Mitul Manish on 7/3/19.
//

enum DraggablePosition {
    case open
    case midway
    case collapsed
    
    var heightMulitiplier: CGFloat {
        switch self {
        case .collapsed:
            return 0.2
        case .open:
            return 0.80
        case .midway:
            return 0.5
        }
    }
    
    var downBoundary: CGFloat {
        switch self {
        case .collapsed:
            return 0.0
        case .open:
            return 0.8
        case .midway:
            return 0.35
        }
    }
    
    var upBoundary: CGFloat {
        switch self {
        case .collapsed:
            return 0.0
        case .open:
            return 0.65
        case .midway:
            return 0.27
        }
    }
    
    func yOrigin(for maxHeight: CGFloat) -> CGFloat {
        return maxHeight - (maxHeight * heightMulitiplier)
    }
}
