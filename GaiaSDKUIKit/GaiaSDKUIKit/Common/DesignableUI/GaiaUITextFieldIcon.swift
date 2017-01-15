//
//  GaiaDesignableUITextFieldIcon.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 27/10/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import UIKit

///Gaia customize textfield with icon located inside
@IBDesignable
public class GaiaUITextFieldIcon: GaiaUITextField{
    // - Icon
    /// Show icon
    /// - **true**: show icon
    /// - **false**: hide icon
    @IBInspectable public var showIcon: Bool = false{
        didSet{
            // Show icon
            if showIcon{
                setNeedsDisplay()
            }else{
                // Hide icon
                iconView.removeFromSuperview()
            }
        }
    }
    
    /// Choose icon from resources
    @IBInspectable public var icon: UIImage? = nil{
        didSet{
            iconView.image = icon
            setNeedsDisplay()
        }
    }
    
    /// Icon alignment:
    /// - *'left'*: left alignment
    /// - *'right'*: right alignment
    @IBInspectable public var iconAlignment: String = AlignmentString.left.rawValue{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    /// Left padding (the number of space on the left side) of icon
    @IBInspectable public var leftPadding: CGFloat = DefaultCGFloat.padding{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Right padding (the number of space on the right side) of icon
    @IBInspectable public var rightPadding: CGFloat = DefaultCGFloat.padding{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    /// The scale of icon
    ///
    /// Value range: [0..1]
    @IBInspectable public var iconScale: CGFloat = DefaultCGFloat.scale{
        didSet{
            //Maximum scale: 1
            if iconScale > 1{
                iconScale = 1
            }
            setNeedsDisplay()
        }
    }
    
    /// The ImageView of icon
    public var iconView = UIImageView()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if showIcon && icon != nil {
            setUpIconSubView()
            addSubview(iconView)
            iconView.bringSubview(toFront: self)
        }
    }
}

