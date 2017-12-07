//
//  ItemCell.swift
//  CATransform3D_Demo
//
//  Created by ulinix on 2017-12-07.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

let itemCellIdentifier = "ItemCell"

class ItemCell: UICollectionViewCell {

   
    
    lazy var imageView: UIImageView = {
        
        let image_Width = self.contentView.frame.size.width
        let image_height = self.contentView.frame.size.height / 3 * 2.3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image_Width , height: image_height))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLable = UILabel()
        titleLable.frame = CGRect(x: 5, y: self.imageView.frame.size.height + 5, width: contentView.frame.size.width-10, height: (contentView.frame.size.height - self.imageView.frame.size.height - 10)/2)
        titleLable.adjustsFontSizeToFitWidth = true
        titleLable.textAlignment = .right
        return titleLable
    }()
    
    lazy var subTitleLable: UILabel = {
        let subTitleLable = UILabel()
        subTitleLable.frame = CGRect(x: 5, y: self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, width: contentView.frame.size.width-10, height: self.titleLabel.frame.size.height)
        subTitleLable.adjustsFontSizeToFitWidth = true
        subTitleLable.textColor = UIColor.darkGray
        subTitleLable.textAlignment = .right
        return subTitleLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    
    
}


extension ItemCell {
    
    fileprivate func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLable)
        
    }
    
}
