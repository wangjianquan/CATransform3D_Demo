//
//  ViewController.swift
//  CATransform3D_Demo
//
//  Created by ulinix on 2017-12-05.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

let navigationBar_Height: CGFloat = 44
let stateBar_height: CGFloat = 20





class ViewController: UIViewController, UIScrollViewDelegate {

    
    var showListMaxDt: CGFloat? //最大滑动距离
    
    //背景图
    lazy var showImageView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: navigationBar_Height + stateBar_height, width: self.view.frame.size.width, height: self.view.frame.size.height - 110 - navigationBar_Height - stateBar_height))
        imageview.isUserInteractionEnabled = true
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(named: "lw")
        return imageview
    }()
    
    //背景图文字描述
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(white: 0.96, alpha: 0.9)
        label.shadowColor = UIColor.white
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.text = "维密超模——刘雯"
        label.sizeToFit()
        var frame = label.frame
        frame.origin = CGPoint(x: 12, y: self.showImageView.frame.size.height - 20)
        label.frame = frame
        
        return label
    }()
    
    //蒙版
    lazy var maskview: UIView = {
       let maskview = UIView(frame: self.view.bounds)
        maskview.backgroundColor = UIColor.black
        maskview.isUserInteractionEnabled = true
        maskview.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(showListViewClick(_:)))
        maskview.addGestureRecognizer(tap)
        return maskview
    }()
    
    //展示的 view
    lazy var showListView: UIView = {
        let listView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 110, width: self.view.frame.size.width, height: self.view.frame.size.height - 116))
        listView.backgroundColor = UIColor.black
        listView.alpha = 1.0
        self.showListMaxDt = listView.frame.origin.y - 116
       
        return listView
    }()
    
    
    //方向图标
    lazy var arrowView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: self.showListView.frame.size.width, height: 26))
        imageview.isUserInteractionEnabled = true
        imageview.tag = 101
        imageview.contentMode = .center
        imageview.image = UIImage(named: "TMWuse_up")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showListViewClick(_:)))
        imageview.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(showListViewPan(_:)))
        imageview.addGestureRecognizer(pan)
        
        return imageview
    }()
    

   
    //是否展开
    var isShow: Bool = false{
        didSet {
            let imageView = self.showListView.viewWithTag(101) as! UIImageView
            if isShow == true {
                imageView.image = UIImage(named: "TMWuse_Beacon")
            }else {
                imageView.image = UIImage(named: "TMWuse_up")
            }
        }
    }
    
    //是否完成缩小动画(默认未缩放)
    var narrow: Bool = false
    var itemBtnTitles : NSMutableArray = NSMutableArray(array: ["1😆","2😍","3😊","4😎","5👏","6😙"])
    
    //滚动标签
    lazy var horiScrollView: HorizontalScrollView = {
        let scroll = HorizontalScrollView(frame: CGRect(x: 0, y: arrowView.frame.size.height, width: self.showListView.frame.size.width, height: 66))
        scroll.titles = itemBtnTitles
        
        return scroll
    }()
    
    //横向滑动的 UICollectionView
    lazy var horizontalCollection: UICollectionView = {
        
        let height = self.showListView.frame.size.height  - self.arrowView.frame.size.height - self.horiScrollView.frame.size.height
        let width = self.showListView.frame.size.width
        let X : CGFloat = 0
        let Y = self.arrowView.frame.size.height + self.horiScrollView.frame.size.height
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal//横向滑动
        
        let collection = UICollectionView(frame: CGRect(x: X, y: Y, width: width, height: height), collectionViewLayout: layout)
        
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        return collection
    }()
    
    
    lazy var dataSource: NSMutableArray = NSMutableArray(array: ["刘雯_01","刘雯_02","刘雯_03","刘雯_04","刘雯_05"])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "美丽女孩儿"
        self.view.addSubview(self.showImageView)
        self.showImageView.addSubview(self.descLabel)
        self.view.addSubview(self.maskview)
        self.view.addSubview(self.showListView)
        self.showListView.addSubview(self.arrowView)
        self.showListView.addSubview(self.horiScrollView)
        self.showListView.addSubview(self.horizontalCollection)
    
        horizontalCollection.register(CollectionCell.self, forCellWithReuseIdentifier: collectionCell_Identifier)
        
        
        horiScrollView.btnCallBack = {[weak self] (selected_Index) in
            self?.horizontalCollection.contentOffset = CGPoint(x: CGFloat(selected_Index) * (self?.horizontalCollection.frame.size.width)!, y: 0)
           
            print("选中第 \(selected_Index) 个按钮")
        }

        
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let offset_Y = scrollView.contentOffset.x/self.horizontalCollection.frame.size.width
        //设置按钮的状态和line的位置
        self.horiScrollView.currentIndex = NSInteger(offset_Y)

        print("停止滚动 currentIndex = \(self.horiScrollView.currentIndex)")
    }

   
}




// MARK : -- UITableView 代理方式实现
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemBtnTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell_Identifier, for: indexPath) as! CollectionCell
        cell.type = self.horiScrollView.currentIndex
        cell.configureCellData(dataSource)
        return cell
        
    }
    
    
}





//MARK: -- 动画部分
extension ViewController {
    
    func tapClickTransform3DAnimationProcess_first() {
        let layer : CALayer = self.showImageView.layer
        layer.zPosition = -200
        var rotationTransform = CATransform3DIdentity
        rotationTransform.m34 = 1.0 / 300
        rotationTransform = CATransform3DTranslate(rotationTransform, 0, -(navigationBar_Height * 0.9), 0)
        rotationTransform = CATransform3DScale(rotationTransform, 0.9, 0.9, 1)
        rotationTransform = CATransform3DRotate(rotationTransform, CGFloat(-12 * .pi / 180.0), 1.0, 0.0, 0.0)
        self.showImageView.layer.transform = rotationTransform
    }
    
    func CATransitionform3DAnimationProcess_Second() {
        let layer: CALayer = self.showImageView.layer
        layer.zPosition = -200
        var rotationTransform = CATransform3DIdentity
        rotationTransform.m34 = 1.0 / 300
        rotationTransform = CATransform3DTranslate(rotationTransform, 0,  -navigationBar_Height * 1.8 , 0)
        rotationTransform = CATransform3DScale(rotationTransform, 0.8 , 0.8, 1);
        rotationTransform = CATransform3DRotate(rotationTransform, 0.0, 1.0, 0.0, 0.0);
        self.showImageView.layer.transform = rotationTransform
    }
    
    func CATransitionform3DAnimation_Identity() {
        let layer : CALayer = self.showImageView.layer
        layer.zPosition = -200
        var rotationTransform = CATransform3DIdentity
        rotationTransform = CATransform3DTranslate(rotationTransform, 0, 0, 0)
        rotationTransform = CATransform3DScale(rotationTransform, 1.0, 1.0, 1)
        rotationTransform = CATransform3DRotate(rotationTransform, 0.0 ,1.0, 0.0, 0.0)
        self.showImageView.layer.transform = rotationTransform
    }
    
    @objc func showListViewClick(_ gesture: UITapGestureRecognizer) {
        
        if self.isShow {
            //未展开
            self.isShow = false
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 0.5, animations: {
                self.showListView.frame = CGRect(x: 0, y: self.view.frame.size.height - 110, width: self.view.frame.size.width, height: self.view.frame.size.height - 116)
                self.maskview.alpha = 0
            })
            //恢复原状
            self.showImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.showImageView.frame = CGRect(x: 0, y: navigationBar_Height + stateBar_height, width: self.showImageView.frame.size.width, height: self.showImageView.frame.size.height)
           
            //缩小动画
            self.narrow = false
            
            
            //动画
            UIView.animate(withDuration: 0.25, animations: {
                self.tapClickTransform3DAnimationProcess_first()
            }, completion: { (_) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.CATransitionform3DAnimation_Identity()
                })
            })
            
            
        } else { //展开
            self.isShow = true
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            //蒙版动画
            UIView.animate(withDuration: 0.5, animations: {
                self.showListView.frame = CGRect(x: 0, y: 116, width: self.showListView.frame.size.width, height: self.showListView.frame.size.height)
                self.maskview.alpha = 0.6
            })
            
            UIView.animate(withDuration: 0.25, animations: {
                self.tapClickTransform3DAnimationProcess_first()
            }, completion: { (_) in
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.CATransitionform3DAnimationProcess_Second()
                }, completion: { (_) in
                    //改变原状
                    let top = self.showImageView.frame.origin.y
                    let left = self.showImageView.frame.origin.x
                    var rotationTransform = CATransform3DIdentity
                    rotationTransform = CATransform3DScale(rotationTransform, 1, 1, 1);
                    self.showImageView.layer.transform = rotationTransform;
                    self.showImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
                    self.showImageView.frame = CGRect(x:left, y:top, width: self.showImageView.frame.size.width, height: self.showImageView.frame.size.height)
                    self.narrow = true
                })
            })
        }
    }
    
    
    
    
    
    
    @objc func showListViewPan(_ gesture: UIPanGestureRecognizer){
        
        var startPoint_Y: CGFloat = 0
        var changePoint_Y : CGFloat = 0
        var viewPoint_Y : CGFloat = 0
        
        
        switch gesture.state {
        case .began:
            startPoint_Y = gesture.location(in: self.view.window).y
            viewPoint_Y = self.showListView.frame.origin.y
        case .changed:
            changePoint_Y = gesture.location(in: self.view.window).y
            var move_y = viewPoint_Y + (changePoint_Y - startPoint_Y)
            if move_y > self.view.bounds.size.height - 110{
                move_y = self.view.bounds.size.height - 110
            }else if move_y < 116 {
                move_y = 116
            }
            self.showListView.frame = CGRect(x: self.showListView.frame.origin.x, y: move_y, width: self.showListView.frame.size.width, height: self.showListView.frame.size.height)
            self.showPicViewChangeProgress(((self.view.bounds.size.height - 116) - self.showListView.frame.origin.y)/self.showListMaxDt!)
            gesture.setTranslation(CGPoint.zero, in: self.view.window)
            
        case .ended:
            
            self.showPicViewAnimationProgress(((self.view.bounds.size.height - 116) - self.showListView.frame.origin.y)/self.showListMaxDt!)
        default:
            break;
        }
    }


    func showPicViewChangeProgress(_ progress: CGFloat) {
        if progress > 1 || progress < 0 {
            return
        }
        if self.narrow { //是否完成缩小动画
            self.showImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.showImageView.frame = CGRect(x: 0, y: navigationBar_Height + stateBar_height, width: self.showImageView.frame.size.width, height: self.showImageView.frame.size.height)
            self.narrow = false
        }
        
        self.maskview.alpha = 0.6 * progress
        
        if (progress <= 0.5) {
            if (self.navigationController?.isNavigationBarHidden)!{
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
            let layer: CALayer = self.showImageView.layer
            layer.zPosition = -200
            
            var rotationTransform = CATransform3DIdentity
            rotationTransform.m34 = 1.0 / 300;
            rotationTransform = CATransform3DTranslate(rotationTransform, 0, CGFloat(-navigationBar_Height*progress*1.8), 0);
            rotationTransform = CATransform3DScale(rotationTransform, 1.0-(0.2 * progress), 1.0-(0.2 * progress), 1);
            rotationTransform = CATransform3DRotate(rotationTransform, CGFloat(-(24*progress) * CGFloat(Double.pi/180.0)), 1.0, 0.0, 0.0);
            self.showImageView.layer.transform = rotationTransform
        } else {
           
            if !((self.navigationController?.isNavigationBarHidden)!){
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
            
            let layer : CALayer = self.showImageView.layer
            layer.zPosition = -200;
           
            var rotationTransform = CATransform3DIdentity
            rotationTransform.m34 = 1.0 / 300
            rotationTransform = CATransform3DTranslate(rotationTransform, 0, CGFloat(-navigationBar_Height * progress * 1.8), 0)
            rotationTransform = CATransform3DScale(rotationTransform, CGFloat(1.0 - (0.2 * progress)), CGFloat(1.0 - (0.2 * progress)), 1)
            rotationTransform = CATransform3DRotate(rotationTransform, CGFloat(-(12 - 24*(progress - 0.5))*CGFloat(Double.pi/180.0)), 1.0, 0.0, 0.0)
            self.showImageView.layer.transform = rotationTransform
        }
        
    }



    func showPicViewAnimationProgress(_ progress: CGFloat)  {
        
        if progress <= 0.5 {
            UIView.animate(withDuration: 0.25, animations: {
                self.CATransitionform3DAnimation_Identity()
                self.showListView.frame = CGRect(x:0,y: self.view.bounds.size.height - 110,width: self.view.bounds.size.width, height:self.view.bounds.size.height - 116)
                self.maskview.alpha = 0
            },completion: { (_) in
                self.narrow = false
                self.isShow = false
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.CATransitionform3DAnimationProcess_Second()
                self.showListView.frame = CGRect(x:0,y: 116,width: self.showListView.bounds.size.width, height:self.showListView.bounds.size.height)
                self.maskview.alpha = 0.6
            }, completion: { (_) in
                
                //改变原状
                let top = self.showImageView.frame.origin.y
                let left = self.showImageView.frame.origin.x
                let layer : CALayer = self.showImageView.layer
                layer.zPosition = -200
                
                var rotationTransform = CATransform3DIdentity
                rotationTransform = CATransform3DScale(rotationTransform, 1, 1, 1);
                self.showImageView.layer.transform = rotationTransform;
                self.showImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
                self.showImageView.frame = CGRect(x:left, y:top, width: self.showImageView.frame.size.width, height: self.showImageView.frame.size.height)
                self.narrow = true
                self.isShow = true
            })
        }
        
        
    }

}
























