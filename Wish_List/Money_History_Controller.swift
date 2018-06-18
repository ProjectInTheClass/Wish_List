//
//  Money_History_Controller.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 6. 19..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class Money_History_Controller: UIViewController{
    var data : Wish_Item?
    @IBOutlet weak var D_day : UILabel? //d-day
    @IBOutlet weak var Save : UILabel?  //넣은 돈
    @IBOutlet weak var Lists : UITableView?
    @IBOutlet weak var Navibar: UINavigationBar?
    
    override func viewDidLoad() {
    super.viewDidLoad()
    Navibar?.topItem?.title = data?.name
    
    
    }
    
}
