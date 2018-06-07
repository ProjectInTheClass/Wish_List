//
//  WishItemsTableViewController.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 4. 19..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit
/*
class ProgressBarView: UIView{
    var backgroundLayer : CALayer?
    var progressLayer : CALayer?

    func createPath(){
        let x = self.frame.width
        let y = self.frame.height
    }
    
    func setup() {
        let progressimage = UIImage(named: "green")
        progressLayer = CALayer()
        progressLayer?.frame = CGRect(x:self.frame.minX, y:self.frame.minY, width:self.frame.width,height:self.frame.height)
        progressLayer?.contents = progressimage
        //progressLayer?.cornerRadius = 40
        /*progressLayer?.lineWidth = 5
        progressLayer?.fillColor = nil
        progressLayer?.strokeColor = UIColor.green.cgColor
        progressLayer?.lineCap = kCALineCapRound
        progressLayer?.strokeEnd = 0.0
        */
        let image = UIImage(named: "gauge")
        backgroundLayer = CALayer()
        //backgroundLayer?.contents = image
        /*backgroundLayer.path =
        backgroundLayer?.lineWidth = 7
        backgroundLayer?.fillColor = nil
        backgroundLayer?.strokeColor = UIColor.lightGray.cgColor
    */
        self.layer.addSublayer(backgroundLayer!)
        self.layer.addSublayer(progressLayer!)
        
    }
    
    var progress: Float = 0 {
        didSet(newValue){
            //progressLayer?.strokeEnd = CGFloat(newValue)
        }
    }
}
*/
class progressSlider:UISlider{
    override func trackRect(forBounds bounds: CGRect)->CGRect{
        var result = super.trackRect(forBounds: bounds)
        //result.size.width = bounds.size.width
        result.size.height = 15
        result.origin.y = 8
        return result
    }
}

class WishItemsCellView:UITableViewCell{
    @IBOutlet weak var Itemname:UILabel?
    @IBOutlet weak var Price : UILabel?
    @IBOutlet weak var Money : UILabel?
    @IBOutlet weak var ItemImg : UIImageView?
    @IBOutlet weak var Date : UILabel?
    @IBOutlet weak var Percentage : UILabel?
    @IBOutlet weak var ProgressBar : UISlider?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProgressBar?.minimumTrackTintColor = UIColor(displayP3Red: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
        ProgressBar?.maximumTrackTintColor = UIColor(displayP3Red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        ProgressBar?.setThumbImage(UIImage(), for: .normal)
        ProgressBar?.isUserInteractionEnabled = false
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        Itemname?.text = nil
        Price?.text = nil
        Money?.text = nil
        ItemImg?.image = nil
        Percentage?.text = nil
        
    }
}
class WishItemsViewController : UIViewController{
    @IBOutlet weak var tableview: UITableView?
    @IBOutlet weak var AddButton : UIButton?
    var proj:[Wish_Item] = Items        //저장된 class list(Items = test list)를 proj가 참조
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview?.rowHeight = 106
        tableview?.dataSource = self
        tableview?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sortItemList(_ sender: Any) {
        let selectSortMethod = UIAlertController(title: "목록 정렬 방식", message: "", preferredStyle: .actionSheet)
        let sortByName = UIAlertAction(title: "이름에 따라 정렬", style: .default, handler: {(action:UIAlertAction) -> Void in
            Items.sort(by: {$0.name < $1.name})
            self.tableview?.reloadData()
        })
        let sortByDeadline = UIAlertAction(title:"마감일에 따라 정렬", style:.default, handler: {(action:UIAlertAction) -> Void in
            //Items.sort(by: {$0.d_day! < $1.d_day!})
            self.tableview?.reloadData()
        })
        
        selectSortMethod.addAction(sortByName)
        selectSortMethod.addAction(sortByDeadline)
        
        self.present(selectSortMethod, animated:true, completion:nil)
    }
    
    
}

extension WishItemsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proj.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
        //return 4
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableview?.dequeueReusableCell(withIdentifier: "WishItems", for: indexPath as IndexPath) as! WishItemsCellView // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.
        cell.Itemname?.text = proj[indexPath.row].name
        cell.ItemImg?.image = proj[indexPath.row].img
        
        if proj[indexPath.row].price == nil {
            cell.Price?.text = "가격 미상"
        }
        else{
            cell.Price?.text = (proj[indexPath.row].price?.description)! + "원"
        }
        cell.Money?.text = proj[indexPath.row].save.description + "원"
        let percent:Float
        
        percent = progress(lists:proj[indexPath.row])
        cell.Percentage?.text = String(format: "%.1f",(percent*100)) + "%"
        cell.ProgressBar?.setValue(percent, animated: true)
        
        //if Items[indexPath.row].d_day == {
          //  cell.Date?.text = "기간 제한 없음"
        //}
        //else{
          //  cell.Date?.text = Items[indexPath.row].d_day?.description
        //}
        
        return cell
    }
}

extension WishItemsViewController: UITableViewDelegate{
    
}
