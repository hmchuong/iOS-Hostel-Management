//
//  ChuNhaDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension ChuNhaDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChuNhaDB> {
        return NSFetchRequest<ChuNhaDB>(entityName: "ChuNha");
    }

    @NSManaged public var email: String?
    @NSManaged public var hoten: String?
    @NSManaged public var matkhau: String?
    @NSManaged public var sodienthoai: String?
    @NSManaged public var tendangnhap: String?
    @NSManaged public var nhatro: NSSet?

}

// MARK: Generated accessors for nhatro
extension ChuNhaDB {

    @objc(addNhatroObject:)
    @NSManaged public func addToNhatro(_ value: NhaTroDB)

    @objc(removeNhatroObject:)
    @NSManaged public func removeFromNhatro(_ value: NhaTroDB)

    @objc(addNhatro:)
    @NSManaged public func addToNhatro(_ values: NSSet)

    @objc(removeNhatro:)
    @NSManaged public func removeFromNhatro(_ values: NSSet)

}
