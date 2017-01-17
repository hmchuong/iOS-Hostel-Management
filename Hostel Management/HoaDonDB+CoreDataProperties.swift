//
//  HoaDonDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension HoaDonDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoaDonDB> {
        return NSFetchRequest<HoaDonDB>(entityName: "HoaDon");
    }

    @NSManaged public var dathanhtoan: Bool
    @NSManaged public var mahoadon: String?
    @NSManaged public var ghichu: String?
    @NSManaged public var maphong: String?

}
