//
//  HoaDon.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class HoaDon{
    var mahoadon: Int64
    var dathanhtoan: Bool = false
    var mota: String? // Ghi chú
    var dichvusinhhoat: [DichVuSinhHoat]
    
    public init(mahoadon: Int64, mota: String?){
        self.mahoadon = mahoadon
        self.mota = mota
        dichvusinhhoat = []
    }
}
