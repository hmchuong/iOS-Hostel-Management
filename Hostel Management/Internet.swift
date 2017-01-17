//
//  Internet.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/17/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class Internet: DichVuSinhHoat{
    // MARK: - Properties
    private var gia: Int = 0
    
    // MARK: - Methods
    internal func change(_ gia: Int){
        self.gia = gia
    }
    
    internal func calc()-> Int{
        return self.gia
    }
    
}
