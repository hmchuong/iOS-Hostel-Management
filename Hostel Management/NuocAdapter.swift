//
//  NuocAdapter.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/17/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

class NuocAdapter: Nuoc, DichVuTarget{
    
    // MARK: - Methods
    func changePrice(_ gia: [(Int, Int)]) {
        super.change(gia)
    }
    func calculateMoney(chisocu: Int, chisomoi: Int) -> Int {
        return super.calc(chisocu: chisocu, chisomoi: chisomoi)
    }
}
