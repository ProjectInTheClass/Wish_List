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
    
    @IBOutlet weak var Month_Save: UITextField!
    @IBOutlet weak var Date: UIDatePicker!
    @IBOutlet weak var Memo: UITextView!
    
    let fav_img = UIImage(named: "favorite")
    let favn_img = UIImage(named: "favorite_not")
    
    @IBAction func ClickFavorite(_ sender: Any) {
        if (data?.favorite)! {
            data?.favorite = false
            Favorite.setImage(favn_img, for: .normal)
        }
        else {
            data?.favorite = true
            Favorite.setImage(fav_img, for: .normal)
        }
    }
    @IBAction func ClickCancle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func ClickModify(_ sender: Any) {
        data?.name = Name.text!
        if (Int(Price.text!) != nil) {
            data?.price = Int(Price.text!)
        }
        data?.d_day = Date.date
        data?.memo = Memo.text!
        
        if (Int(Month_Save.text!) != nil) {
            data?.money_monthly = Int(Month_Save.text!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        ImgDesign(Imgview: Image!)
        Name?.text = data?.name
        Image?.image = data?.img
        if data?.d_day != nil{
            Date.date = (data?.d_day)!
        }
        else{
        }
        if data?.money_monthly != nil {
            Month_Save?.text = data?.money_monthly?.description
        }
        else {
            Month_Save?.text = "가격 미상"
        }
        
        if data?.price != nil{
            Price?.text = data?.price?.description
        }
        else{
            Price?.text = "가격 미상"
        }
        Memo?.text = data?.memo
        
        if (data?.favorite)! {
            Favorite.setImage(fav_img, for: .normal)
        }
        else {
            Favorite.setImage(favn_img, for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func ImgDesign(Imgview : UIImageView){
        Imgview.layer.borderWidth = 1
        Imgview.layer.masksToBounds = false
        Imgview.layer.borderColor = UIColor.black.cgColor
        Imgview.layer.cornerRadius = (Imgview.frame.height) / 2
        Imgview.clipsToBounds = true
    }


}
