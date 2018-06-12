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
    @IBOutlet weak var ProgressBar : UIProgressView?
    @IBOutlet weak var OuterProgressBar : UIProgressView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    //var proj:[Wish_Item] = Items        //저장된 class list(Items = test list)를 proj가 참조
    var tempItem:Wish_Item? = nil
    let Bg = UIImageView(image:UIImage(named: "background"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview?.rowHeight = 106
        tableview?.dataSource = self
        tableview?.delegate = self
        Bg.contentMode = .scaleToFill
        tableview?.backgroundView = Bg
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sortItemList(_ sender: Any) {
        let selectSortMethod = UIAlertController(title: "목록 정렬 방식", message: "", preferredStyle: .actionSheet)
        let sortByDeadline = UIAlertAction(title:"마감일에 따라 정렬", style:.default, handler: {(action:UIAlertAction) -> Void in
            Items.sort(by: {$0.d_day! < $1.d_day!})
            self.tableview?.reloadData()
        })
        let sortByPrice = UIAlertAction(title:"목표금액에 따라 정렬", style:.default, handler: {(action:UIAlertAction) -> Void in
            Items.sort(by: {$0.price != nil && ($1.price == nil || $0.price! < $1.price!)})
            self.tableview?.reloadData()
        })
        let sortByProgress = UIAlertAction(title:"달성도에 따라 정렬", style:.default, handler: {(action:UIAlertAction) -> Void in
            Items.sort(by: {$0.price != nil && ($1.price == nil || Double($0.save) / Double($0.price!) > Double($1.save) / Double($1.price!))})
            self.tableview?.reloadData()
        })
        
        selectSortMethod.addAction(sortByDeadline)
        selectSortMethod.addAction(sortByPrice)
        selectSortMethod.addAction(sortByProgress)
        
        self.present(selectSortMethod, animated:true, completion:nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*if let tmpItem = tempItem {
            proj.append(tmpItem)
            self.tableview?.reloadData()
        }*/
        self.tableview?.reloadData()
    }
}

extension WishItemsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return proj.count
        return Items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
        //return 4
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let Bg = UIImageView(image:UIImage(named: "background"))
        Bg.contentMode = .scaleToFill
        let cell = tableview?.dequeueReusableCell(withIdentifier: "WishItems", for: indexPath as IndexPath) as! WishItemsCellView // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.
        cell.selectedBackgroundView = Bg
        cell.Itemname?.text = Items[indexPath.row].name
        cell.ItemImg?.image = Items[indexPath.row].img
        cell.ItemImg?.layer.borderWidth = 1
        cell.ItemImg?.layer.masksToBounds = false
        cell.ItemImg?.layer.borderColor = UIColor.black.cgColor
        cell.ItemImg?.layer.cornerRadius = (cell.ItemImg?.frame.height)! / 2
        cell.ItemImg?.clipsToBounds = true
        
        if Items[indexPath.row].price == nil {
            cell.Price?.text = "가격 미상"
        }
        else{
            cell.Price?.text = (Items[indexPath.row].price?.description)! + "원"
        }
        cell.Money?.text = Items[indexPath.row].save.description + "원"
        var percent:Float
        
        percent = progress(lists:Items[indexPath.row])
        cell.Percentage?.text = String(format: "%.1f",(percent*100)) + "%"
        cell.ProgressBar?.progress = percent
        
        //if Items[indexPath.row].d_day == {
          //  cell.Date?.text = "기간 제한 없음"
        //}
        //else{
            cell.Date?.text = formatter.string(from: Items[indexPath.row].d_day!)
        //}
        
        return cell
    }
}

extension WishItemsViewController: UITableViewDelegate{
    
}
