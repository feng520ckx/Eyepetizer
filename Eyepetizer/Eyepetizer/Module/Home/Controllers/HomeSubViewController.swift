//
//  HomeSubViewController.swift
//  Eyepetizer
//
//  Created by caikaixuan on 2018/3/29.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit
import SwiftyJSON
//import HandyJSON
import SnapKit

class HomeSubViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    public var apiUrl:String?
    fileprivate var itemArray:Array<JSON> = []
    lazy var tableview:UITableView = {
        let table = UITableView.init();
        table.delegate=self;
        table.dataSource=self;
        table.rowHeight = UITableViewAutomaticDimension;
        table.separatorStyle = .none;
        table.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0);
        table.register(HomeSquartCell.self, forCellReuseIdentifier: "HomeSquartCell");
        return table;
    }()
    
    lazy var refreshImageView:UIImageView = {
        let imageview = UIImageView.init();
        
        return imageview;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("apiUrl=\(apiUrl!)");
        setupView();
        setupAutoLayout();
        setupData();
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView(){
        self.view.addSubview(self.tableview);
        
    }
    
    func setupAutoLayout(){
        self.tableview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        };
    }
    
    func setupData() {
        NetworkAPI.loadHomeDetailData(requestURL: apiUrl!) { (result) in
            let json = JSON(result.value!)
            self.itemArray = json["itemList"].arrayValue
            self.tableview.reloadData();
        };
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = self.itemArray[indexPath.row];
        if data["type"].stringValue == "squareCardCollection" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSquartCell");
            (cell as! HomeSquartCell).config(data: data);
            
            return cell!;
        }
        else {
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil);
            cell.textLabel?.text = "other cell";
            return cell;
        }
    }
    
    
}
