//
//  DichVuTarget.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/17/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

protocol DichVuTarget{
    func changePrice(_ gia: [(Int, Int)])
    func calculateMoney(chisocu: Int, chisomoi: Int) -> Int
}
