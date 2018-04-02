//
//  NetworkAPI.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/3/17.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol API {
    //MARK: 获取首页标题分类
    static func loadTitlelistData(completionHandler : @escaping (_ result:Result<Any>)->());
    static func loadHomeDetailData(requestURL:String,completionHandler:@escaping (_ result:Result<Any>)->());
    
    
}


extension API{
    
    static func loadTitlelistData(completionHandler : @escaping (_ result:Result<Any>)->()){
        let url = "https://baobab.kaiyanapp.com/api/v5/index/tab/list?_s=c4e01812b3f2b79369ab764eaead6046&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=4194419f80ed17f8f7d74a8c89bcaa3c44154e5f&v=3.16.0&vc=4053"
        Alamofire.request(url).responseJSON { (response) in
            
            guard response.result.isSuccess else { return }
            completionHandler(response.result)
        }
        
    }
    
    static func loadHomeDetailData(requestURL: String, completionHandler: @escaping (Result<Any>) -> ()) {
        Alamofire.request(requestURL).responseJSON { (response) in
            guard response.result.isSuccess else { return }
            completionHandler(response.result)
        }
    }
}

struct NetworkAPI: API {}


