//
//  NhaTroDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension NhaTroDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NhaTroDB> {
        return NSFetchRequest<NhaTroDB>(entityName: "NhaTro");
    }

    @NSManaged public var diachi: String?
    @NSManaged public var ten: String?
    @NSManaged public var manhatro: String?
    @NSManaged public var chunha: String?

}
