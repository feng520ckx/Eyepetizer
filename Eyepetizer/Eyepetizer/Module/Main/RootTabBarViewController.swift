//
//  RootTabBarViewController.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/3/16.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setChildViewController(HomeViewController(), selectImageName: "ic_tab_home_selected_49x49_", imageName:"ic_tab_home_49x49_")
        setChildViewController(FollowsViewController(), selectImageName: "ic_tab_follow_selected_49x49_", imageName:"ic_tab_follow_49x49_")
        setChildViewController(NotificViewController(), selectImageName: "ic_tab_noti_selected_49x49_", imageName:"ic_tab_noti_49x49_")
        setChildViewController(ProfileViewController(), selectImageName: "ic_tab_4_selected_49x49_", imageName:"ic_tab_4_49x49_")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setChildViewController(_ childController: UIViewController, selectImageName: String, imageName: String) {
       
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        let navVc = RootNagigationController(rootViewController: childController)
        addChildViewController(navVc)
    }
    

}
