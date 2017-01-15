//
//  LoaiDichVuDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension LoaiDichVuDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoaiDichVuDB> {
        return NSFetchRequest<LoaiDichVuDB>(entityName: "LoaiDichVu");
    }

    @NSManaged public var ten: String?

}
