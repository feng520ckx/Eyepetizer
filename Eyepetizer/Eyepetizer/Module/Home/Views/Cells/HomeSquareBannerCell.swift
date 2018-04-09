//
//  HomeSquareBannerCell.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/4/9.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class HomeSquareBannerCell: UICollectionViewCell,ConfigCellDataProtocol {
    
    fileprivate lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView.init();
        imageView.layer.cornerRadius = 6;
        imageView.clipsToBounds = true;
        imageView.backgroundColor = UIColor.gray;
        return imageView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.contentView.addSubview(self.bannerImageView);
        
        self.bannerImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView);
            make.height.equalTo(170);
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(data:JSON){
        
        self.bannerImageView.kf.setImage(with: URL.init(string: data["data"]["image"].stringValue))
    }
    
    
    
}
