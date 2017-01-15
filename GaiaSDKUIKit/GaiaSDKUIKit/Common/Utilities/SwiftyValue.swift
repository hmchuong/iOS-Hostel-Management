//
//  SwiftyValue.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 11/24/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// Define hex-string of color
///
/// - clear: string of UIColor.clear
enum ColorString: String{
    case clear
}

/// Define strings for alignment
///
/// - left: for left alignment
/// - right: for right alignment
/// - top: for top alignment
/// - bottom: for bottom alignment
/// - vertical: for vertical alignment
/// - horizontal: for horizontal alignment
enum AlignmentString: String {
    case left
    case right
    case top
    case bottom
    case vertical
    case horizontal
}

/// Define default value (CGFloat) for IBInstpectable
struct DefaultCGFloat {
    static let padding: CGFloat = 0             // for padding
    static let position : CGFloat = 0           // for position
    static let borderWidth: CGFloat = 0         // for border width
    static let cornerRadius: CGFloat = 0        // for corner radius
    static let transparent: CGFloat = 1         // for color transparent
    static let scale: CGFloat = 0.5             // for item scale
    static let fontSize: CGFloat = 14           // for font size
    static let inset: CGFloat = 0               // for insets
    static let rotationDegree: CGFloat = 0      // for rotation degree
}

/// Define default integer value
struct DefaultInt{
    static let maxLength: Int = 16              // for MaxLengthRule
    static let minLength: Int = 3               // for MinLengthRule
}

