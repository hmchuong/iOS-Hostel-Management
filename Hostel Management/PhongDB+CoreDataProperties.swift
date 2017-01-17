//
//  PhongDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension PhongDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhongDB> {
        return NSFetchRequest<PhongDB>(entityName: "Phong");
    }

    @NSManaged public var dientich: Double
    @NSManaged public var giaphong: NSDecimalNumber?
    @NSManaged public var maphong: String?
    @NSManaged public var ten: String?
    @NSManaged public var nhatro: String?
    @NSManaged public var tinhtrang: Int16
    @NSManaged public var nguoithue: String?

}
