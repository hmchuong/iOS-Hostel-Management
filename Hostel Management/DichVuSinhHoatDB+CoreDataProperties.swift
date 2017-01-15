//
//  DichVuSinhHoatDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension DichVuSinhHoatDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DichVuSinhHoatDB> {
        return NSFetchRequest<DichVuSinhHoatDB>(entityName: "DichVuSinhHoat");
    }

    @NSManaged public var chisocu: Int64
    @NSManaged public var chisomoi: Int64
    @NSManaged public var thang: Int16
    @NSManaged public var tongtien: NSDecimalNumber?
    @NSManaged public var loaidichvu: LoaiDichVuDB?

}
