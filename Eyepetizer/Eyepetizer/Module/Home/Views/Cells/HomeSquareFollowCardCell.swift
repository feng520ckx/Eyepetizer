//
//  HomeSquareCollectionCell.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/4/8.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class HomeSquareFollowCardCell: UICollectionViewCell,ConfigCellDataProtocol {
    
    fileprivate lazy var bgImageView:UIImageView = {
        let imageView = UIImageView.init();
        imageView.layer.cornerRadius = 6;
        imageView.clipsToBounds = true;
        imageView.backgroundColor = UIColor.gray;
        return imageView;
    }()
    
    fileprivate lazy var iconImageView:UIImageView = {
        let imageView = UIImageView.init();
        imageView.image = UIImage.init(named: "ic_badge_daily_48x48_")
        return imageView;
    }()
    
    fileprivate lazy var timeLabel:UILabel = {
        let label = UILabel.init();
        label.font = UIFont.fontType(type: .DINCondensedBold, size: 14);
        label.textColor = UIColor.white
        return label;
    }()
    
    fileprivate lazy var timeContentView: UIView = {
        let view = UIView.init();
        view.layer.cornerRadius = 2;
        view.backgroundColor = UIColor.black;
        return view;
    }()
    
    fileprivate lazy var headImageView:UIImageView = {
        let imageView = UIImageView.init();
        imageView.layer.cornerRadius = 20;
        imageView.clipsToBounds = true;
        imageView.backgroundColor = UIColor.gray;
        return imageView;
    }()
    
    fileprivate lazy var headIconImageView: UIImageView = {
        let imageView = UIImageView.init();
        imageView.image = UIImage.init(named: "author_avatar_v_16x16_");
        return imageView;
    }()
    
    fileprivate lazy var shareButton: UIButton = {
        let button = UIButton.init();
        button.setImage(UIImage.init(named: "action_share_grey_24x24_"), for: .normal);
        button.addTarget(self, action: #selector(HomeSquareFollowCardCell.shareButtonClick), for: .touchUpInside);
        return button;
    }()
    
    fileprivate lazy var videoTitleLabel: UILabel = {
        let label = UILabel.init();
        label.font = UIFont.fontType(type: .FZZHONGCURegular, size: 15);
        label.textColor = UIColor.init(hex: "#444444");
        label.text = "肾上腺素急速飙升！急速教大家覅偶家圣诞节哦i";
        return label;
    }()
    
    fileprivate lazy var videoDescLabel: UILabel = {
        let label = UILabel.init();
        label.font = UIFont.fontType(type: .FZXIHEIRegular, size: 12);
        label.textColor = UIColor.init(hex: "919191");
        label.text = "Pennsdjo新作，电影机广告就扫地机sad奇偶及";
        return label;
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupSubviews();
        setupAutoLayout();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(data:JSON){
        let content = data["data"]["content"]["data"];
        self.bgImageView.kf.setImage(with: URL.init(string: content["cover"]["feed"].stringValue));
        self.videoTitleLabel.text = content["title"].stringValue;
        self.videoDescLabel.text = content["slogan"].stringValue;
        
        self.headImageView.kf.setImage(with: URL.init(string: content["author"]["icon"].stringValue));
        let min = content["duration"].intValue/60;
        let sec = content["duration"].intValue%60;
        let minFormat = String(format:"%02d",min)
        let secFormat = String(format:"%02d",sec)
        self.timeLabel.text = "\(minFormat):\(secFormat)"
        
    }
    
    func setupSubviews(){
        self.contentView.addSubview(self.bgImageView);
        self.contentView.addSubview(self.headImageView);
        self.contentView.addSubview(self.headIconImageView);
        self.bgImageView.addSubview(self.iconImageView);
        self.bgImageView.addSubview(self.timeContentView);
        self.timeContentView.addSubview(self.timeLabel);
        self.contentView.addSubview(self.videoTitleLabel);
        self.contentView.addSubview(self.videoDescLabel);
        self.contentView.addSubview(self.shareButton);
    }
    
    func setupAutoLayout(){
        self.bgImageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-70)
        }
        
        self.timeContentView.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(self.bgImageView).offset(-10);
            make.height.equalTo(16);
        }
        
        self.timeLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.timeContentView).offset(3);
            make.right.equalTo(self.timeContentView).offset(-3);
            make.centerX.equalTo(self.timeContentView);
            make.centerY.equalTo(self.timeContentView).offset(1);

        }
        
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.bgImageView).offset(10);
            make.top.equalTo(self.bgImageView).offset(10);
            make.width.height.equalTo(48);
        }
        
        self.headImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.bgImageView.snp.bottom).offset(10);
            make.width.height.equalTo(40);
        }
        
        self.headIconImageView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self.headImageView);
            make.width.height.equalTo(10);
        }
        
        self.shareButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(30);
            make.centerY.equalTo(self.headImageView);
            make.right.equalTo(self.contentView).offset(-10);
        }
        
        self.videoTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp.right).offset(10);
            make.top.equalTo(self.headImageView);
            make.right.equalTo(self.shareButton.snp.left).offset(-10);
        }
        
        self.videoDescLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.videoTitleLabel);
            make.top.equalTo(self.videoTitleLabel.snp.bottom).offset(5);
        }
        
    }
    
    @objc func shareButtonClick(){
        print("shareButtonClick");
    }
}
