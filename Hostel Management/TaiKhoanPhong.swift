//
//  NguoiThueTro.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData

public class TaiKhoanPhong{
    var id: String
    var matoken: String
    
    public init(id: String, matoken: String){
        self.id = id
        self.matoken = matoken
        print ("\(id)")
        print("\(matoken)")
    }
}
