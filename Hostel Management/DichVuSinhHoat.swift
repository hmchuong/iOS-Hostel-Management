//
//  DichVuSinhHoat.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class DichVuSinhHoat{
    var chisocu: Int64
    var chisomoi: Int64
    var thang: Int16
    var tongtien: NSDecimalNumber
    var loaidichvu: LoaiDichVu
    
    public init(loaidichvu: LoaiDichVu, chisocu: Int64, chisomoi: Int64, thang: Int16, tongtien: NSDecimalNumber){
        self.loaidichvu = loaidichvu
        self.chisocu = chisocu
        self.chisomoi = chisomoi
        self.thang = thang
        self.tongtien = tongtien
    }
}
