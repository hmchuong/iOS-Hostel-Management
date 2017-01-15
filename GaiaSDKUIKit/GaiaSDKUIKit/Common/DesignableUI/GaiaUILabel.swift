//
//  GaiaUILabel1.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/12/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

@IBDesignable
public class GaiaUILabel: UILabel, GaiaBaseUIControl{
    // - MARK: - Properties
    
    // - Insets
    @IBInspectable public var topInset: CGFloat = DefaultCGFloat.inset
    @IBInspectable public var bottomInset: CGFloat = DefaultCGFloat.inset
    @IBInspectable public var rightInset: CGFloat = DefaultCGFloat.inset
    @IBInspectable public var leftInset: CGFloat = DefaultCGFloat.inset
    
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
    /**
     Degree value for rotating label
 
     To anti-alias edges when rotating, you should set **YES** to
     **Renders with edge antialiasing** in **Info.plist** of your application
     
     ![Render with edge antiliasing](img/Renders_with_edge_antialiasing.png)
     */
    @IBInspectable public var rotation: CGFloat = DefaultCGFloat.rotationDegree {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// HTML or normal presentation of text
    /// 
    /// - **true**: HTML presentation
    /// - **false**: normal text
    @IBInspectable public var HTML: Bool = false{
        didSet{
            self.html()
        }
    }
    
    override public var text: String?{
        didSet{
            if HTML{
                self.html()
            }else{
                super.text = text
            }
        }
    }


    /// URL in UILabel
    var urls: [String:String] = [:]


    // - Border color
    /// UIColor of border
    var borderColorUI = UIColor.clear
    
    
    // - Background and bound layer
    /// Drawing layer contains:
    /// - borders
    /// - corners
    /// - background
    var drawingLayer = DrawingLayer()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
}

