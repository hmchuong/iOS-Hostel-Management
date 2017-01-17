//
//  NhaTro.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/12/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

public class NhaTro{
    // MARK: - Properties
    var soPhongTrong: Int
    var diaChi: String? = nil
    var ten: String? = nil
    var maNhaTro: String
    var phongTro: [Phong] = []{
        didSet{
            soPhongTrong = 0
            for ins in self.phongTro{
                if ins.tinhTrang == .trong{
                    soPhongTrong += 1
                }
            }
        }
    }
    
    // MARK: - Methods
    public init(manhatro: String, diachi: String, ten: String){
        self.diaChi = diachi
        self.ten = ten
        self.soPhongTrong = 0
        self.maNhaTro = manhatro
    }
}

