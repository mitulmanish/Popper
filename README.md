# Popper

[![CI Status](https://img.shields.io/travis/mitulmanish/Popper.svg?style=flat)](https://travis-ci.org/mitulmanish/Popper)
[![Version](https://img.shields.io/cocoapods/v/Popper.svg?style=flat)](https://cocoapods.org/pods/Popper)
[![License](https://img.shields.io/cocoapods/l/Popper.svg?style=flat)](https://cocoapods.org/pods/Popper)
[![Platform](https://img.shields.io/cocoapods/p/Popper.svg?style=flat)](https://cocoapods.org/pods/Popper)

## What it does ?

`Popper` helps you create a draggable View Controller.

What does `Draggable` mean in this context?.
`Draggable`: The presented view will have ability to be vertically dragged across the screen. You will be able to use the pan gestures to move the presented view through different draggable states.

The presented View is going to have three draggable or sticky states
  - Open
  - Midway
  - Collapsed
  
This sort of UI is specially useful when you would like to create a reactive app where changes in a modally presented view are reflected in the presenting view.

For example:

<img src="https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/Crypt.png?alt=media&token=61481727-50d3-4ec4-a45f-3c25a36ea648)" width="200" height="400">

It can be seen in the screenshot above 👆🏼, the selection from the coin list, is reflected on the backing view

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- Xcode 10.0+
- iOS 10.0+
- Swift 4.2+

## GIF
![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/Popper.gif?alt=media&token=9df72f10-b973-405e-a8a9-52e3a0666b7d)

## UI States

|Open|Mid way|Collapsed|
|---|---|---|
|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/open.png?alt=media&token=9d429613-70ef-4fce-8df4-09a1523a2be5)|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/midway.png?alt=media&token=6a94d279-dd99-4f91-a0c3-4a4d8bee4546)|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/collapsed.png?alt=media&token=e12d2016-426a-46de-82c7-0528ad3ba9aa)|

## Setup

Start of by creating a `Animator` class

```
import UIKit
import Popper

class DraggableTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DraggablePresentationController(presentedViewController: presented, presenting: source)
    }
}
```

Now we will use the `Animator` class as a `transitionDelegate` for the presented view controller

example:

```
        let fruitsViewController = DraggableViewController()
        animator = DraggableTransitionDelegate()
        fruitsViewController.transitioningDelegate = animator
        fruitsViewController.modalPresentationStyle = .custom
        present(fruitsViewController, animated: true, completion: .none)
```

Now you are all set.

## Installation

Popper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Popper'
```

## Author

mitulmanish, mitul.manish@gmail.com

## License

Popper is available under the MIT license. See the LICENSE file for more info.

