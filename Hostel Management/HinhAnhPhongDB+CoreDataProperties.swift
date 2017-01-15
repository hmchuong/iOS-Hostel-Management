//
//  HinhAnhPhongDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension HinhAnhPhongDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HinhAnhPhongDB> {
        return NSFetchRequest<HinhAnhPhongDB>(entityName: "HinhAnhPhong");
    }

    @NSManaged public var anh: NSData?

}
