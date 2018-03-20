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


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white;
        self.fd_prefersNavigationBarHidden = true;
        setupUI();
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI(){
        let config = SGPageTitleViewConfigure();
        let menu = SGPageTitleView.init(frame: CGRect.init(x: 40, y: 20, width: self.view.frame.size.width-80, height: 44), delegate: self as SGPageTitleViewDelegate, titleNames: ["测试1","测试2","测试3","测试4","测试5","测试6"], configure: config)!;
        menu.isShowBottomSeparator=false;
        
        self.view.addSubview(menu);
        
    }

}

extension HomeViewController:SGPageTitleViewDelegate{
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        print("selectId=\(selectedIndex)");
    }
}
