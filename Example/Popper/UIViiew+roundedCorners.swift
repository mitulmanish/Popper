//
//  UIViiew+roundedCorners.swift
//  Popper_Example
//
//  Created by Mitul Manish on 7/3/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
    // Simplified and adapted from https://stackoverflow.com/questions/29618760/create-a-rectangle-with-just-two-rounded-corners-in-swift/35621736#35621736
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

