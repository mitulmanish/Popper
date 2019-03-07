//
//  CurvedButton.swift
//  Popper_Example
//
//  Created by Mitul Manish on 7/3/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class CurvedButton: UIButton {
    override func awakeFromNib() {
        round(corners: [.allCorners], radius: 8)
    }
}
