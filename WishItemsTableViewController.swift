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
}
class WishItemsViewController : UIViewController{
    @IBOutlet weak var tableview: UITableView?
    
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
}

extension WishItemsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableview?.dequeueReusableCell(withIdentifier: "WishItems", for: indexPath as IndexPath) as! WishItemsCellView // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.
        cell.Itemname?.text = Items[indexPath.row].name
        cell.ItemImg?.image = Items[indexPath.row].img
        cell.BarFrame?.image = UIImage(named: "gauge")
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
    
class WishItemsTableViewController: UITableViewController {
    public var data:Wish_Item?;
    
    var nameLabel:UILabel?
    var imageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView)-> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "WishItems", for: indexPath)
        
        cell.textLabel?.text = Items[indexPath.row].name
        cell.detailTextLabel?.text = Items[indexPath.row].favorite.description
        
        // Configure the cell...
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
