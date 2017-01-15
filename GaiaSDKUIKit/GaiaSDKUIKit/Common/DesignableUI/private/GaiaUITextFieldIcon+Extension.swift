//
//  GaiaUITextFieldIconExtension.swift
//  GaiaSDKUIKit
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

// MARK: - Icon methods
extension GaiaUITextFieldIcon{
    /// Scale icon, based on **iconScale** and **the height of frame**
    func scaleIcon(){
        let textFieldHeight = y_end - y_start;
        
        //Scale icon to fit textfield
        if iconView.frame.size.height > iconScale * textFieldHeight{
            let previousHeight = iconView.frame.size.height
            iconView.frame.size.height = iconScale * textFieldHeight
            iconView.frame.size.width *= (iconView.frame.size.height / previousHeight)
        }
    }
    
    ///Set up position of the icon
    func setUpIconSubView(){
        //Set up icon view size
        iconView.frame.size.height = (icon?.size.height)!
        iconView.frame.size.width = (icon?.size.width)!
        iconView.contentMode = UIViewContentMode.scaleAspectFit
        scaleIcon()
        //Set the icon y-axis value to the middle of the text field
        iconView.frame.origin.y = self.frame.height/2 - iconView.frame.height/2
        
        //Set the icon x-axis value and width, depends on the alignment
        if iconAlignment == AlignmentString.left.rawValue{
            iconView.frame.size.width += leftPadding
            iconView.frame.origin.x = leftPadding + borderWidth
        }else{
            iconView.frame.size.width += rightPadding
            iconView.frame.origin.x = self.frame.width - iconView.frame.width - borderWidth
        }
    }
}
