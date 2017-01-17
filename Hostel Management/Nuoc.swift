//
//  Nuoc.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/17/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class Nuoc: DichVuSinhHoat{
    // MARK: - Properties
    private var dinhMuc: [Int] = []
    
    
    // MARK: - Methods
    internal func change(_ dinhmuc: [(Int, Int)]){
        self.dinhMuc = [Int]()
        for (chiso, gia) in dinhmuc {
            for _ in 1...chiso{
                self.dinhMuc.append(gia)
            }
        }
    }
    
    internal func calc(chisocu: Int, chisomoi: Int) -> Int{
        var tongTien = 0
        for i in 1...(chisomoi - chisocu){
            tongTien += self.dinhMuc[i]
        }
        return tongTien
    }    
}
