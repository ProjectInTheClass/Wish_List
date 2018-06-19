//
//  classes.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 4. 19..
//  Copyright © 2018년 test. All rights reserved.
//

import Foundation
import UIKit

class history {
    var info : String           //금액 변동 원인
    var money : Int             //얼마나 변동
    var date : Date             //언제
    var is_input : Bool         //넣었냐 뺐냐
    
    init(info : String, money : Int, date : Date, is_input : Bool){
        self.info = info
        self.money = money
        self.date = date
        self.is_input = is_input
    }
}

class Wish_Item {
    var name : String           //아이템 이름
    var price : Int?             //가격 (목표치)
    var d_day : Date?            //달성 기한
    var img : UIImage?           //동기부여를 위한 목표물 사진/이미지
    var save : Int              //해당 목표물에 내가 투자한 금액
    var m_info : Array<history>        //돈 넣고 뺀 기록
    var favorite : Bool         //즐겨찾기
    var endisnear : Bool        //달성임박
    var dayiscomming : Bool     //마감임박
    var money_monthly : Int?    //정기저축금
    var memo : String?           //이걸 위해 돈을 모으는 나를 향해 계획을 세운 내가 할 말
    var finishflag : Bool
    var endflag : Bool          /*완료 및 만기 flag. 리스트 정렬 시 맨 아래에 위치.
                                다른 모든 list관리에서 제외.*/
    
    init(name :String,favorite:Bool){
        self.name = name
        self.save = 0
        self.favorite = favorite
        self.endisnear = false
        self.dayiscomming = false
        self.finishflag = false
        self.endflag = false
        self.img = UIImage(named:"noimg")
        self.money_monthly = 0
        self.m_info = []
        //self.d_day = ""
    }
    
    init(name : String, favorite : Bool, img : UIImage?) {
        self.name = name
        self.save = 0
        self.favorite = favorite
        self.endisnear = false
        self.dayiscomming = false
        self.img = img
        self.finishflag = false
        self.endflag = false
        self.money_monthly = 0
        self.m_info = []
    }
    func loadpicture(img: UIImage?) {
        
    }
    
}

class WishItem_Save: NSObject, NSCoding {
    var name : String           //아이템 이름
    var price : Int
    var d_day : Date
    var save : Int              //해당 목표물에 내가 투자한 금액
    var favorite : Int         //즐겨찾기
    var money_monthly : Int
    var memo : String
    
    init(name: String, price: Int, d_day: Date, save: Int, favorite: Int, month: Int, memo:String){
        self.name = name
        self.price = price
        self.d_day = d_day
        self.save = save
        self.favorite = favorite
        self.money_monthly = month
        self.memo = memo
        //값을 집어넣을 때 예외처리를 해 주고 집어넣어야 함
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.price = Int(aDecoder.decodeCInt(forKey: "price"))
        self.d_day = (aDecoder.decodeObject(forKey: "d_day") as? Date)!
        self.save = Int(aDecoder.decodeCInt(forKey: "save"))
        self.favorite = Int(aDecoder.decodeCInt(forKey: "favorite"))
        self.money_monthly = Int(aDecoder.decodeCInt(forKey: "month"))
        self.memo = aDecoder.decodeObject(forKey: "memo") as? String ?? ""
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(memo, forKey: "memo")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(save, forKey: "save")
        aCoder.encode(favorite, forKey: "favorite")
        aCoder.encode(money_monthly, forKey: "month")
        aCoder.encode(d_day, forKey: "d_day")
    }
}

class history_Save: NSObject, NSCoding {
    var info : String           //금액 변동 원인
    var money : Int             //얼마나 변동
    var date : Date             //언제
    var is_input : Int         //넣었냐 뺐냐
    
    init(info: String, money: Int, date: Date, is_input:Int){
        //init 전에 예외처리를 하고 집어넣어야 함
        self.info = info
        self.money = money
        self.date = date
        self.is_input = is_input
    }
    required init?(coder aDecoder: NSCoder) {
        self.info = aDecoder.decodeObject(forKey: "info") as? String ?? ""
        self.date = (aDecoder.decodeObject(forKey: "date") as? Date)!
        self.money = Int(aDecoder.decodeCInt(forKey: "money"))
        self.is_input = Int(aDecoder.decodeCInt(forKey: "is_input"))
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(info, forKey: "info")
        aCoder.encode(money, forKey: "money")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(is_input, forKey: "is_input")
    }
}

func saveWishItem(){
    //test
    var items:[WishItem_Save] = []
    items.append(WishItem_Save(name: "a", price: 300, d_day: Date(), save: 100, favorite: 1, month: 3, memo: "hello1"))
    items.append(WishItem_Save(name: "b", price: 500, d_day: Date(), save: 200, favorite: 0, month: 5, memo: "hello2"))
    let wishdata = NSKeyedArchiver.archivedData(withRootObject: items)
    UserDefaults.standard.set(wishdata, forKey: "wishitems")
}

func loadWishItem(){
    //test
    guard let wishData = UserDefaults.standard.object(forKey: "wishitems") as? NSData else {
        print("errrrrror")
        return
    }
    guard let wishArray = NSKeyedUnarchiver.unarchiveObject(with: wishData as Data) as? [WishItem_Save] else{
        print("unarchive error")
        return
    }
    for wish in wishArray {
        print("")
        print("name: \(wish.name)")
    }
}



func makeDummy() -> [Wish_Item] {
    saveWishItem()
    loadWishItem()
    formatter.dateFormat = "yyyy/MM/dd"
    var Items:[Wish_Item]=[]
    let car = Wish_Item(name: "차",favorite: false,img: UIImage(named:"car"))
    car.price = 100000000
    car.save = 98000000
    car.d_day = formatter.date(from: "2018/06/01")
    Items += [car]
    let notebook = Wish_Item(name: "노트북",favorite: true)
    notebook.price = 100000
    notebook.save = 10000
    notebook.d_day = formatter.date(from: "2018/06/01")
    Items += [notebook]
    let borrow = Wish_Item(name: "빌린 돈",favorite: true)
    borrow.price = 500000
    borrow.save = 45000
    borrow.d_day = formatter.date(from: "2018/07/01")
    Items += [borrow]
    let cloth = Wish_Item(name: "옷",favorite: false)
    cloth.price = 200000
    cloth.save = 10000
    cloth.d_day = formatter.date(from: "2019/01/01")
    Items += [cloth]
    let myhome = Wish_Item(name: "내집",favorite: false)
    myhome.price = 1000000000
    myhome.save = 0
    myhome.d_day = formatter.date(from: "2040/01/01")
    Items += [myhome]
    let month = Wish_Item(name: "월세",favorite: true)
    month.price = 10000000
    month.save = 300000
    month.d_day = formatter.date(from: "2018/07/01")
    Items += [month]
    let tele = Wish_Item(name: "통화비",favorite: true)
    tele.price = 50000
    tele.save = 50000
    tele.d_day = formatter.date(from: "2018/07/01")
    Items += [tele]
    let food = Wish_Item(name: "식비",favorite: false)
    food.price = 300000
    food.save = 100000
    food.d_day = formatter.date(from: "2018/06/01")
    Items += [food]
    let goldbar = Wish_Item(name: "금괴",favorite: false)
    goldbar.price = 1000000
    goldbar.save = 0
    goldbar.d_day = formatter.date(from: "2100/01/01")
    Items += [goldbar]
    return Items
}

let formatter = DateFormatter()

var Items:[Wish_Item] = makeDummy()
let no = Items.count
