//
//  WishItemsTableViewController.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 4. 19..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class WishItemsCellView:UITableViewCell{
    @IBOutlet weak var Itemname:UILabel?
    @IBOutlet weak var Price : UILabel?
    @IBOutlet weak var Money : UILabel?
    @IBOutlet weak var ItemImg : UIImageView?
    @IBOutlet weak var Date : UILabel?
    @IBOutlet weak var BarFrame : UIImageView?
    @IBOutlet weak var Bar : UIImageView?
    @IBOutlet weak var Percentage : UILabel?
}
class WishItemsViewController : UIViewController{
    @IBOutlet weak var tableview: UITableView?
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
            Items.sort(by: {$0.d_day! < $1.d_day!})
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //let list:[String] = ["즐겨찾기","달성임박","마감임박","전체"]
        
        //return list[section]
        return "전체"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableview?.dequeueReusableCell(withIdentifier: "WishItems", for: indexPath as IndexPath) as! WishItemsCellView // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.
        cell.Itemname?.text = proj[indexPath.row].name
        cell.ItemImg?.image = proj[indexPath.row].img
        cell.BarFrame?.image = UIImage(named: "gauge")
        
        if proj[indexPath.row].price == nil {
            cell.Price?.text = "가격 미상"
        }
        else{
            cell.Price?.text = proj[indexPath.row].price?.description
        }
        cell.Money?.text = proj[indexPath.row].save.description
        /*
        let percent:CGFloat
        if proj[indexPath.row].price != nil{
            let pric:CGFloat = CGFloat(proj[indexPath.row].price!)
            percent = CGFloat(proj[indexPath.row].save) / pric
        }
        else{
            percent = 0
        }
        let new_width = (cell.Bar?.frame.size.width)! * percent
        cell.Bar?.frame.size = CGSize(width: new_width, height: (cell.Bar?.frame.size.height)!)
         */
        
        var prog: CGFloat
        if proj[indexPath.row].price != nil{
            let pric:CGFloat = CGFloat(proj[indexPath.row].price!)
            prog = progress(origin: (cell.Bar)!,full: pric,compare: CGFloat(proj[indexPath.row].save))
            prog = prog * 100
            cell.Percentage?.text = prog.description + "%"
        }
        else{
            prog = progress(origin: (cell.Bar)!,full: 0,compare: CGFloat(proj[indexPath.row].save))
            prog = prog * 100
            cell.Percentage?.text = prog.description + "%"
        }
        
        cell.Bar?.image = UIImage(named: "green")
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
