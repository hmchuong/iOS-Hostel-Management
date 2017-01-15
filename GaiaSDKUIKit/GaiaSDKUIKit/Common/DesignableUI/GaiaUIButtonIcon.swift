//
//  GaiaDesignableUIButtonIcon.swift
//  Holler
//
//  Created by Phong Le on 21/12/15.
//  Edited by Chuong Huynh on 27/10/16
//  Copyright © 2015 Rainmaker-labs. All rights reserved.
//

import Foundation
import UIKit

/// Gaia UI Button with icon inside.
///
/// We can choose title position of icon: *top, bottom, left, right* of icon.
/// Title and icon are situated in the center of button automatically
@IBDesignable
public class GaiaUIButtonIcon: GaiaUIButton {
    //MARK: PROPERTIES
    
    /// The position of title to icon:
    /// * top
    /// * bottom
    /// * left
    /// * right
    @IBInspectable public var textAlignment: String? = AlignmentString.left.rawValue {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// The scale of the icon, based on:
    /// * height of icon
    /// * width of icon
    @IBInspectable public var iconScale: CGFloat = DefaultCGFloat.scale{
        didSet{
            //Maximum scale is 100%
            if iconScale > 1{
                iconScale = 1
            }
            setNeedsLayout()
        }
    }
    
    /// Icon position (if you don't want is located at center).
    ///
    /// It can receive negative value
    ///
    /// When alignment:
    ///
    /// 1. **Left or right**: the value is more positive, the icon moves more to the right and otherwise
    /// 2. **Top or bottom**: the value is more positive, the icon moves more to the bottom and otherwise
    @IBInspectable public var iconPosition: CGFloat = DefaultCGFloat.position {
        didSet {
            setNeedsLayout()
        }
    }

    ///Enable title (only use for demo app)
    public var titleEnable: Bool = true {
        didSet{
            setNeedsLayout()
        }
    }
    
    ///Enable image (only use for demo app)
    public var imageEnable: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }
    
}

