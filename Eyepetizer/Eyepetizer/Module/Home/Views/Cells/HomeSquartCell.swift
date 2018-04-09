//
//  HomeSquartCell.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/4/8.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

protocol ConfigCellDataProtocol {
    func config(data:JSON);
}

class HomeSquartCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,ConfigCellDataProtocol,UICollectionViewDelegateFlowLayout {

    fileprivate lazy var weekdayLabel:UILabel = {
        let weekLabel = UILabel.init();
        weekLabel.font = UIFont.fontType(type: .DINCondensedBold, size: 14);
        weekLabel.textColor = UIColor.init(hex: "#878787");
        weekLabel.text="SUNDAY,APRIL 8";
        return weekLabel;
    }()
    
    fileprivate lazy var cellTitleLabel:UILabel = {
        let cellLabel = UILabel.init();
        cellLabel.font = UIFont.fontType(type: .FZZHONGCURegular, size: 28);
        cellLabel.textColor = UIColor.init(hex: "#444444");
        cellLabel.text="开眼今日编辑精选";
        return cellLabel;
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout.init();
//        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width-40, height: 250);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.headerReferenceSize = CGSize.init(width: 15, height: 250);
        flowLayout.footerReferenceSize = CGSize.init(width: 15, height: 250);
        flowLayout.scrollDirection = .horizontal;

        let collectionView =  UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout);
        collectionView.backgroundColor = UIColor.white;
        collectionView.delegate=self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = false;
        
        collectionView.register(HomeSquareFollowCardCell.self, forCellWithReuseIdentifier: "HomeSquareFollowCardCell")
        collectionView.register(HomeSquareBannerCell.self, forCellWithReuseIdentifier: "HomeSquareBannerCell")
        
        return collectionView;
    }()
    
    fileprivate lazy var lineView: UIView = {
        let line = UIView.init();
        line.backgroundColor =  UIColor.init(hex: "#DEDEDE");
        return line;
    }()
    
    fileprivate var currentIndex:Int! = 0
    fileprivate var dragStartX:CGFloat! = 0.0
    fileprivate var dragEndX:CGFloat! = 0.0
    fileprivate var itemList:Array<JSON>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setupViews();
        setupAutolayout();
        self.selectionStyle = .none;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(data:JSON){
        
        if data["data"]["header"]["font"].stringValue == "bold"{
            self.cellTitleLabel.font = UIFont.fontType(type: .FZZHONGCURegular, size: 20);
            self.collectionView.snp.updateConstraints({ (make) in
                make.height.equalTo(170);
            })
        }
        
        self.weekdayLabel.text = data["data"]["header"]["subTitle"].stringValue;
        self.cellTitleLabel.text = data["data"]["header"]["title"].stringValue;
        self.itemList = data["data"]["itemList"].arrayValue;
        self.collectionView.reloadData();
        
    }
    
    func setupViews(){
        self.contentView.addSubview(self.weekdayLabel);
        self.contentView.addSubview(self.cellTitleLabel);
        self.contentView.addSubview(self.collectionView);
        self.contentView.addSubview(self.lineView);
    }
    
    func setupAutolayout(){
        self.weekdayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(30);
        }
        
        self.cellTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.weekdayLabel);
            make.top.equalTo(self.weekdayLabel.snp.bottom).offset(5);
        }
        
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.cellTitleLabel.snp.bottom).offset(5);
            make.height.equalTo(250);
            make.bottom.equalTo(self.contentView).offset(-5);
        }
        
        self.lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.bottom);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(0.5);
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.itemList?.count)!;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let data = self.itemList![indexPath.row];
        var reuseIdentifier = "HomeSquareFollowCardCell";
        if data["type"].stringValue == "banner2" {
            reuseIdentifier = "HomeSquareBannerCell"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath);
        (cell as! ConfigCellDataProtocol).config(data: data);
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let data = self.itemList![indexPath.row];
        var height:CGFloat = 250.0;
        if data["type"].stringValue == "banner2"{
            height = 170.0;
        }
        
        return  CGSize.init(width: UIScreen.main.bounds.size.width - 40, height: height)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.dragStartX = scrollView.contentOffset.x;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.dragEndX = scrollView.contentOffset.x;
        
        DispatchQueue.main.async {
            self.fixCellToCenter();
        }
    }
    
    func fixCellToCenter(){
        
        let dragMiniDistance = CGFloat(self.bounds.size.width/20.0)
        if self.dragStartX - self.dragEndX >= dragMiniDistance {
            self.currentIndex = self.currentIndex - 1;
        }
        else if self.dragEndX - self.dragStartX >= dragMiniDistance {
            self.currentIndex = self.currentIndex + 1;
        }
        let maxIndex = self.collectionView.numberOfItems(inSection: 0) - 1;
        self.currentIndex = self.currentIndex <= 0 ? 0 : self.currentIndex;
        self.currentIndex = self.currentIndex >= maxIndex ? maxIndex : self.currentIndex;
        self.collectionView.scrollToItem(at: NSIndexPath.init(row: self.currentIndex, section: 0) as IndexPath, at: .centeredHorizontally, animated: true);
    }
   
    
}



