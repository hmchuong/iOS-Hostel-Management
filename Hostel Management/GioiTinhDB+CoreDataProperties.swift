//
//  GioiTinhDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension GioiTinhDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GioiTinhDB> {
        return NSFetchRequest<GioiTinhDB>(entityName: "GioiTinh");
    }

    @NSManaged public var mota: String?

}
