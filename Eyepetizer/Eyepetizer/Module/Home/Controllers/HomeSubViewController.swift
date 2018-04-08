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
        table.register(HomeSquartCell.self, forCellReuseIdentifier: "HomeSquartCell");
        return table;
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSquartCell");
        
        return cell!;

    }
    
    
}
