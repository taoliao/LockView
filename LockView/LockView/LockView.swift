//
//  LockView.swift
//  LockView
//
//  Created by corepress on 2018/9/5.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

protocol LockViewDelegate:NSObjectProtocol {

    func lockViewGestureRecognFinsh(lockView : LockView,password: String)
    
}

class LockView: UIView {

    lazy var selectBtn = Array<UIButton>()
    var curP = CGPoint.zero
    var delegate : LockViewDelegate?
    
    override func awakeFromNib() {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(pan:)))
        self.addGestureRecognizer(pan)
        
        for i in 0...8 {
            let btn = UIButton(type: .custom)
            btn.isUserInteractionEnabled = false
            btn.setImage(UIImage(named: "gesture_node_normal"), for: .normal)
            btn.setImage(UIImage(named: "gesture_node_highlighted"), for: .selected)
            btn.tag = i
            self.addSubview(btn)
        }
        
    }
    
    @objc func panAction(pan : UIPanGestureRecognizer) {
        
        curP = pan.location(in: self)
        
        for subView in self.subviews {
            
            let btn : UIButton = subView as! UIButton
            
            if btn.frame.contains(curP) && btn.isSelected == false{
                btn.isSelected = true
                
                self.selectBtn.append(btn)
              
            }
            
        }
        setNeedsDisplay()
        
        if pan.state == .ended {  //手指滑动结束 消除所有的线
        
            for btn in self.selectBtn {
                btn.isSelected = false
            }
            
            //MARK:储存手势
            var password = ""
            for btn in self.selectBtn {
                password.append("\(btn.tag)")
            }
            
           self.selectBtn.removeAll()
            
            let pass = UserDefaults.standard.object(forKey: "PASSWORD")
            
            guard let passwd = pass else { //没有设置手势密码
                UserDefaults.standard.set(password, forKey: "PASSWORD")
                return
            }
            
            if (passwd as! String) == password { //密码相同
                
                self.delegate?.lockViewGestureRecognFinsh(lockView: self, password: password)
                
            }else {
                print("密码错误")
            }
           
            
        }
        
    }

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()

        for i in 0..<self.selectBtn.count {
            let btn = selectBtn[i]
            if i == 0 {
                path.move(to: btn.center)
            }else {
                path.addLine(to: btn.center)
            }

        }
        path.addLine(to: curP)
        path.lineWidth = 10
        UIColor.green.set()
        path.lineJoinStyle = .round
        path.stroke()

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
