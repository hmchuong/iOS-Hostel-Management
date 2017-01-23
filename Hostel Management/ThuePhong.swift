//
//  ThuePhong.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/17/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

public class ThuePhong{
    // MARK: - Properties
    var dsThanhVien: [HoSoNhanKhau]?
    var hoaDon: [HoaDon]?
    var taiKhoanPhong: TaiKhoanPhong?
    
    // MARK: - Methods
    public init(id: String, token: String){
        dsThanhVien = []
        hoaDon = []
        taiKhoanPhong = TaiKhoanPhong(id: id, matoken: token)
    }
}
