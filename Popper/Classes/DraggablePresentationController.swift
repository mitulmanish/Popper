//
//  DraggablePresentationController.swift
//  Popper
//
//  Created by Mitul Manish on 7/3/19.
//
extension CGFloat {
    static let springDampingRatio: CGFloat = 0.7
    static let springInitialVelocityY: CGFloat =  10
}

extension TimeInterval {
    static let animationDuration: Double = 0.3
}

@available(iOS 10, *)
public class DraggablePresentationController: UIPresentationController {
    
    private var draggableView: DraggableViewType? {
        return presentedViewController as? DraggableViewType
    }
    
    private var presentedViewOriginY: CGFloat {
        return presentedView?.frame.origin.y ?? 0
    }
    
    private var dragDirection: DragDirection = .up
    
    private var draggablePosition: DraggablePosition = .open {
        didSet {
            if draggablePosition == .open {
                draggableView?.handleInteraction(enabled: true)
            } else {
                draggableView?.handleInteraction(enabled: false)
            }
        }
    }
    
    private var animator: UIViewPropertyAnimator?
    
    private var maxFrame: CGRect {
        return CGRect(x: 0, y: 0, width: containerView?.bounds.width ?? 0, height: containerView?.bounds.height ?? 0)
    }
    
    private var panOnPresented = UIPanGestureRecognizer()
    
    private var containerViewGestureRecognizer = UITapGestureRecognizer()
    
    override public var frameOfPresentedViewInContainerView: CGRect {
        let presentedViewOrigin = CGPoint(x: 0, y: draggablePosition.yOrigin(for: maxFrame.height))
        let presentedViewSize = CGSize(width: containerView?.bounds.width ?? 0,
                                       height: containerView?.bounds.height ?? 0)
        return CGRect(origin: presentedViewOrigin, size: presentedViewSize)
    }
    
    override public func containerViewDidLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override public func presentationTransitionWillBegin() {
        draggableView?.handleInteraction(enabled: true)
    }
    
    override public func presentationTransitionDidEnd(_ completed: Bool) {
        animator = UIViewPropertyAnimator(duration: .animationDuration, curve: .easeInOut)
        animator?.isInterruptible = true
        panOnPresented = UIPanGestureRecognizer(target: self, action: #selector(userDidPan(panRecognizer:)))
        presentedView?.addGestureRecognizer(panOnPresented)
        containerViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(receivedTouch))
        containerView?.addGestureRecognizer(containerViewGestureRecognizer)
        animate(to: .open)
    }
    
    @objc private func receivedTouch(tapRecognizer: UITapGestureRecognizer) {
        let touchPointInPresentedView = tapRecognizer.location(in: presentedView)
        guard presentedView?.bounds.contains(touchPointInPresentedView) == false else { return }
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc private func userDidPan(panRecognizer: UIPanGestureRecognizer) {
        draggableView?.dismissKeyboard()
        let translationPoint = panRecognizer.translation(in: presentedView)
        let currentOriginY = draggablePosition.yOrigin(for: maxFrame.height)
        let newOffset = translationPoint.y + currentOriginY
        let adjustedOffset = (newOffset < 0) ? -1 * newOffset : newOffset
        
        dragDirection = adjustedOffset > currentOriginY ? .down : .up
        
        let canDragInProposedDirection = dragDirection == .up &&
            draggablePosition == .open ? false : true
        
        if newOffset >= 0 && canDragInProposedDirection {
            switch panRecognizer.state {
            case .began, .changed:
                presentedView?.frame.origin.y = max(DraggablePosition.open.yOrigin(for: maxFrame.height), adjustedOffset)
            case .ended:
                animate(max(DraggablePosition.open.yOrigin(for: maxFrame.height), adjustedOffset))
            default:
                break
            }
        }
    }
    
    private func animate(_ dragOffset: CGFloat) {
        let distanceFromBottom = maxFrame.height - dragOffset
        
        switch dragDirection {
        case .up:
            if distanceFromBottom > (maxFrame.height * DraggablePosition.open.upBoundary) {
                animate(to: .open)
            } else if distanceFromBottom > (maxFrame.height * DraggablePosition.midway.upBoundary) {
                animate(to: .midway)
            } else {
                animate(to: .collapsed)
            }
        case .down:
            if distanceFromBottom > (maxFrame.height * DraggablePosition.open.downBoundary) {
                animate(to: .open)
            } else if distanceFromBottom > (maxFrame.height * DraggablePosition.midway.downBoundary) {
                animate(to: .midway)
            } else {
                animate(to: .collapsed)
            }
        }
    }
    
    private func getDraggablePosition() -> DraggablePosition {
        let distanceFromBottom = maxFrame.height - presentedViewOriginY
        
        switch dragDirection {
        case .up:
            if distanceFromBottom > (maxFrame.height * DraggablePosition.open.upBoundary) {
                return .open
            } else if distanceFromBottom > (maxFrame.height * DraggablePosition.midway.upBoundary) {
                return .midway
            } else {
                return .collapsed
            }
        case .down:
            if distanceFromBottom > (maxFrame.height * DraggablePosition.open.downBoundary) {
                return .open
            } else if distanceFromBottom > (maxFrame.height * DraggablePosition.midway.downBoundary) {
                return .midway
            } else {
                return .collapsed
            }
        }
    }
    
    private func animate(to position: DraggablePosition) {
        guard let animator = animator else { return }
        
        animator.addAnimations {
            self.presentedView?.frame.origin.y = position.yOrigin(for: self.maxFrame.height)
        }
        
        animator.addCompletion { _ in
            self.draggablePosition = position
        }
        animator.startAnimation()
    }
}
