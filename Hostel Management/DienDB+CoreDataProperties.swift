//
//  DienDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension DienDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DienDB> {
        return NSFetchRequest<DienDB>(entityName: "Dien");
    }

    @NSManaged public var madichvu: Int32
    @NSManaged public var mahoadon: String?
    @NSManaged public var chisocu: Int64
    @NSManaged public var chisomoi: Int64

}
