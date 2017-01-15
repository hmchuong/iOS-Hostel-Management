//
//  GaiaDesignableUIButton2Title.swift
//  GaiaSDKUIKit
//
//  Created by Hien Tran on 10/29/16.
//  Edited by Chuong Huynh on 18/11/16
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// Gaia UIButton with 2 title.
/// These titles can align vertical or horizontal
@IBDesignable
public class GaiaUIButton2Title: GaiaUIButton {
    
    //MARK: - Properties
    open var subTitleLabel: UILabel!
    open let paddingBetweenTitle:CGFloat = 6.0
    var checkTitle1 = 0
    var checkTitle2 = 0
    
    // - For overall
    /// Align two titles vertically or horizontally
    ///
    /// Value:
    /// - **vertical**
    /// - **horizontal**
    @IBInspectable public var titleAlignment: String? {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// Align main title:
    /// - left
    /// - right
    /// - center
    @IBInspectable public var title1Alignment: String? {
        didSet {
            checkTitle1 = 1
            setNeedsLayout()
        }
    }
    
    /// Content of sub title
    @IBInspectable var title2: String = String.empty {
        didSet {
            if subTitleLabel != nil {
                self.subTitleLabel.text = title2
            }
            setNeedsLayout()
        }
    }
    
    /// Align sub title:
    /// - left
    /// - right
    /// - center
    @IBInspectable public var title2Alignment: String? {
        didSet {
            checkTitle2 = 1
            setNeedsLayout()
        }
    }
    
    /// Position of sub title
    /// 
    /// This attribute can have negative value: *the value is more positive, the sub title moves more to the right side*
    @IBInspectable public var title2Position: CGFloat = DefaultCGFloat.position {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// Scale of sub title
    ///
    /// Value: [0..1]
    @IBInspectable public var title2Scale: CGFloat = DefaultCGFloat.scale{
        didSet{
            if title2Scale > 1{
                title2Scale = 1
            }
            setNeedsLayout()
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        //Calculate the frame of sub title
        var frameTitleLable =  self.titleLabel?.frame
        frameTitleLable?.origin.x = (self.titleLabel?.frame.origin.x)! + (self.titleLabel?.frame.size.width)! + 10
        
        //Init sub title's properties
        self.subTitleLabel = UILabel()
        self.subTitleLabel.textAlignment = .center
        self.subTitleLabel.frame = frameTitleLable!
        self.subTitleLabel.text = self.title2
        
        //Add subtitle to button
        self.addSubview(self.subTitleLabel)
        
        self.imageView?.image = nil
        
        self.titleLabel!.sizeToFit()
        self.subTitleLabel.sizeToFit()
    }

}


