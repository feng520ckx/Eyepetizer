//
//  HomeSquartCell.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/4/8.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import SnapKit

class HomeSquartCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

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
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width-40, height: 260);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.headerReferenceSize = CGSize.init(width: 15, height: 260);
        flowLayout.footerReferenceSize = CGSize.init(width: 15, height: 260);
        flowLayout.scrollDirection = .horizontal;

        let collectionView =  UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout);
        collectionView.backgroundColor = UIColor.white;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.delegate=self;
        collectionView.register(HomeSquareCollectionCell.self, forCellWithReuseIdentifier: "HomeSquareCollectionCell")
        
        return collectionView;
    }()
    
    fileprivate var currentIndex:Int! = 0
    fileprivate var dragStartX:CGFloat! = 0.0
    fileprivate var dragEndX:CGFloat! = 0.0
    
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews(){
        self.contentView.addSubview(self.weekdayLabel);
        self.contentView.addSubview(self.cellTitleLabel);
        self.contentView.addSubview(self.collectionView);
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
            make.height.equalTo(200);
            make.bottom.equalTo(self.contentView);
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeSquareCollectionCell", for: indexPath);
        return cell;
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
