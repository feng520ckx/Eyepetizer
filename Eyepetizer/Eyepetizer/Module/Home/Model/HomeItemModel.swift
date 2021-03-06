//
//  HomeItemModel.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/4/2.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import HandyJSON
//public protocol Encodable {
//    func encode(to encoder: Encoder) throws
//}
//public protocol Decodable {
//    init(from decoder: Decoder) throws
//}
//public typealias Codable = Decodable & Encodable


struct HomeItemModel: Codable {
    var id: Int = 0
    var type: String?
    var tag: String?
    var adIndex: Int = 0
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        print("values=\(values)")
        
    }

    
}

struct SquareRootData: HandyJSON{//squareCardCollection data
    var dataType: String?
    var header: Header?
    
}

struct SquareItemList: HandyJSON {
//    var data: Data?
    var id: Int = 0
    var type: String?
    var adIndex: Int = 0
    var header: Header?
    var dataType: String?
    
}

struct SquareItemListData: HandyJSON {
    var type: String?
//    var
}


struct Data: HandyJSON {
    var collected: Bool = false
    var ifLimitVideo: Bool = false
    var author: Author?
    var category: String?
    var type: String?
    var titlePgc: String?
    var tags = [Tags]()
    var id: Int = 0
    var webUrl: WebUrl?
    var library: String?
    var releaseTime: Int = 0
    var duration: Int = 0
    var provider: Provider?
    var consumption: Consumption?
    var cover: Cover?
    var title: String?
    var descriptionPgc: String?
    var resourceType: String?
    var playUrl: String?
    var description: String?
    var date: Int = 0
    var played: Bool = false
    var idx: Int = 0
    var descriptionEditor: String?
    var dataType: String?
    var playInfo = [PlayInfo]()
}

struct Cover: HandyJSON {
    var detail: String?
    var blurred: String?
    var feed: String?
}

struct Consumption: HandyJSON {
    var shareCount: Int = 0
    var replyCount: Int = 0
    var collectionCount: Int = 0
}

struct Provider: HandyJSON {
    var name: String?
    var icon: String?
    var alias: String?
}

struct WebUrl: HandyJSON {
    var forWeibo: String?
    var raw: String?
}

struct Author: HandyJSON {
    var link: String?
    var icon: String?
    var name: String?
    var id: Int = 0
    var follow: Follow?
    var description: String?
    var videoNum: Int = 0
    var latestReleaseTime: Int = 0
    var shield: Shield?
    var approvedNotReadyVideoCount: Int = 0
    var ifPgc: Bool = false
}

struct Shield: HandyJSON {
    var itemType: String?
    var itemId: Int = 0
    var shielded: Bool = false
}

struct Follow: HandyJSON {
    var itemType: String?
    var itemId: Int = 0
    var followed: Bool = false
}

struct Header: HandyJSON {
    var subTitle: String?
    var textAlign: String?
    var id: Int = 0
    var subTitleFont: String?
    var title: String?
    var font: String?
    var actionUrl: String?
    var icon: String?
    var iconType: String?
    var time : Int64 = 0
    var showHateVideo: Bool = false
    
}

struct Tags: HandyJSON {
    var name: String?
    var headerImage: String?
    var id: Int = 0
    var bgPicture: String?
    var tagRecType: String?
    var actionUrl: String?
}

struct UrlList: HandyJSON {
    var name: String?
    var url: String?
    var size: Int = 0
}

struct PlayInfo: HandyJSON {
    var height: Int = 0
    var urlList = [UrlList]()
    var name: String?
    var type: String?
    var url: String?
    var width: Int = 0
}




enum Itemtype : String,HandyJSONEnum {
    
    case squarCardCollection = "squareCardCollection"
    
    case textCard = "textCard"
    
    case followCard = "followCard"
    
    case videoSmallCard = "videoSmallCard"
    
    case banner = "banner"
    
}
