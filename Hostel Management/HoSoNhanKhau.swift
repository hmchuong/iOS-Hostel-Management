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
    var diaChiThuongTru: String?
    var hoTen: String?
    var ngaySinh: NSDate?
    var ngheNghiep: String?
    var maHoSo: String?
    var queQuan: String?
    var soDienThoai: String?
    var gioiTinh: GioiTinh?
    
    public init(mahoso: String, hoten: String?, cmnd: String?, diachithuongtru: String?, ngaysinh: NSDate?, quequan: String?,sodienthoai: String?, gioitinh: GioiTinh?){
        self.maHoSo = mahoso
        self.hoTen = hoten ?? ""
        self.cmnd = cmnd ?? ""
        self.diaChiThuongTru = diachithuongtru ?? ""
        self.ngaySinh = ngaysinh ?? NSDate(dateString: "2000-01-01")
        self.queQuan = quequan ?? ""
        self.soDienThoai = sodienthoai ?? ""
        self.gioiTinh = gioitinh ?? GioiTinh.nam
    }
}
