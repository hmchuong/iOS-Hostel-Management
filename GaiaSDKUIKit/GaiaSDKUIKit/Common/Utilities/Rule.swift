//
//  Rule.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/5/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// Rule to check content in the text field or text view
public protocol Rule{
    func validate(value: String) -> Bool
    func errorMessage() -> String 
}
