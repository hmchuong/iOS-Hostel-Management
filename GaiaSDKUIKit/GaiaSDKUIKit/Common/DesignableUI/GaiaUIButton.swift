//
//  GaiaUIButton.swift
//  GaiaSDKUIKit
//
//
//  Created by Chuong Huynh on 18/11/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation
///Base customize UIButton:
/// - borders 
/// - corners
/// - background
@IBDesignable
public class GaiaUIButton: UIButton, GaiaBaseUIControl {
    //MARK: - Properties
    //MARK: - - Border
    /// Hex-color of border
    @IBInspectable public var borderColor: String = ColorString.clear.rawValue {
        didSet{
            self.layer.borderColor = borderColor.colorWithHexString().cgColor
            setNeedsLayout()
        }
    }
    
    /// Hex-color of border in highlighted state
    @IBInspectable public var boHighColor: String = ColorString.clear.rawValue {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// The width of border
    @IBInspectable public var borderWidth: CGFloat = DefaultCGFloat.borderWidth {
        didSet{
            self.layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }
    
    /// The radius of corner
    @IBInspectable public var cornerRadius: CGFloat = DefaultCGFloat.cornerRadius {
        didSet{
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            setNeedsLayout()
        }
    }
    
    //MARK: - - Solid background
    /// Hex-color of background
    @IBInspectable public var bgColor: String = ColorString.clear.rawValue {
        didSet{
            setNeedsLayout()
        }
    }
    
    /// Hex-color of background in highlighted state
    @IBInspectable public var bgHighColor: String = ColorString.clear.rawValue {
        didSet {
            setNeedsLayout()
        }
    }
    
    //MARK: -  - Gradient background
    /// Enable gradient for background
    /// - **true**: use gradient for the background
    /// - **false**: use **bgColor** instead
    @IBInspectable public var gradientBg: Bool = false{
        didSet{
            setNeedsLayout()
        }
    }
    
    /// Starting color (hex) of gradient background
    @IBInspectable public var startColor: String? = nil{
        didSet{
            setNeedsLayout()
        }
    }
    
    /// Ending color (hex) of gradient background
    @IBInspectable public var endColor: String? = nil{
        didSet{
            setNeedsLayout()
        }
    }
    
    /// Choose color transformation type of gradient background
    /// - **true**: the transformation of two color is horizontal dimension
    /// - **false**: the transformation of two color is vertical dimension
    @IBInspectable public var isHorizontal: Bool = false{
        didSet{
            setNeedsLayout()
        }
    }
    
    //MARK: - - Elements    
    /// The vertical padding of block (items inside)
    @IBInspectable public var itemsYPos: CGFloat = DefaultCGFloat.padding {
        didSet{
            setNeedsLayout()
        }
    }
    
    /// The horizontal padding of block (items inside)
    @IBInspectable public var itemsXPos: CGFloat = DefaultCGFloat.padding {
        didSet{
            setNeedsLayout()
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        clearsContextBeforeDrawing = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setBorder()
        setBackground()
    }
    
    let backgroundImage = UIImageView()
}
