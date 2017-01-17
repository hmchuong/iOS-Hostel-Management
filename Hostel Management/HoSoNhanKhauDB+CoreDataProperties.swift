//
//  HoSoNhanKhauDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension HoSoNhanKhauDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoSoNhanKhauDB> {
        return NSFetchRequest<HoSoNhanKhauDB>(entityName: "HoSoNhanKhau");
    }

    @NSManaged public var cmnd: String?
    @NSManaged public var diachithuongtru: String?
    @NSManaged public var hoten: String?
    @NSManaged public var mahoso: Int16
    @NSManaged public var ngaysinh: NSDate?
    @NSManaged public var nghenghiep: String?
    @NSManaged public var quequan: String?
    @NSManaged public var sodienthoai: String?
    @NSManaged public var phong: String?
    @NSManaged public var gioitinh: Int16

}
