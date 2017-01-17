//
//  DichVuSinhHoatDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension DichVuSinhHoatDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DichVuSinhHoatDB> {
        return NSFetchRequest<DichVuSinhHoatDB>(entityName: "DichVuSinhHoat");
    }

    @NSManaged public var thang: Int16
    @NSManaged public var tongtien: NSDecimalNumber?
    @NSManaged public var madichvu: Int32
    @NSManaged public var mahoadon: String?

}
