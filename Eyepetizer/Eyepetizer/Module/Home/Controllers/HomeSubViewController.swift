//
//  HomeSubViewController.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/3/29.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeSubViewController: UIViewController {

    public var apiUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("apiUrl=\(apiUrl!)");
        setupData();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupData() {
        NetworkAPI.loadHomeDetailData(requestURL: apiUrl!) { (result) in
            let json = JSON(result.value!)
//            print("json=\(json)")
//            var itemList:Array<HomeItemModel> = []
//            
//            for itemJson in json["itemList"].arrayValue{
//                let itemModel = HomeItemModel.deserialize(from: itemJson.dictionaryValue);
//                itemList.append(itemModel!)
//            }
//            
//            print("itemList =\(itemList)");
        };
        
    }
    
    
}
