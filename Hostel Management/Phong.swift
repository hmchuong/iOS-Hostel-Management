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

class PhongTro{
    // MARK: - Properties
    var maphong: String
    var dientich: Double
    var giaphong: NSDecimalNumber
    var tinhtrang: TinhTrang
    var hinhanhphong: [UIImage]
    var nguoithue: NguoiThueTro?
    var hosonhankhau: [HoSoNhanKhau]
    var hoadon: [HoaDon]
    
    public init(maphong: String, dientich: Double?, giaphong: NSDecimalNumber?, tinhtrang: TinhTrang){
        self.maphong = maphong
        self.dientich = dientich ?? 0
        self.giaphong = giaphong ?? 0
        self.tinhtrang = tinhtrang
        self.hinhanhphong = [#imageLiteral(resourceName: "PhongTro")]
        self.nguoithue = nil
        self.hosonhankhau = []
        self.hoadon = []
    }
    
}
