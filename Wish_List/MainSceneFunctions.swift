//
//  MainSceneFunctions.swift
//  Wish_List
//
//  Created by ljh on 2018. 5. 25..
//  Copyright © 2018년 test. All rights reserved.
//

import Foundation

let endisnearCriterion = 0.7 // 달성률이 70% 이상일 때 달성임박
let dayiscommingCriterion : TimeInterval = 7 * 24 * 3600 // 마감일이 일주일 이하 남았을 때 마감임박

var favoriteIndex = 0
var endisnearIndex = 0
var dayiscommingIndex = 0

func getNextFavorite() {
    var curIndex = favoriteIndex + 1
    while (true) {
        if (curIndex >= Items.count) {
            curIndex = 0
        }
        if (curIndex == favoriteIndex) {
            if (!Items[favoriteIndex].favorite) {
                favoriteIndex = -1
            }
            break
        }
        if (Items[curIndex].favorite) {
            favoriteIndex = curIndex
            break
        }
        curIndex += 1
    }
}

func getNextEndisnear() {
    var curIndex = endisnearIndex + 1
    refreshEndisnear()
    while (true) {
        if (curIndex >= Items.count) {
            curIndex = 0
        }
        if (curIndex == endisnearIndex) {
            if (!Items[curIndex].endisnear) {
                endisnearIndex = -1
            }
            break
        }
        if (Items[curIndex].endisnear) {
            endisnearIndex = curIndex
            break
        }
        curIndex += 1
    }
}

func getNextDayiscoming() {
    var curIndex = dayiscommingIndex + 1
    refreshDayiscomming()
    while (true) {
        if (curIndex >= Items.count) {
            curIndex = 0
        }
        if (curIndex == dayiscommingIndex) {
            if (!Items[curIndex].endisnear) {
                dayiscommingIndex = -1
            }
            break
        }
        if (Items[curIndex].dayiscomming) {
            dayiscommingIndex = curIndex
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
        } else {
            item.dayiscomming = false
        }
    }
}
