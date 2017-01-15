//
//  GaiaDesignableUITextField.swift
//  Holler
//
//  Created by Phong Le on 8/12/15.
//  Edited by Chuong Huynh on 27/10/16
//  Copyright © 2015 Rainmaker-labs. All rights reserved.
//

import UIKit

///Base customize UITextField: 
/// * borders
/// * corners
/// * background
@IBDesignable
public class GaiaUITextField: UITextField, GaiaBaseUIControl{
    // MARK: PROPERTIES
    /// The left padding (margin) of text in text field
    @IBInspectable public var leftPaddingT: CGFloat = DefaultCGFloat.padding
    
    /// The right padding (margin) of text in text field
    @IBInspectable public var rightPaddingT: CGFloat = DefaultCGFloat.padding
    
    // - Borders
    
    /// Show top border
    /// * **true**: show top border
    /// * **false**: hide top border
    @IBInspectable public var topBorder: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Show bottom border
    /// * **true**: show bottom border
    /// * **false**: hide bottom border
    @IBInspectable public var bottomBorder: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Show left border
    /// * **true**: show left border
    /// * **false**: hide left border
    @IBInspectable public var leftBorder: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Show right border
    /// * **true**: show right border
    /// * **false**: hide right border
    @IBInspectable public var rightBorder: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Border color in hex string
    /// * Note: 
    /// *'clear'* stands for **UIColor.clear**
    @IBInspectable public var borderColor: String = ColorString.clear.rawValue {
        didSet{
            borderColorUI = borderColor.colorWithHexString()
            self.setNeedsDisplay()
        }
    }
    
    /// The width of border
    @IBInspectable public var borderWidth: CGFloat = DefaultCGFloat.borderWidth {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    // - Corners
    /// Show top left corner
    /// - **true**: show top left corner
    /// - **false**: hide top left corner
    @IBInspectable public var topleftCorner: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Show top right corner
    /// - **true**: show top right corner
    /// - **false**: hide top right corner
    @IBInspectable public var toprightCrn: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Show bottom left corner
    /// - **true**: show bottom left corner
    /// - **false**: hide bottom left corner
    @IBInspectable public var bottomleftCrn: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Show bottom right corner
    /// - **true**: show bottom right corner
    /// - **false**: hide bottom right corner
    @IBInspectable public var btmrightCrn: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Radius of the corner
    @IBInspectable public var cornerRadius: CGFloat = DefaultCGFloat.cornerRadius{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Transparent of background color.
    ///
    /// Value range: [0..1]
    @IBInspectable public var bgTransparent: CGFloat = DefaultCGFloat.transparent{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// Color of background in hex string
    ///
    /// **Example**: '#000000' -> UIColor.black
    @IBInspectable public var bgColor: String = ColorString.clear.rawValue {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
         
    // - Border color
    /// UIColor of border
    var borderColorUI = UIColor.clear
    
    
    // - Background and bound layer
    /// Drawing layer contains:
    /// - borders
    /// - corners
    /// - background
    var drawingLayer = DrawingLayer()

    
    // - Y position range
    /// Minimum y-axis value of text field.
    var y_start = CGFloat(0)
    
    /// Maximum y-axis value of text field
    var y_end = CGFloat(0)
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        //Set up end y-axis value is height of text field
        y_end = frame.height
    }
    
    override public func draw(_ rect: CGRect) {
        //Draw border, corner and background to text field
        self.setupBorder()
        self.setupCorner()
        self.setBackgroundTextField(borderWidth)
    }
    
}



