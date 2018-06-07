//
//  AddItemViewController.swift
//  Wish_List
//
//  Created by ljh on 2018. 6. 7..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var goal: UITextField!
    @IBOutlet weak var deadline: UIDatePicker!
    @IBOutlet weak var memo: UITextView!
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        let temp = Wish_Item(name: name.text!, favorite: false)
        temp.price = Int(goal.text!)
        temp.d_day = deadline.date as Date
        temp.favorite = false
        temp.memo = memo.text!
        Items.append(temp)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
