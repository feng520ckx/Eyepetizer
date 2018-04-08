//
//  HomeViewController.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/3/16.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import SGPagingView
import SwiftyJSON

class HomeViewController: UIViewController {

    fileprivate var titleArray:Array<JSON>?
//    var contentView:SGPageContentView?
    fileprivate var titleView:SGPageTitleView?
    fileprivate var contentView:SGPageContentView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white;
        self.fd_prefersNavigationBarHidden = true;
        
        NetworkAPI.loadTitlelistData { (result) in
            let json = JSON(result.value!)
            self.titleArray = json["tabInfo"]["tabList"].arrayValue;
            var childsArray:Array<UIViewController> = [];
            var titles:Array<String> = [];
            for item in self.titleArray!{
                titles.append(item["name"].stringValue)
                let vc = HomeSubViewController();
                vc.apiUrl=item["apiUrl"].stringValue;
                childsArray.append(vc)
            }
            let config = SGPageTitleViewConfigure();
            config.titleFont = UIFont.fontType(type: .DINCondensedBold, size: 13);
            config.titleColor = UIColor.init(hex: "#919191");
            config.titleSelectedColor = UIColor.init(hex: "#323232");
            config.indicatorColor = UIColor.init(hex: "#323232");
            config.indicatorHeight = 3.0;
            config.indicatorStyle = SGIndicatorStyleFixed;
            config.indicatorFixedWidth = 15;
            config.spacingBetweenButtons = 25;
            config.indicatorScrollStyle = SGIndicatorScrollStyleHalf;
            let menu = SGPageTitleView.init(frame: CGRect.init(x: 40, y: 20, width: self.view.frame.size.width-80, height: 34), delegate: self as SGPageTitleViewDelegate, titleNames:titles, configure: config)!;
            menu.isShowBottomSeparator=false;
            menu.selectedIndex = json["tabInfo"]["defaultIdx"].intValue;
            self.titleView=menu;
            self.view.addSubview(menu);
            
            let contentView = SGPageContentView.init(frame: CGRect.init(x: 0, y: 54, width: self.view.frame.size.width, height: self.view.frame.size.height-54), parentVC: self, childVCs: childsArray)!;
            
            contentView.delegatePageContentView=self as SGPageContentViewDelegate;
            self.contentView=contentView;

            self.view.addSubview(contentView);
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension HomeViewController:SGPageTitleViewDelegate,SGPageContentViewDelegate{
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.contentView?.setPageCententViewCurrentIndex(selectedIndex);
    }
    
    func pageContentView(_ pageContentView: SGPageContentView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.titleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex);
    }
    
    func pageContentView(_ pageContentView: SGPageContentView!, offsetX: CGFloat) {
        print("offsetx=\(offsetX)")
    }
    
}

