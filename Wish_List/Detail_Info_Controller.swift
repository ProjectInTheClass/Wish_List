//
//  Detail_Info_Controller.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 6. 8..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

//돈 넣기/빼기 버튼 누르면, 액수와 내용 적기 위한 창 띄우기. 입력 없이 확인 누르면, 그냥 돈 넣기/ 빼기.

//버튼 누르는 시점을 기록, 시간은 그 당시 시간으로 기록?
//나중에 생각나서 누른 경우는? --> 사용자가 내용에 입력하게? 아니면 날짜를 수정하도록 옵션을 줄까?

//내역으로 적은 글이 너무 길어지는 경우? --> 자동 줄바꿈 등으로 전부 출력하게 할까?
//...으로 생략시키는 건 문제가 있음.
//변동 내역 누르면 따로 detail view 창 띄워서 볼 수 있게 하는건?

//내역 삭제는 불가. 다만 내용은 변경할 수 있음(액수 변경은 불가. 내역은 가능, 날짜는?)
class Detail_info_CellView:UITableViewCell{
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

class DetailViewController : UIViewController{
    var data:Wish_Item?;
    @IBOutlet weak var IMG : UIImageView?
    @IBOutlet weak var Money: UILabel?  //남은 돈
    @IBOutlet weak var MPD: UILabel?    //Money per day
    @IBOutlet weak var SPM: UILabel?    //save per month
    @IBOutlet weak var D_day : UILabel? //d-day
    @IBOutlet weak var E_day : UILabel? //expire day
    @IBOutlet weak var Save : UILabel?  //넣은 돈
    @IBOutlet weak var Price : UILabel?
    @IBOutlet weak var Percentage : UILabel?
    @IBOutlet weak var ProgressBar : UIProgressView?
    @IBOutlet weak var OuterProgressBar : UIProgressView?
    @IBOutlet weak var MoneyIn : UIButton?
    @IBOutlet weak var MoneyOut : UIButton?
    @IBOutlet weak var Memo : UILabel?
    @IBOutlet weak var Lists : UITableView?
    @IBOutlet weak var Navibar: UINavigationBar?
    @IBOutlet weak var back: UIView?

    @IBAction func out(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func delete(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ClickMinus(_ sender: Any) {
        Minussave(data : data!)
    }
    
    @IBAction func ClickPlus(_ sender: Any) {
        Addsave(data : data!)
    }
    
    override func viewDidLoad() {
        Navibar?.topItem?.title = data?.name
        
        Lists?.dataSource = self
        Lists?.delegate = self
        
        super.viewDidLoad()
        progressDesign(ProgressBar: ProgressBar,OuterProgressBar: OuterProgressBar)
        ImgDesign(Imgview: IMG!)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode =  UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        back?.layer.borderWidth = 1
        let money : Int
        if data?.price != nil{
            money = (data?.price)! - (data?.save)!
            Money?.text = money.description + "원"
            Money?.adjustsFontSizeToFitWidth = true
            Money?.minimumScaleFactor = 0.2
        }
        else{
            money = 0
            Money?.text = "가격 미상"
        }
        var interval : Double
        IMG?.image = data?.img
        
        if data?.d_day != nil{
            interval = (data?.d_day?.timeIntervalSinceNow)!
            interval = interval / 86400
            if interval < 0 {
                MPD?.text = "기한 만료됨"
            }
            else{
                MPD?.text = (Int(Double(money)/interval)).description + "원"
                MPD?.adjustsFontSizeToFitWidth = true
                MPD?.minimumScaleFactor = 0.2
            }
            var s = "-"
            if interval < 0 {
                interval = interval * -1
                s = "+"
            }
            D_day?.text = "D " + s + " " + (Int(interval)).description
        }
        else{
            MPD?.text = "날짜 미정"
            D_day?.text = "날짜 미정"
        }
        SPM?.text = (data?.money_monthly?.description)! + "원"
        SPM?.adjustsFontSizeToFitWidth = true
        SPM?.minimumScaleFactor = 0.2
        
        E_day?.text = formatter.string(from: (data?.d_day!)!)
        Save?.text = data?.save.description
        if data?.price != nil{
            Price?.text = data?.price?.description
        }
        else{
            Price?.text = "가격 미상"
        }
        let percent = progress(lists:data!)
        Percentage?.text = String(format: "%.1f",(percent*100)) + "%"
        ProgressBar?.progress = percent
        Memo?.text = data?.memo
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Navibar?.topItem?.title = data?.name
        self.Lists?.reloadData()
        let money : Int
        if data?.price != nil{
            money = (data?.price)! - (data?.save)!
            Money?.text = money.description + "원"
            Money?.adjustsFontSizeToFitWidth = true
            Money?.minimumScaleFactor = 0.2
        }
        else{
            money = 0
            Money?.text = "가격 미상"
        }
        var interval : Double
        IMG?.image = data?.img
        
        if data?.d_day != nil{
            interval = (data?.d_day?.timeIntervalSinceNow)!
            interval = interval / 86400
            if interval < 0 {
                MPD?.text = "기한 만료됨"
            }
            else{
                MPD?.text = (Int(Double(money)/interval)).description + "원"
                MPD?.adjustsFontSizeToFitWidth = true
                MPD?.minimumScaleFactor = 0.2
            }
            var s = "-"
            if interval < 0 {
                interval = interval * -1
                s = "+"
            }
            D_day?.text = "D " + s + " " + (Int(interval)).description
        }
        else{
            MPD?.text = "날짜 미정"
            D_day?.text = "날짜 미정"
        }
        SPM?.text = (data?.money_monthly?.description)! + "원"
        
        E_day?.text = formatter.string(from: (data?.d_day!)!)
        Save?.text = data?.save.description
        if data?.price != nil{
            Price?.text = data?.price?.description
        }
        else{
            Price?.text = "가격 미상"
        }
        let percent = progress(lists:data!)
        Percentage?.text = String(format: "%.1f",(percent*100)) + "%"
        ProgressBar?.progress = percent
        Memo?.text = data?.memo
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? ModifyViewController
        {
            nextVC.data = data
        }
        if let nextVC = segue.destination as? Money_History_Controller
        {
            nextVC.data = data
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func Addsave(data : Wish_Item){
        var addinput = 0
        
        let addController = UIAlertController(title: "입금", message: "얼마나 넣을까요?", preferredStyle: .alert)
        
        let AddAction1 = UIAlertAction(title: "입금", style: .default) { (action:UIAlertAction) in
            //돈을 추가하고 save와 진행바를 갱신
            let addtextField = addController.textFields![0] as UITextField
            let addInfo = addController.textFields![1] as UITextField
            addtextField.keyboardType = .decimalPad
            if Int(addtextField.text!) != nil {
                addinput = Int(addtextField.text!)!
                //handle exception here
                data.save += addinput
                
                let input_memo: String
                if addInfo.text != ""{
                    input_memo = addInfo.text!
                }
                else{
                    input_memo = "입금"
                }
                
                let add_his = history(info: input_memo, money: addinput, date: Date(), is_input: true)
                print(add_his.date, add_his.info, add_his.money)
                data.m_info.append(add_his)
                
                self.Save?.text = data.save.description
                let percent = progress(lists:data)
                self.Percentage?.text = String(format: "%.1f",(percent*100)) + "%"
                self.ProgressBar?.progress = percent
                self.Lists?.reloadData()
            }
            else {
                addinput  = 0
            }
            //
        }
        addController.addTextField { (textField) in
            textField.placeholder = "입금 금액"
            
        }
        addController.addTextField { (textField) in
            textField.placeholder = "입금 이유(선택)"
        }
        
        
        let action2 = UIAlertAction(title: "취소", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        addController.addAction(action2)
        addController.addAction(AddAction1)
        
        self.present(addController, animated: true, completion: nil)
        
    }
    
    func Minussave(data : Wish_Item){
        var minusinput = 0
        let minusController = UIAlertController(title: "출금", message: "얼마나 뺄까요?", preferredStyle: .alert)
        let MinusAction1 = UIAlertAction(title: "출금", style: .default) { (action:UIAlertAction) in
            //돈을 추가하고 save와 진행바를 갱신
            let minustextField = minusController.textFields![0] as UITextField
            let minusInfo = minusController.textFields![1] as UITextField
            minustextField.keyboardType = .decimalPad
            if Int(minustextField.text!) != nil{
                if Int(minustextField.text!)! > data.save{
                    //경고문 띄우기 "저축금보다 많은 금액을 출금하실 수 없습니다!"
                    let money_out_alert = UIAlertController(title: "오류!", message: "저축금보다 많은 금액을 출금하실 수 없습니다!",preferredStyle: .alert)
                    let alert_action = UIAlertAction(title: "확인", style: .default) { (action:UIAlertAction) in
                        
                    }
                    money_out_alert.addAction(alert_action)
                    self.present(money_out_alert, animated: true, completion: nil)
                }
                else{
                minusinput = Int(minustextField.text!)!
                //exceptionhandling here
                data.save -= minusinput
                    
                    let output_memo: String
                    if minusInfo.text != ""{
                        output_memo = minusInfo.text!
                    }
                    else{
                        output_memo = "출금"
                    }
                let min_his = history(info: output_memo, money: minusinput, date: Date(), is_input: false)
                data.m_info.append(min_his)
                
                self.Save?.text = data.save.description
                let percent = progress(lists:data)
                self.Percentage?.text = String(format: "%.1f",(percent*100)) + "%"
                self.ProgressBar?.progress = percent
                self.Lists?.reloadData()
                }
            }
            else {
                
            }
        }
        minusController.addTextField { (textField) in
            textField.placeholder = "출금 금액"
        }
        minusController.addTextField { (textField) in
            textField.placeholder = "출금 이유(선택)"
        }
        
        let action2 = UIAlertAction(title: "취소", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        minusController.addAction(action2)
        minusController.addAction(MinusAction1)
        
        self.present(minusController, animated: true, completion: nil)
    }
    
    
}

extension DetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return proj.count
        return (data?.m_info.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return 4
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = Lists?.dequeueReusableCell(withIdentifier: "histories", for: indexPath as IndexPath) as! Detail_info_CellView // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.
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
}
extension DetailViewController: UITableViewDelegate{
    
}
