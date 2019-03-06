//
//  DraggableTransitionDelegate.swift
//  Popper_Example
//
//  Created by Mitul Manish on 7/3/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
import UIKit
import Popper

class DraggableTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DraggablePresentationController(presentedViewController: presented, presenting: source)
    }
}
