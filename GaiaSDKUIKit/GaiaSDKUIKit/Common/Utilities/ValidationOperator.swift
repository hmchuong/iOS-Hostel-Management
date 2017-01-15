//
//  ValidationOperator.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/9/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// AND operator for 2 GaiaUITextFieldValidation
///
/// - Parameters:
///   - left: left operand
///   - right: right operand
/// - Returns: **true** if left and right are valid, otherwise return **false**
public func && (left: GaiaUITextFieldValidation, right: GaiaUITextFieldValidation) -> Bool{
    return left.isValidContent && right.isValidContent
}

/// AND operator for GaiaUITextFieldValidation and bool
///
/// - Parameters:
///   - left: GaiaUITextFieldValidation
///   - right: Bool
/// - Returns: value of (isValidContent && right)
public func && (left: GaiaUITextFieldValidation, right: Bool) -> Bool{
    return left.isValidContent && right
}

/// AND operator for Bool and GaiaUITextFieldValidation
///
/// - Parameters:
///   - left: Bool
///   - right: GaiaUITextFieldValidation
/// - Returns: value of (left && isValidContent)
public func && (left: Bool, right: GaiaUITextFieldValidation) -> Bool{
    return left && right.isValidContent
}

/// OR operator for 2 GaiaUITextFieldValidation
///
/// - Parameters:
///   - left: left operand
///   - right: right operand
/// - Returns: **true** if left or right is valid, otherwise return **false**
public func || (left: GaiaUITextFieldValidation, right: GaiaUITextFieldValidation) -> Bool{
    return left.isValidContent || right.isValidContent
}

/// OR operator for GaiaUITextFieldValidation and bool
///
/// - Parameters:
///   - left: GaiaUITextFieldValidation
///   - right: Bool
/// - Returns: value of (isValidContent || right)
public func || (left: GaiaUITextFieldValidation, right: Bool) -> Bool{
    return left.isValidContent || right
}

/// OR operator for Bool and GaiaUITextFieldValidation
///
/// - Parameters:
///   - left: Bool
///   - right: GaiaUITextFieldValidation
/// - Returns: value of (left|| isValidContent)
public func || (left: Bool, right: GaiaUITextFieldValidation) -> Bool{
    return left || right.isValidContent
}
