//
//  ThamSoDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension ThamSoDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThamSoDB> {
        return NSFetchRequest<ThamSoDB>(entityName: "ThamSo");
    }

    @NSManaged public var giatri: String?
    @NSManaged public var kieu: String?
    @NSManaged public var mathamso: Int16
    @NSManaged public var ten: String?
    @NSManaged public var tinhtrang: String?

}
