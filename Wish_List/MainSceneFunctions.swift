//
//  MainSceneFunctions.swift
//  Wish_List
//
//  Created by ljh on 2018. 5. 25..
//  Copyright © 2018년 test. All rights reserved.
//

import Foundation

let endisnearCriterion = 0.7 // 달성률이 70% 이상일 때 달성임박
let dayiscommingCriterion : TimeInterval = 21 * 24 * 3600 // 마감일이 일주일 이하 남았을 때 마감임박

var favoriteIndex = -1
var endisnearIndex = -1
var dayiscommingIndex = -1

func getNextFavorite() {
    var curIndex = favoriteIndex + 1
    var InitIndex = favoriteIndex
    if (Items.count == 0) {
        favoriteIndex = -1
        return
    }
    if (favoriteIndex == -1) {
        curIndex = 0
        InitIndex = Items.count - 1
    }
    while (true) {
        if (curIndex >= Items.count) {
            curIndex = 0
        }
        
        if (Items[curIndex].favorite && !Items[curIndex].finishflag) { // 즐겨찾기는 마감일이 지나도 표시됩니다.
            favoriteIndex = curIndex
            break
        }
        if (curIndex == InitIndex) {
            favoriteIndex = -1
            break
        }
        curIndex += 1
    }
}

func getNextEndisnear() {
    var curIndex = endisnearIndex + 1
    var InitIndex = endisnearIndex
    if (Items.count == 0) {
        endisnearIndex = -1
        return
    }
    if (endisnearIndex == -1) {
        curIndex = 0
        InitIndex = Items.count - 1
    }
    refreshEndisnear()
    while (true) {
        if (curIndex >= Items.count) {
            curIndex = 0
        }
        if (Items[curIndex].endisnear && !Items[curIndex].finishflag && !Items[curIndex].endflag) {
            endisnearIndex = curIndex
            break
        }
        if (curIndex == InitIndex) {
            endisnearIndex = -1
            break
        }
        curIndex += 1
    }
}

func getNextDayiscoming() {
    var curIndex = dayiscommingIndex + 1
    var InitIndex = dayiscommingIndex
    if (Items.count == 0) {
        dayiscommingIndex = -1
        return
    }
    if (dayiscommingIndex == -1) {
        curIndex = 0
        InitIndex = Items.count - 1
    }
    refreshDayiscomming()
    while (true) {
        if (curIndex >= Items.count) {
            curIndex = 0
        }
        if (Items[curIndex].dayiscomming && !Items[curIndex].endflag && !Items[curIndex].finishflag) {
            dayiscommingIndex = curIndex
            break
        }
        if (curIndex == InitIndex) {
            dayiscommingIndex = -1
            break
        }
        curIndex += 1
    }
}

func refreshEndisnear() {
    var temp : Double
    for item in Items {
        temp = Double(item.save) / Double(item.price!)
        if (temp > endisnearCriterion) {
            item.endisnear = true
            if (item.save >= item.price!) {
                item.finishflag = true
            }
        } else {
            item.endisnear = false
        }
    }
}

func refreshDayiscomming() {
    for item in Items {
        if (item.d_day == nil) {
            continue;
        }
        if (Date().timeIntervalSince(item.d_day!) > -dayiscommingCriterion) {
            item.dayiscomming = true
            if (Date().timeIntervalSince(item.d_day!) > 0) {
                item.endflag = true
            }
        } else {
            item.dayiscomming = false
        }
    }
}
