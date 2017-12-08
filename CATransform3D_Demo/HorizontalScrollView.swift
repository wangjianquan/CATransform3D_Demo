//
//  HorizontalScrollView.swift
//  CATransform3D_Demo
//
//  Created by ulinix on 2017-12-07.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit



class HorizontalScrollView: UIView {

    let btnSpace = 8
    let line_width : CGFloat = 15
    let line_Height: CGFloat = 8
    
    
    var btnCallBack: ((_ seleected_Index: NSInteger) -> ())?
    
    var title_NorColor: UIColor = UIColor.black
    var title_SelectColor: UIColor = UIColor.purple
    
    
    
    
    lazy var itemScrollView: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0 , width: self.frame.size.width, height: self.frame.size.height))
        scroll.backgroundColor = UIColor.white
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = true
        scroll.bounces = true
        return scroll
    }()
    var line: UIView!
    var allItem: NSMutableArray
    
    var btn_center_X = 0
    
    
    var titles: NSMutableArray! {
        
        didSet{
            
            let item_Width = self.frame.size.width / CGFloat(titles.count)
            let item_height = self.itemScrollView.frame.size.height - 10
            for i in 0..<titles.count {
                
                let  btn = UIButton(type: .custom)
                btn.frame = CGRect(x:  CGFloat(i) * (item_Width + CGFloat(btnSpace) ) + CGFloat(btnSpace), y: 5, width: item_Width, height: item_height)
                btn.setTitle((titles[i] as! String), for: .normal)
                btn.setTitleColor(title_NorColor, for: .normal)
                btn.setTitleColor(title_SelectColor, for: .selected)
                btn.backgroundColor = UIColor(white: 0.95, alpha: 0.95)

                btn.layer.cornerRadius = 3
                btn.layer.masksToBounds = true
                btn.tag = 100 + i
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
               
                itemScrollView.addSubview(btn)
                allItem.add(btn)
               
               
               
            }
           itemScrollView.contentSize = CGSize(width: CGFloat(Int(item_Width) * titles.count + (titles.count + 1) * btnSpace), height: self.itemScrollView.frame.size.height)
            
            /*
            line = UIView(frame: CGRect(x: (item_Width + CGFloat(btnSpace))/2, y: self.frame.size.height-line_Height, width: line_width, height: line_Height))
            line.backgroundColor = UIColor.black
            addSubview(line)
         */
        }
    }
     var lastIndex: NSInteger = 0
    
    var currentIndex: NSInteger{
        didSet{
            let btn = self.allItem[currentIndex] as? UIButton
            btn?.isSelected = true
            
            if currentIndex != self.lastIndex {
                var lastBtn = UIButton()
                lastBtn = self.allItem[lastIndex] as! UIButton
                lastBtn.isSelected = false
                self.lastIndex = currentIndex
                
                /*
                let width = self.frame.size.width / CGFloat(titles.count)
                let height = self.frame.size.height
                let line_X =  CGFloat(self.currentIndex) * (width + CGFloat(btnSpace)) + (width - self.line_width - CGFloat(btnSpace)-CGFloat(btnSpace))
//
                UIView.animate(withDuration: 0.2, animations: {
                    self.line.frame = CGRect(x:line_X, y: height - self.line_Height, width: self.line_width, height: self.line_Height)
                   
                })
               */
                
                if btnCallBack != nil  {
                    btnCallBack!(currentIndex)
                }
                
                
            }
            
        }
        
    }
    
    override init(frame: CGRect) {
        self.allItem = NSMutableArray()
        self.currentIndex = 0

        
        super.init(frame: frame)
        self.titles = NSMutableArray()
       

        
        addSubview(itemScrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}



extension HorizontalScrollView  {
    
    @objc fileprivate func btnClick (_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
//        if btnCallBack != nil  {
//            btnCallBack!(sender.tag - 100)
//        }
        self.currentIndex = sender.tag - 100
    }
    
}










