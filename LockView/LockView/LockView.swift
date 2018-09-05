//
//  LockView.swift
//  LockView
//
//  Created by corepress on 2018/9/5.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class LockView: UIView {

    override func awakeFromNib() {
        
        for _ in 0...8 {
            
            let btn = UIButton(type: .custom)
            
            btn.setImage(UIImage(named: "gesture_node_normal"), for: .normal)
            btn.setImage(UIImage(named: "gesture_node_highlighted"), for: .selected)
            
            self.addSubview(btn)
        }
        
    }

    //在layoutSubviews设置btn的frame，因为此时父控件的frame已经确定
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = self.subviews.count
        
        var x : CGFloat = 0
        var y : CGFloat = 0
        let w : CGFloat = 74
        let h : CGFloat = 74
        
        let cols = 3; //行数
        
        let margin = (self.bounds.width - CGFloat(cols)*w) / CGFloat(cols + 1) //间距
        var col : CGFloat = 0
        var row : CGFloat = 0
        
        var maxY : CGFloat = 0
        for i in 0...count-1 {
            let btn = self.subviews[i]
            
            col = CGFloat(i % cols)
            row = CGFloat(i / cols)
            x = margin + col*(margin + w)
            y = row * (margin + w)
            
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            
            if i == count - 1 {
                maxY = btn.frame.maxY
            }
        }
        
        self.frame = CGRect(x: 0, y: ((self.superview?.bounds.height)!-maxY)*0.5, width: (self.superview?.bounds.width)!, height: maxY)
        
    }
    

}
