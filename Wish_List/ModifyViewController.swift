//
//  ModifyViewController.swift
//  Wish_List
//
//  Created by 김병주 on 2018. 6. 14..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController {
    
    var data:Wish_Item?;
    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var OK: UIButton!
    @IBOutlet weak var Favorite: UIButton!
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Save: UITextField!
    @IBOutlet weak var Date: UIDatePicker!
    @IBOutlet weak var Memo: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        Name?.text = data?.name
        Image?.image = data?.img
        if data?.d_day != nil{
            Date.date = (data?.d_day)!
        }
        else{
        }
        
        Save?.text = data?.save.description
        if data?.price != nil{
            Price?.text = data?.price?.description
        }
        else{
            Price?.text = "가격 미상"
        }
        Memo?.text = data?.memo

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
