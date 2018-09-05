//
//  BackgroundView.swift
//  LockView
//
//  Created by corepress on 2018/9/5.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class BackgroundView: UIView {


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
       
        let image = UIImage(named: "Home_refresh_bg")
        
        image?.draw(in: rect)
    }


}
