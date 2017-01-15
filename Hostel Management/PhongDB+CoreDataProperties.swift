//
//  PhongDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
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
    @NSManaged public var hinhanhphong: NSSet?
    @NSManaged public var hoadon: NSSet?
    @NSManaged public var hosonhankhau: NSSet?
    @NSManaged public var nguoithue: NguoiThueTroDB?
    @NSManaged public var nhatro: NhaTroDB?
    @NSManaged public var tinhtrang: TinhTrangDB?

}

// MARK: Generated accessors for hinhanhphong
extension PhongDB {

    @objc(addHinhanhphongObject:)
    @NSManaged public func addToHinhanhphong(_ value: HinhAnhPhongDB)

    @objc(removeHinhanhphongObject:)
    @NSManaged public func removeFromHinhanhphong(_ value: HinhAnhPhongDB)

    @objc(addHinhanhphong:)
    @NSManaged public func addToHinhanhphong(_ values: NSSet)

    @objc(removeHinhanhphong:)
    @NSManaged public func removeFromHinhanhphong(_ values: NSSet)

}

// MARK: Generated accessors for hoadon
extension PhongDB {

    @objc(addHoadonObject:)
    @NSManaged public func addToHoadon(_ value: HoaDonDB)

    @objc(removeHoadonObject:)
    @NSManaged public func removeFromHoadon(_ value: HoaDonDB)

    @objc(addHoadon:)
    @NSManaged public func addToHoadon(_ values: NSSet)

    @objc(removeHoadon:)
    @NSManaged public func removeFromHoadon(_ values: NSSet)

}

// MARK: Generated accessors for hosonhankhau
extension PhongDB {

    @objc(addHosonhankhauObject:)
    @NSManaged public func addToHosonhankhau(_ value: HoSoNhanKhauDB)

    @objc(removeHosonhankhauObject:)
    @NSManaged public func removeFromHosonhankhau(_ value: HoSoNhanKhauDB)

    @objc(addHosonhankhau:)
    @NSManaged public func addToHosonhankhau(_ values: NSSet)

    @objc(removeHosonhankhau:)
    @NSManaged public func removeFromHosonhankhau(_ values: NSSet)

}
