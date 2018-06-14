//
//  Functions.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 5. 18..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit
//progress bar 크기를 정함 (image view frame 크기를 변경시켜 크기 설정)
func progress(lists:Wish_Item) -> Float {
    var Percentage : Float
    if lists.price != nil{
        Percentage = Float(lists.save)/Float(lists.price!);
    }
    else if lists.price == 0{
        Percentage = 100;
    }
    else{
        Percentage = 0;
    }
    
    
    return Percentage
}
