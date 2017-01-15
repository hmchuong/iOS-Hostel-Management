//
//  ValidationRule.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/5/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation
import UIKit

/// This class includes UITextField and list of rules for it
public class ValidationRule{
    // MARK: - Properties
    public var textField: UITextField           // Text field to validate
    public var rules: [Rule] = []               // List of rules, the priority is from left to right
    
    // MARK: - Methods
    /// Constructior
    ///
    /// - Parameters:
    ///   - textField: textfield to validate
    ///   - rules: rules to validate, the priority is from left to right
    public init(textField: UITextField, rules: [Rule]){
        self.textField = textField
        self.rules = rules
    }
    
    
    
    /// Validate text field with list of rules
    ///
    /// - Returns: ValidationError - the first error of text field
    public func validateField() -> ValidationError? {
        return rules.filter{!$0.validate(value: self.textField.text ?? "")}
            .map{rule -> ValidationError in return ValidationError(textField: self.textField, error: rule.errorMessage())}.first
    }
}
