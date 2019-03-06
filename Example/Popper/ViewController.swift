//
//  ViewController.swift
//  Popper
//
//  Created by mitulmanish on 03/06/2019.
//  Copyright (c) 2019 mitulmanish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var animator: UIViewControllerTransitioningDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        let newVC = UIViewController()
        newVC.view.backgroundColor = .red
        animator = DraggableTransitionDelegate()
        newVC.transitioningDelegate = animator
        newVC.modalPresentationStyle = .custom
        present(newVC, animated: true, completion: nil)
    }
}

