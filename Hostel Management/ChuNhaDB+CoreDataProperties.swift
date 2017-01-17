//
//  ChuNhaDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
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

}
