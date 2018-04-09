//
//  LoadingView.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/4/9.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    
    fileprivate lazy var bigEyeImageView: UIImageView = {
        let imageview = UIImageView.init();
        imageview.image = UIImage.init(named: "ICON_Loading_Out_42x28_");
        return imageview;
    }()
    
    fileprivate lazy var littleEyeImageView: UIImageView = {
        let imageview = UIImageView.init();
        imageview.image = UIImage.init(named: "ICON_Loading_In_42x28_");
        return imageview;
    }()
    
    fileprivate lazy var bigEyeImageView2: UIImageView = {
        let imageview = UIImageView.init();
        imageview.image = UIImage.init(named: "ICON_Loading_Out_42x28_");
        imageview.alpha = 0.6;
        return imageview;
    }()
    
    fileprivate lazy var bigEyeImageView3: UIImageView = {
        let imageview = UIImageView.init();
        imageview.image = UIImage.init(named: "ICON_Loading_Out_42x28_");
        imageview.alpha = 0.3;
        return imageview;
    }()
    
    fileprivate var timer:Timer?
    fileprivate var angle:Double! = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupSubviews();
        setupAutolayout();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(){
        
        self.addSubview(self.bigEyeImageView2);
        self.addSubview(self.bigEyeImageView3);
        self.addSubview(self.bigEyeImageView);
        self.addSubview(self.littleEyeImageView);
        
    }
    
    func setupAutolayout(){
        
        self.bigEyeImageView.snp.makeConstraints { (make) in
            make.width.equalTo(42);
            make.height.equalTo(28);
            make.center.equalTo(self);
        }
        
        self.bigEyeImageView2.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.bigEyeImageView);
            make.center.equalTo(self.bigEyeImageView);
        }
        
        self.bigEyeImageView3.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.bigEyeImageView);
            make.center.equalTo(self.bigEyeImageView);
        }
        
        self.littleEyeImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.bigEyeImageView);
            make.center.equalTo(self.bigEyeImageView);
        }
        
    }
    
   public func startAnimation(){
        self.bigEyeImageView.transform = .identity;
        self.bigEyeImageView2.transform = .identity;
        self.bigEyeImageView3.transform = .identity;
        
        self.timer = Timer.init(timeInterval: 0.04, repeats: true, block: { (timer) in
            let nowAngle = CGFloat(self.angle * (Double.pi / 180.0));
            self.bigEyeImageView.transform = CGAffineTransform(rotationAngle: nowAngle);
            self.bigEyeImageView2.transform = CGAffineTransform(rotationAngle: nowAngle-40);
            self.bigEyeImageView3.transform = CGAffineTransform(rotationAngle: nowAngle+40);
            self.angle = self.angle + 10.0;
        })
        
        RunLoop.current.add(self.timer!, forMode: .commonModes)
    }
    
    public func stopAnimation(){
        self.bigEyeImageView.transform = .identity;
        self.bigEyeImageView2.transform = .identity;
        self.bigEyeImageView3.transform = .identity;
        
        self.timer?.invalidate();
        self.timer = nil;
        
    }
    
    public func refreshOffsetY(offsetY:CGFloat){
        
        var scale:CGFloat = 1.0
        if offsetY >= -50{
            scale = 1 - CGFloat((offsetY + 50) / 50.0)
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.alpha = scale
        }
    }
    
    class func show(view:UIView?){
        
        var showInView = view;
        if view == nil{//在window显示
            showInView = UIApplication.shared.keyWindow;
        }
        
        let loadingView = LoadingView();
        loadingView.tag = 10086;
        showInView?.addSubview(loadingView);
        
        loadingView.snp.makeConstraints { (make) in
            make.width.equalTo(42);
            make.height.equalTo(28);
            make.center.equalTo(showInView!);
        }
        
        loadingView.startAnimation();
        
    }
    
    class func hidden(view:UIView?){
        var showInView = view;
        if view == nil{//在window显示
            showInView = UIApplication.shared.keyWindow;
        }
        if let loadingView = showInView?.viewWithTag(10086){
            (loadingView as! LoadingView).stopAnimation();
            loadingView.removeFromSuperview();
        }
    }
    
    
    
    

}
