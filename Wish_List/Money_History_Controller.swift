//
//  Money_History_Controller.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 6. 19..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class History_info_CellView:UITableViewCell{
    @IBOutlet weak var Reason : UILabel?
    @IBOutlet weak var Day : UILabel?
    @IBOutlet weak var Money : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Reason?.adjustsFontSizeToFitWidth = true
        Reason?.minimumScaleFactor = 0.2
        Day?.adjustsFontSizeToFitWidth = true
        Day?.minimumScaleFactor = 0.2
        Money?.adjustsFontSizeToFitWidth = true
        Money?.minimumScaleFactor = 0.2
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        Reason?.text = nil
        Day?.text = nil
        Money?.text = nil
    }
}


class Money_History_Controller: UIViewController{
    var data : Wish_Item?
    @IBOutlet weak var D_day : UILabel? //d-day
    @IBOutlet weak var Save : UILabel?  //넣은 돈
    @IBOutlet weak var Lists : UITableView?
    @IBOutlet weak var Navibar: UINavigationBar?
    var mode : Int?
    var adds:Array<history>?
    var minuses:Array<history>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Navibar?.topItem?.title = data?.name
        Save?.text = (data?.save.description)! + "원"
        Save?.adjustsFontSizeToFitWidth = true
        Save?.minimumScaleFactor = 0.2
        
        Lists?.dataSource = self
        Lists?.delegate = self
        mode = 0
        var interval : Double
        var s = "-"
        interval = (data?.d_day?.timeIntervalSinceNow)!
        interval = interval / 86400
        if interval < 0 {
            interval = interval * -1
            s = "+"
        }
        D_day?.text = "D " + s + " " + (Int(interval)).description
        adds = []
        minuses = []
        for entry in (data?.m_info)!{
            if entry.is_input == true{
                adds?.append(entry)
            }
            else{
                minuses?.append(entry)
            }
        }
    }
    
    @IBAction func out(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func show_all(){
        mode = 0
        self.Lists?.reloadData()
    }
    
    @IBAction func show_in(){
        mode = 1
        self.Lists?.reloadData()
    }
    
    @IBAction func show_out(){
        mode = 2
        self.Lists?.reloadData()
    }
    // 뷰 컨트롤러 내에서 오버라이드하여 사용합니다.
    override var shouldAutorotate: Bool {
        return false // or false
    }
}

extension Money_History_Controller: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return proj.count
        if mode == 0 {
            return (data?.m_info.count)!
        }
        else if mode == 1{
            return (adds?.count)!
        }
        else{
            return (minuses?.count)!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return 4
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = Lists?.dequeueReusableCell(withIdentifier: "histories", for: indexPath as IndexPath) as! History_info_CellView // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.
        
        if mode == 0{
            let index = (data?.m_info.count)! - 1 - indexPath.row
            if data?.m_info[index].is_input == true{
                cell.Money?.textColor = UIColor.blue
                cell.Reason?.textColor = UIColor.blue
            }
            else{
                cell.Money?.textColor = UIColor.red
                cell.Reason?.textColor = UIColor.red
            }
        
            cell.Day?.text = formatter.string(from: (data?.m_info[index].date)!)
        
            cell.Money?.text = data?.m_info[index].money.description
            cell.Reason?.text = data?.m_info[index].info
            return cell
        }
        else if mode == 1 {
            let index = (adds?.count)! - 1 - indexPath.row
            cell.Money?.textColor = UIColor.blue
            cell.Reason?.textColor = UIColor.blue
            
            cell.Day?.text = formatter.string(from: (adds?[index].date)!)
            
            cell.Money?.text = adds?[index].money.description
            cell.Reason?.text = adds?[index].info
            return cell
        }
        else{
            let index = (minuses?.count)! - 1 - indexPath.row
            cell.Money?.textColor = UIColor.red
            cell.Reason?.textColor = UIColor.red
            
            cell.Day?.text = formatter.string(from: (minuses?[index].date)!)
            
            cell.Money?.text = minuses?[index].money.description
            cell.Reason?.text = minuses?[index].info
            return cell
        }
    }
}
extension Money_History_Controller: UITableViewDelegate{
    
}

