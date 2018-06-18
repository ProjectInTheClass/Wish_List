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
        Save?.text = (data?.save.description)! + "원"
        Save?.adjustsFontSizeToFitWidth = true
        Save?.minimumScaleFactor = 0.2
        
        var interval : Double
        var s = "-"
        interval = (data?.d_day?.timeIntervalSinceNow)!
        interval = interval / 86400
        if interval < 0 {
            interval = interval * -1
            s = "+"
        }
        D_day?.text = "D " + s + " " + (Int(interval)).description
    
    }
    
    @IBAction func out(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func show_all(){
        
    }
    
    @IBAction func show_out(){
        
    }
    
    @IBAction func show_in(){
        
    }
    
}
