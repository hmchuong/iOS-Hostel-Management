//
//  HoSoNhanKhau.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class HoSoNhanKhau{
    var cmnd: String?
    var diachithuongtru: String?
    var hoten: String?
    var ngaysinh: NSDate?
    var nghenghiep: String?
    var id: Int16
    var quequan: String?
    var sodienthoai: String?
    var gioitinh: GioiTinh?
    
    public init(id: Int16, hoten: String?, cmnd: String?, diachithuongtru: String?, ngaysinh: NSDate?, quequan: String?,sodienthoai: String?, gioitinh: GioiTinh?){
        self.id = id
        self.hoten = hoten ?? ""
        self.cmnd = cmnd ?? ""
        self.diachithuongtru = diachithuongtru ?? ""
        self.ngaysinh = ngaysinh ?? NSDate(dateString: "2000-01-01")
        self.quequan = quequan ?? ""
        self.sodienthoai = sodienthoai ?? ""
        self.gioitinh = gioitinh ?? GioiTinh.nam
    }
}
