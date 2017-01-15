//
//  TinhTrangDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension TinhTrangDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TinhTrangDB> {
        return NSFetchRequest<TinhTrangDB>(entityName: "TinhTrang");
    }

    @NSManaged public var mota: String?

}
