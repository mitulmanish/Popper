//
//  DraggableViewType.swift
//  Popper
//
//  Created by Mitul Manish on 7/3/19.
//

public protocol DraggableViewType: class {
    func dismissKeyboard()
    func handleInteraction(enabled: Bool)
    var scrollView: UIScrollView { get }
}
