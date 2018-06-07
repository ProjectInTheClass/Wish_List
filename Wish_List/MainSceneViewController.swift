//
//  MainSceneViewController.swift
//  Wish_List
//
//  Created by ljh on 2018. 5. 31..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController {

    @IBOutlet weak var FavoriteImage: UIImageView!
    @IBOutlet weak var FavoriteName: UILabel!
    @IBOutlet weak var FavoriteDeadline: UILabel!
    @IBOutlet weak var FavoriteSaved: UILabel!
    @IBOutlet weak var FavoriteGoal: UILabel!
    @IBOutlet weak var FavoriteProgressBar: UIProgressView!
    @IBOutlet weak var FavoriteProgress: UILabel!

    @IBOutlet weak var EndisnearImage: UIImageView!
    @IBOutlet weak var EndisnearName: UILabel!
    @IBOutlet weak var EndisnearDeadline: UILabel!
    @IBOutlet weak var EndisnearSaved: UILabel!
    @IBOutlet weak var EndisnearGoal: UILabel!
    @IBOutlet weak var EndisnearProgressBar: UIProgressView!
    @IBOutlet weak var EndisnearProgress: UILabel!
    
    @IBOutlet weak var DayiscommingImage: UIImageView!
    @IBOutlet weak var DayiscommingName: UILabel!
    @IBOutlet weak var DayiscommingDeadline: UILabel!
    @IBOutlet weak var DayiscommingSaved: UILabel!
    @IBOutlet weak var DayiscommingGoal: UILabel!
    @IBOutlet weak var DayiscommingProgressBar: UIProgressView!
    @IBOutlet weak var DayiscommingProgress: UILabel!
    
    @IBAction func FavoriteRefresh(_ sender: Any) {
        getNextFavorite()
        RefreshFavoriteCell()
    }
    
    func RefreshFavoriteCell () {
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
        DayiscommingImage.image = Items[dayiscommingIndex].img
        DayiscommingName.text = Items[dayiscommingIndex].name
        DayiscommingDeadline.text = formatter.string(from: Items[dayiscommingIndex].d_day!)
        DayiscommingSaved.text = String(Items[dayiscommingIndex].save) + "원"
        DayiscommingGoal.text = String(Items[dayiscommingIndex].price!) + "원"
        DayiscommingProgressBar.progress = Float(Items[dayiscommingIndex].save) / Float(Items[dayiscommingIndex].price!)
        DayiscommingProgress.text = String(Int((DayiscommingProgressBar.progress * 100).rounded())) + "%"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getNextFavorite()
        getNextEndisnear()
        getNextDayiscoming()
        RefreshFavoriteCell()
        RefreshEndisnearCell()
        RefreshDayiscommingCell()
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
