//
//  PhongTro.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Phong{
    // MARK: - Properties
    var maPhong: String
    var ten: String
    var dienTich: Double
    var giaPhong: NSDecimalNumber
    var tinhTrang: TinhTrang{
        didSet{
            if tinhTrang != .daThue{
                thuePhong = nil
            }
        }
    }
    var hinhAnhMinhHoa: [UIImage]
    var thuePhong: ThuePhong? = nil{
        didSet{
            if thuePhong != nil{
                self.tinhTrang = .daThue
            }
        }
    }
    
    public init(maphong: String, ten: String, dientich: Double?, giaphong: NSDecimalNumber?, tinhtrang: TinhTrang){
        self.maPhong = maphong
        self.ten = ten
        self.dienTich = dientich ?? 0
        self.giaPhong = giaphong ?? 0
        self.tinhTrang = tinhtrang
        self.hinhAnhMinhHoa = []
    }
    
}
