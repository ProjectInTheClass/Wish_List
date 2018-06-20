//
//  classes.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 4. 19..
//  Copyright © 2018년 test. All rights reserved.
//

enum readSaveError: Error {
    case nodata
    case unarchive
}

enum sortMethod: Int {
    case deadline
    case price
    case progress
}

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
    var d_day : String
    var save : Int              //해당 목표물에 내가 투자한 금액
    var favorite : Int         //즐겨찾기
    var money_monthly : Int
    var memo : String
    
    init(name: String, price: Int, d_day: String, save: Int, favorite: Int, month: Int, memo:String){
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
        self.d_day = aDecoder.decodeObject(forKey: "d_day") as? String ?? ""
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
    var date : String             //언제
    var is_input : Int         //넣었냐 뺐냐
    
    init(info: String, money: Int, date: String, is_input:Int){
        //init 전에 예외처리를 하고 집어넣어야 함
        self.info = info
        self.money = money
        self.date = date
        self.is_input = is_input
    }
    required init?(coder aDecoder: NSCoder) {
        self.info = aDecoder.decodeObject(forKey: "info") as? String ?? ""
        self.date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
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
/*
func testsaveWishItem(){
    //test
    var items:[WishItem_Save] = []
    items.append(WishItem_Save(name: "a", price: 300, d_day: Date(), save: 100, favorite: 1, month: 3, memo: "hello1"))
    items.append(WishItem_Save(name: "b", price: 500, d_day: Date(), save: 200, favorite: 0, month: 5, memo: "hello2"))
    let wishdata = NSKeyedArchiver.archivedData(withRootObject: items)
    UserDefaults.standard.set(wishdata, forKey: "wishitems")
}

func testloadWishItem(){
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
 */

//(이름)_history key 로 저장
func saveHistory(name:String, histories: [history]){
    formatter.dateFormat = "yyyy/MM/dd"
    var historyList:[history_Save] = []
    for his in histories {
        let input = his.is_input ? 1 : 0
        let day = formatter.string(from: his.date)
        historyList.append(history_Save(info: his.info, money: his.money, date: day, is_input: input))
    }
    let hisdata = NSKeyedArchiver.archivedData(withRootObject: historyList)
    UserDefaults.standard.set(hisdata, forKey: "\(name)_history")
}

//name과 일치하는 history를 뽑아옴
//nodata error : 해당 이름의 history가 없음
func loadHistory(name:String) throws -> [history]{
    formatter.dateFormat = "yyyy/MM/dd"
    var his:[history] = []
    guard let hisData = UserDefaults.standard.object(forKey: "\(name)_history") as? NSData else {
        print("error in loadhistory")
        throw readSaveError.nodata
    }
    guard let historyList = NSKeyedUnarchiver.unarchiveObject(with: hisData as Data) as? [history_Save] else{
        print("error in unarchive history")
        throw readSaveError.unarchive
    }
    
    for his_save in historyList {
        let input = his_save.is_input == 1 ? true : false
        let day = formatter.date(from: his_save.date)
        his.append(history(info: his_save.info, money: his_save.money, date: day!, is_input: input))
    }
    return his
}

//wishitems key로 저장함
func saveWishItem(WishList: [Wish_Item]){
    formatter.dateFormat = "yyyy/MM/dd"
    var savelist:[WishItem_Save] = []
    for wish in WishList {
        var price = 0
        var month = 0
        var memo = ""
        let name = wish.name
        let favor = wish.favorite ? 1 : 0
        let save = wish.save
        let date = formatter.string(from: wish.d_day!)
        
        //check nil
        if let wprice = wish.price {
            price = wprice
        }
        if let wmonth = wish.money_monthly {
            month = wmonth
        }
        if let wmemo = wish.memo {
            memo = wmemo
        }
        saveHistory(name: wish.name, histories: wish.m_info)
        print("in savewish, date:\(date)")
        savelist.append(WishItem_Save(name: name, price: price, d_day: date, save: save, favorite: favor, month: month, memo: memo))
        
    }
    
    let wishdata = NSKeyedArchiver.archivedData(withRootObject: savelist)
    UserDefaults.standard.set(wishdata, forKey: "wishitems")
}

func loadWishItem() throws -> [Wish_Item]{
    formatter.dateFormat = "yyyy/MM/dd"
    var wish:[Wish_Item] = []
    guard let wishdata = UserDefaults.standard.object(forKey: "wishitems") as? NSData else {
        print("error in loadWishItem")
        throw readSaveError.nodata
    }
    guard let wishitemList = NSKeyedUnarchiver.unarchiveObject(with: wishdata as Data) as? [WishItem_Save] else{
        print("error in unarchive wishitems")
        throw readSaveError.unarchive
    }
    
    for wish_save in wishitemList {
        let favor = wish_save.favorite == 1 ? true : false
        let item = Wish_Item(name: wish_save.name, favorite: favor)
        let date = formatter.date(from: wish_save.d_day)
        item.d_day = date
        item.save = wish_save.save

        print("day:\(wish_save.d_day)")
        if wish_save.price != 0 {
            item.price = wish_save.price
        }
        if wish_save.money_monthly != 0 {
            item.money_monthly = wish_save.money_monthly
        }
        if !wish_save.memo.isEmpty {
            item.memo = wish_save.memo
        }
        
        do {
            try item.m_info = loadHistory(name: wish_save.name)
        } catch readSaveError.nodata{
            print("no data")
        } catch readSaveError.unarchive{
            print("can not unarchive")
        }
        //item.m_info = loadHistory(name: wish_save.name)
        wish.append(item)
        
      
    }
    return wish
}


func makeDummy() -> [Wish_Item] {
    formatter.dateFormat = "yyyy/MM/dd"
    var Items:[Wish_Item]=[]
    let car = Wish_Item(name: "차",favorite: false,img: UIImage(named:"car"))
    car.price = 100000000
    car.save = 98000000
    car.d_day = formatter.date(from: "2018/06/01")
    let a = history(info: "ddd", money: 10000, date: formatter.date(from: "2018/06/01")!, is_input: true)
    car.m_info.append(a)
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
    saveWishItem(WishList: Items)
    return Items
}

let formatter = DateFormatter()


func getitem() -> [Wish_Item] {
    var Item:[Wish_Item] = []
    
    do {
        try Item = loadWishItem()
    } catch readSaveError.nodata{
        print("no data")
    } catch readSaveError.unarchive{
        print("can not unarchive")
    } catch {
        print("무슨 짓을 하셨길래 이 에러가 출력되나요?")
    }
    
    return Item
}

var Items:[Wish_Item] = makeDummy()
//var Items:[Wish_Item] = loadWishItem()
//var Items:[Wish_Item] = getitem()
let no = Items.count
