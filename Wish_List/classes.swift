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

func makeDummy() -> [Wish_Item] {
    formatter.dateFormat = "yyyy/MM/dd"
    var Items:[Wish_Item]=[]
    var car = Wish_Item(name: "차",favorite: false,img: UIImage(named:"car"))
    car.price = 100000000
    car.save = 98000000
    car.d_day = formatter.date(from: "2018/06/01")
    Items += [car]
    var notebook = Wish_Item(name: "노트북",favorite: true)
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
