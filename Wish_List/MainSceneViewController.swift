//
//  MainSceneViewController.swift
//  Wish_List
//
//  Created by ljh on 2018. 5. 31..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController {

    @IBOutlet weak var GoodToday: UILabel?
    @IBOutlet weak var Totaldaily: UILabel?
    
    @IBOutlet weak var FavoriteImage: UIImageView!
    @IBOutlet weak var FavoriteName: UILabel!
    @IBOutlet weak var FavoriteDeadline: UILabel!
    @IBOutlet weak var FavoriteSaved: UILabel!
    @IBOutlet weak var FavoriteGoal: UILabel!
    @IBOutlet weak var FavoriteProgressBar: UIProgressView!
    @IBOutlet weak var OuterFavoriteProgressBar: UIProgressView!
    @IBOutlet weak var FavoriteProgress: UILabel!

    @IBOutlet weak var EndisnearImage: UIImageView!
    @IBOutlet weak var EndisnearName: UILabel!
    @IBOutlet weak var EndisnearDeadline: UILabel!
    @IBOutlet weak var EndisnearSaved: UILabel!
    @IBOutlet weak var EndisnearGoal: UILabel!
    @IBOutlet weak var EndisnearProgressBar: UIProgressView!
    @IBOutlet weak var OuterEndisnearProgressBar: UIProgressView!
    @IBOutlet weak var EndisnearProgress: UILabel!
    
    @IBOutlet weak var DayiscommingImage: UIImageView!
    @IBOutlet weak var DayiscommingName: UILabel!
    @IBOutlet weak var DayiscommingDeadline: UILabel!
    @IBOutlet weak var DayiscommingSaved: UILabel!
    @IBOutlet weak var DayiscommingGoal: UILabel!
    @IBOutlet weak var DayiscommingProgressBar: UIProgressView!
    @IBOutlet weak var OuterDayiscommingProgressBar: UIProgressView!
    @IBOutlet weak var DayiscommingProgress: UILabel!
    
    @IBOutlet weak var NoFavoriteView: UIView!
    @IBOutlet weak var NoEndisnear: UIView!
    @IBOutlet weak var NoDayiscomming: UIView!
    
    @IBAction func FavoriteRefresh(_ sender: Any) {
        getNextFavorite()
        RefreshFavoriteCell()
    }
    
    func RefreshFavoriteCell () {
        if (favoriteIndex == -1) {
            NoFavoriteView.isHidden = false
            FavoriteImage.image = UIImage(named:"noimg")
            FavoriteName.text = " "
            FavoriteDeadline.text = " "
            FavoriteSaved.text = " "
            FavoriteGoal.text = " "
            FavoriteProgressBar.progress = 0
            FavoriteProgress.text = " "
            return
        }
        NoFavoriteView.isHidden = true
        FavoriteImage.image = Items[favoriteIndex].img
        
        FavoriteName.text = Items[favoriteIndex].name
        FavoriteDeadline.text = formatter.string(from: Items[favoriteIndex].d_day!)
        FavoriteSaved.text = String(Items[favoriteIndex].save) + "원"
        FavoriteGoal.text = String(Items[favoriteIndex].price!) + "원"
        FavoriteProgressBar.progress = Float(Items[favoriteIndex].save) / Float(Items[favoriteIndex].price!)
        
        FavoriteProgress.text = String(Int((FavoriteProgressBar.progress * 100).rounded())) + "%"
    }
    
    @IBAction func EndisnearRefresh(_ sender: Any) {
        getNextEndisnear()
        RefreshEndisnearCell()
    }
    
    func RefreshEndisnearCell() {
        if (endisnearIndex == -1) {
            NoEndisnear.isHidden = false
            EndisnearImage.image = UIImage(named:"noimg")
            EndisnearName.text = " "
            EndisnearDeadline.text = " "
            EndisnearSaved.text = " "
            EndisnearGoal.text = " "
            EndisnearProgressBar.progress = 0
            EndisnearProgress.text = " "
            return
        }
        NoEndisnear.isHidden = true
        EndisnearImage.image = Items[endisnearIndex].img
        EndisnearName.text = Items[endisnearIndex].name
        EndisnearDeadline.text = formatter.string(from: Items[endisnearIndex].d_day!)
        EndisnearSaved.text = String(Items[endisnearIndex].save) + "원"
        EndisnearGoal.text = String(Items[endisnearIndex].price!) + "원"
        EndisnearProgressBar.progress = Float(Items[endisnearIndex].save) / Float(Items[endisnearIndex].price!)
        EndisnearProgress.text = String(Int((EndisnearProgressBar.progress * 100).rounded())) + "%"
    }
    
    @IBAction func DayiscommingRefresh(_ sender: Any) {
        getNextDayiscoming()
        RefreshDayiscommingCell()
    }
    
    func RefreshDayiscommingCell() {
        if (dayiscommingIndex == -1) {
            NoDayiscomming.isHidden = false
            DayiscommingImage.image = UIImage(named:"noimg")
            DayiscommingName.text = " "
            DayiscommingDeadline.text = " "
            DayiscommingSaved.text = " "
            DayiscommingGoal.text = " "
            DayiscommingProgressBar.progress = 0
            DayiscommingProgress.text = " "
            return
        }
        NoDayiscomming.isHidden = true
        DayiscommingImage.image = Items[dayiscommingIndex].img
        DayiscommingName.text = Items[dayiscommingIndex].name
        DayiscommingDeadline.text = formatter.string(from: Items[dayiscommingIndex].d_day!)
        DayiscommingSaved.text = String(Items[dayiscommingIndex].save) + "원"
        DayiscommingGoal.text = String(Items[dayiscommingIndex].price!) + "원"
        DayiscommingProgressBar.progress = Float(Items[dayiscommingIndex].save) / Float(Items[dayiscommingIndex].price!)
        DayiscommingProgress.text = String(Int((DayiscommingProgressBar.progress * 100).rounded())) + "%"
    }
    
    func refreshTotalDaily() {
        var daily = 0
        for item in Items {
            if let adder = item.money_monthly {
                daily += adder
            }
        }
        Totaldaily?.text = String(daily)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let now=NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        GoodToday?.text=dateFormatter.string(from: now as Date)
        
        progressDesign(ProgressBar: DayiscommingProgressBar,OuterProgressBar: OuterDayiscommingProgressBar)
        progressDesign(ProgressBar: EndisnearProgressBar,OuterProgressBar: OuterEndisnearProgressBar)
        progressDesign(ProgressBar: FavoriteProgressBar,OuterProgressBar: OuterFavoriteProgressBar)
        ImgDesign(Imgview: FavoriteImage)
        ImgDesign(Imgview: EndisnearImage)
        ImgDesign(Imgview: DayiscommingImage)
        // Do any additional setup after loading the view.
        getNextFavorite()
        getNextEndisnear()
        getNextDayiscoming()
        RefreshFavoriteCell()
        RefreshEndisnearCell()
        RefreshDayiscommingCell()
        refreshTotalDaily()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super .viewWillAppear(true)
        let now=NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        GoodToday?.text=dateFormatter.string(from: now as Date)

        // Do any additional setup after loading the view.
        getNextFavorite()
        getNextEndisnear()
        getNextDayiscoming()
        RefreshFavoriteCell()
        RefreshEndisnearCell()
        RefreshDayiscommingCell()
        refreshTotalDaily()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func progressDesign(ProgressBar:UIProgressView?,OuterProgressBar:UIProgressView?){
        
        ProgressBar?.progressTintColor = UIColor(displayP3Red: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
        ProgressBar?.transform = (ProgressBar?.transform.scaledBy(x: 1, y: 7))!
        ProgressBar?.trackTintColor = UIColor.clear
        OuterProgressBar?.transform = (OuterProgressBar?.transform.scaledBy(x: 1.01, y: 10))!
        OuterProgressBar?.trackTintColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        OuterProgressBar?.clipsToBounds = true
        OuterProgressBar?.layer.cornerRadius = 7
        OuterProgressBar?.layer.sublayers![1].cornerRadius = 7
        OuterProgressBar?.subviews[1].clipsToBounds = true
        OuterProgressBar?.layer.borderWidth = 0.1
        OuterProgressBar?.layer.borderColor = UIColor.gray.cgColor
        OuterProgressBar?.progress = 0
        
        ProgressBar?.clipsToBounds = true
        ProgressBar?.layer.cornerRadius = 7
        ProgressBar?.layer.sublayers![1].cornerRadius = 7
        ProgressBar?.subviews[1].clipsToBounds = true
        ProgressBar?.isUserInteractionEnabled = false
    }

    func ImgDesign(Imgview : UIImageView){
        Imgview.layer.borderWidth = 1
        Imgview.layer.masksToBounds = false
        Imgview.layer.borderColor = UIColor.black.cgColor
        Imgview.layer.cornerRadius = (Imgview.frame.height) / 2
        Imgview.clipsToBounds = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? DetailViewController
        {
            var selectedIndex = 0
            if (segue.identifier == "FavoriteSegue") {
                selectedIndex = favoriteIndex
            } else if (segue.identifier == "EndisnearSegue") {
                selectedIndex = endisnearIndex
            } else if (segue.identifier == "DayiscommingSegue") {
                selectedIndex = dayiscommingIndex
            }
            
            nextVC.data = Items[selectedIndex]
        }
    }
}
