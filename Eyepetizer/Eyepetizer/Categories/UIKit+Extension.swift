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
        titleLabel.font = UIFont.fontType(type: .Lobster, size: 25);
        titleLabel.text = title;
        titleLabel.textAlignment = .center;
        self.titleView=titleLabel
    }
    
}

enum FontCustomType {
    case DINCondensedBold
    case FZLTXIHJW
    case FZLTZCHJW
    case Lobster
}

extension UIFont{
    class func fontType(type:FontCustomType,size:CGFloat) -> UIFont {
        var font:UIFont?
        switch type {
        case .DINCondensedBold:
            font = UIFont.init(name: "DINCondensedBold", size: size);
        case .FZLTXIHJW:
            font = UIFont.init(name: "FZLTXIHJW", size: size);
        case .FZLTZCHJW:
            font = UIFont.init(name: "FZLTZCHJW", size: size);
        case .Lobster:
            font = UIFont.init(name: "Lobster 1.4", size: size);
        }
        return font!;
    }
}




