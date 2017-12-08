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
    
    
   fileprivate lazy var data_Source: NSMutableArray = {
       let array = NSMutableArray()
        return array
    }()
    
    //网络请求标签类型ID(假设为0)
     var type: NSInteger?
    //网络请求页码(默认为1)
    fileprivate var page: NSInteger = 1
    
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
        collection.register(ItemCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
        contentView.addSubview(collection)
        return collection
    }()
    
    func configureCellData(_ dataSource: NSMutableArray?) {
        guard let data = dataSource else { return  }
        
        guard self.type != nil else { return }
        
        page = 1
        self.data_Source = data
        setUpMJRefreshView()
        self.collection.reloadData()

    }
    
    
    fileprivate func setUpMJRefreshView() {

        print("网络请求: self.type = \(String(describing: self.type))")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_Source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as? ItemCell
        cell?.backgroundColor = UIColor.groupTableViewBackground
        cell?.imageView.image = UIImage(named: "\(data_Source[indexPath.row])")
        cell?.titleLabel.text = "\(data_Source[indexPath.row])"
        cell?.subTitleLable.text = "😍😍😍😍😍😍维密超模"
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
}







