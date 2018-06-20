//
//  navicontroller.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 6. 20..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class Navi : UINavigationController{
    // 뷰 컨트롤러 내에서 오버라이드하여 사용합니다.
    override var shouldAutorotate: Bool {
        return false // or false
    }
}

class tabbar : UITabBarController{
    // 뷰 컨트롤러 내에서 오버라이드하여 사용합니다.
    override var shouldAutorotate: Bool {
        return false // or false
    }
}
