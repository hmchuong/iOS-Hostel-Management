//
//  File.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 12/31/16.
//  Copyright © 2016 chuonghuynh. All rights reserved.
//

import Foundation

let mainHexColor: String = "#b32401"
let nonAccount: String = "Chưa có"

let existedAccount: String = "Tên đăng nhập đã tồn tại!"
let successfulSignUp: String = "Đăng ký thành công!"
let unsuccessfulSignUp: String = "Không có tên đăng nhập hoặc mật khẩu!"
let undefinedError: String = "Lỗi không xác định"

let unsuccessfulLogin: String = "Cannot login"
let wrongAccount: String = "Tên đăng nhập hoặc mật khẩu sai!"
let successfulLogin: String = "Đăng nhập thành công"

let existedHostel = "Nhà trọ đã tồn tại!"
let existedRoom = "Phòng đã tồn tại"
let errorDB = "Lỗi database"

// KEY SHAREPREFERENCES
let KEYUSERNAME = "CURRENTUSERNAME"
let KEYPASSWORD = "CURRENTPASSWORD"
let KEYISCHUNHA = "ISCHUNHA"

public enum TinhTrang: String{
    case trong = "trống"
    case daThue = "đã thuê"
    case suaChua = "sửa chữa"
    static func fromHashValue(hashValue: Int) -> TinhTrang {
        if hashValue == 0 {
            return .trong
        } else if hashValue == 1 {
            return .daThue
        } else {
            return .suaChua
        }
    }
}

public enum GioiTinh: String {
    case nam = "nam"
    case nu = "nữ"
    static func fromHashValue(hashValue: Int) -> GioiTinh {
        if hashValue == 0 {
            return .nam
        } else {
            return .nu
        }
    }
}

public enum LoaiDichVu: String{
    case dien = "điện"
    case nuoc = "nước"
    case internet = "internet"
    static func fromHashValue(hashValue: Int) -> LoaiDichVu {
        if hashValue == 0 {
            return .dien
        } else if hashValue == 1 {
            return .nuoc
        } else {
            return .internet
        }
    }

}

