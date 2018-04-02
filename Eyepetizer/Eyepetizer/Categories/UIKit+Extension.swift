//
//  UIKit+Extension.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/3/17.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem{
    
    func setTitle(title:String){
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 44))
        titleLabel.font = UIFont.fontType(type: .LOBStTERRegular, size: 25);
        titleLabel.text = title;
        titleLabel.textAlignment = .center;
        self.titleView=titleLabel
    }
    
}

enum FontCustomType {
    case DINCondensedBold
    case FZXIHEIRegular
    case FZZHONGCURegular
    case LOBStTERRegular
}

extension UIFont{
    class func fontType(type:FontCustomType,size:CGFloat) -> UIFont {
        var font:UIFont?
        switch type {
        case .DINCondensedBold:
            font = UIFont.init(name: "DIN Condensed", size: size);
        case .FZXIHEIRegular:
            font = UIFont.init(name: "方正兰亭细黑简体", size: size);
        case .FZZHONGCURegular:
            font = UIFont.init(name: "方正兰亭中粗黑简体", size: size);
        case .LOBStTERRegular:
            font = UIFont.init(name: "Lobster 1.4", size: size);
        }
        return font!;
    }
}

extension String {
    public var hexInt: Int? {
        let scanner = Scanner(string: self)
        var value: UInt64 = 0
        guard scanner.scanHexInt64(&value) else { return nil }
        return Int(value)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        var str = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if str.hasPrefix("#") {
            let indexOffsetBy1 = str.index(str.startIndex, offsetBy: 1)
            str = String(str[indexOffsetBy1...])
        }
        guard str.count == 6 else { return nil }
        
        let startIndex = str.startIndex
        let endIndex = str.endIndex
        
        let indexOffsetBy2 = str.index(startIndex, offsetBy: 2)
        let indexOffsetBy4 = str.index(startIndex, offsetBy: 4)
        
        let red = str[startIndex..<indexOffsetBy2]
        let green = str[indexOffsetBy2..<indexOffsetBy4]
        let blue = str[indexOffsetBy4..<endIndex]
        
        guard let redIn255 = String(red).hexInt else { return nil }
        guard let greenIn255: Int = String(green).hexInt else { return nil }
        guard let blueIn255: Int = String(blue).hexInt else { return nil }
        
        let redFloat = CGFloat(redIn255) / 255.0;
        let greenFloat = CGFloat(greenIn255) / 255.0;
        let blueFloat = CGFloat(blueIn255) / 255.0;
        
        self.init(red: redFloat, green: greenFloat, blue: blueFloat, alpha: 1)
        
    }
}



