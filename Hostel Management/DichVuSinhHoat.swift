//
//  DichVuSinhHoat.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class DichVuSinhHoat{
    internal var maDichVu: Int32
    internal var thang: Int16
    internal var dichVuTarget: DichVuTarget? = nil
    
    required init(madichvu: Int32, thang: Int16){
        self.maDichVu = madichvu
        self.thang = thang 
    }
}
