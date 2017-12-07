//
//  CollectionCell.swift
//  CATransform3D_Demo
//
//  Created by ulinix on 2017-12-07.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

let collectionCell_Identifier = "CollectionCell"


class CollectionCell: UICollectionViewCell {
    
    var data_Source: [String]!
    
    
    lazy var collection: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        let width = (contentView.frame.size.width - 30) / 2
        let height = width * 1.5
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collection = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.data_Source = [String]()
        
        collection.register(ItemCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
        contentView.addSubview(collection)
        print("调用了....")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data_Source {
            return data.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as? ItemCell
        cell?.backgroundColor = UIColor.groupTableViewBackground
        cell?.imageView.image = UIImage(named: "lw")
//        cell?.titleLabel.text = "\(data_Source[indexPath.row])"
        cell?.subTitleLable.text = "维密超模"
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
}







