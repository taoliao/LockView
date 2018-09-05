//
//  ViewController.swift
//  LockView
//
//  Created by corepress on 2018/9/5.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class ViewController: UIViewController,LockViewDelegate {

    @IBOutlet weak var lockView: LockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lockView.delegate = self
        
    }

    func lockViewGestureRecognFinsh(lockView : LockView,password: String) {
        
        print(password,lockView)
        
        self.present(ContentViewController(), animated: true, completion: nil)
        
    }

}

