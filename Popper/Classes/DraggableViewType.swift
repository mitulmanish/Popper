//
//  DraggableViewType.swift
//  Popper
//
//  Created by Mitul Manish on 7/3/19.
//

public protocol DraggableViewType: class {
    var scrollView: UIScrollView { get }
    func dismissKeyboard()
    func handleInteraction(enabled: Bool)
}
