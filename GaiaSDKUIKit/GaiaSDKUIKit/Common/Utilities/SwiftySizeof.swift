//
//  SwiftySizeof.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 11/18/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// Calculate size of value (byte)
///
/// - Parameter _: type you want to calculate
/// - Returns: the number of bytes
func sizeof <T> (_ : T.Type) -> Int
{
    return (MemoryLayout<T>.size)
}

/// Calculate size of variable/constant (byte)
///
/// - Parameter _: constant/ variable to calculate
/// - Returns: the number of bytes
func sizeof <T> (_ : T) -> Int
{
    return (MemoryLayout<T>.size)
}

/// Calculate size of array (byte)
///
/// - Parameter value: array to calculate
/// - Returns: the number of bytes
func sizeof <T> (_ value : [T]) -> Int
{
    return (MemoryLayout<T>.size * value.count)
}
