//
//  Functions.swift
//  Wish_List
//
//  Created by 소스1 on 2018. 5. 18..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit
//progress bar 크기를 정함 (image view frame 크기를 변경시켜 크기 설정)
func progress(origin :UIImageView, full :CGFloat, compare :CGFloat) -> CGFloat{
    let percent:CGFloat
    if full == 0 {
        percent = 0
    }
    else if full < compare{
        percent = 1
    }
    else{
        percent = compare / full
    }
    let new_width = origin.frame.size.width * percent
    origin.frame.size = CGSize(width: new_width, height: origin.frame.size.height)
    
    return percent
}
