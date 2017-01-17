//
//  HoaDon.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class HoaDon{
    var maHoaDon: String
    var daThanhToan: Bool = false
    var ghiChu: String?
    var danhMucThuPhi: [DichVuSinhHoat]
    
    public init(mahoadon: String, dathanhtoan: Bool, ghichu: String){
        self.maHoaDon = mahoadon
        self.daThanhToan = dathanhtoan
        self.ghiChu = ghichu
        danhMucThuPhi = []
    }
}
