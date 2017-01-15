//
//  NhaTroDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension NhaTroDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NhaTroDB> {
        return NSFetchRequest<NhaTroDB>(entityName: "NhaTro");
    }

    @NSManaged public var diachi: String?
    @NSManaged public var sophong: Int64
    @NSManaged public var ten: String?
    @NSManaged public var chunha: ChuNhaDB?
    @NSManaged public var phongtro: NSSet?

}

// MARK: Generated accessors for phongtro
extension NhaTroDB {

    @objc(addPhongtroObject:)
    @NSManaged public func addToPhongtro(_ value: PhongDB)

    @objc(removePhongtroObject:)
    @NSManaged public func removeFromPhongtro(_ value: PhongDB)

    @objc(addPhongtro:)
    @NSManaged public func addToPhongtro(_ values: NSSet)

    @objc(removePhongtro:)
    @NSManaged public func removeFromPhongtro(_ values: NSSet)

}
