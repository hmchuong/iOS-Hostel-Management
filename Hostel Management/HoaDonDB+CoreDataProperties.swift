//
//  HoaDonDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension HoaDonDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoaDonDB> {
        return NSFetchRequest<HoaDonDB>(entityName: "HoaDon");
    }

    @NSManaged public var dathanhtoan: Bool
    @NSManaged public var mahoadon: Int64
    @NSManaged public var mota: String?
    @NSManaged public var dichvusinhhoat: NSSet?

}

// MARK: Generated accessors for dichvusinhhoat
extension HoaDonDB {

    @objc(addDichvusinhhoatObject:)
    @NSManaged public func addToDichvusinhhoat(_ value: DichVuSinhHoatDB)

    @objc(removeDichvusinhhoatObject:)
    @NSManaged public func removeFromDichvusinhhoat(_ value: DichVuSinhHoatDB)

    @objc(addDichvusinhhoat:)
    @NSManaged public func addToDichvusinhhoat(_ values: NSSet)

    @objc(removeDichvusinhhoat:)
    @NSManaged public func removeFromDichvusinhhoat(_ values: NSSet)

}
