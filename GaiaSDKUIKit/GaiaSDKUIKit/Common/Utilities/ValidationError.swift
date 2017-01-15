//
//  ValidationError.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/8/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation
import UIKit

/// Validation errors return for users
public class ValidationError: NSObject {
    // MARK: - Properties
    public let errorMessage: String             // Message when error
    public let textField: UITextField           // UITextField'd receive the message
    
    // MARK: - Methods
    /// Constructor
    ///
    /// - Parameters:
    ///   - textField: text field to validate
    ///   - error: message is show when error
    public init(textField: UITextField, error: String){
        self.textField = textField
        self.errorMessage = error
    }
    
}
