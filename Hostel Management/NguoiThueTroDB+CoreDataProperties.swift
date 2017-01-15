//
//  NguoiThueTroDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension NguoiThueTroDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NguoiThueTroDB> {
        return NSFetchRequest<NguoiThueTroDB>(entityName: "NguoiThueTro");
    }

    @NSManaged public var id: String?
    @NSManaged public var matoken: String?
    @NSManaged public var phong: PhongDB?

}
