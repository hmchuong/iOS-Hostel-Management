//
//  NhaTro.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/12/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class NhaTro{
    // MARK: - Properties
    public var sophong: Int64 = 0
    var diachi: String? = nil
    var ten: String? = nil
    var phongtro: [PhongTro] = []{
        didSet{
            var count = 0
            for ins in phongtro{
                if ins.tinhtrang == .trong{
                    count += 1
                }
            }
            sophong = Int64(count)
        }
    }
    
    // MARK: - Methods
    public init(diachi: String, ten: String){
        self.diachi = diachi
        self.ten = ten
    }
}

