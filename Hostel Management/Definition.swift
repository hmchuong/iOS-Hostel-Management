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


// KEY SHAREPREFERENCES
let KEYUSERNAME = "CURRENTUSERNAME"
let KEYPASSWORD = "CURRENTPASSWORD"
let KEYISCHUNHA = "ISCHUNHA"

enum TinhTrang: String{
    case trong = "trống"
    case daThue = "đã thuê"
    case suaChua = "sửa chữa"
}

enum GioiTinh: String{
    case nam = "nam"
    case nu = "nữ"
}

enum LoaiDichVu: String{
    case dien = "điện"
    case nuoc = "nước"
    case internet = "internet"
}

