//
//  GaiaUIButton2TitleExtension.swift
//  GaiaSDKUIKit
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

extension GaiaUIButton2Title {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel!.sizeToFit()
        self.subTitleLabel.sizeToFit()
        self.title1AndTitle2AlignTogether()
        if checkTitle1 == 1 {
            self.title1Align()
            checkTitle1 = 0
        }
        if checkTitle2 == 1 {
            self.title2Align()
            checkTitle2 = 0
        }
    }
}

//MARK: - Methods
extension GaiaUIButton2Title {
    /// Align sub title
    public func title2Align(){
        
        switch (titleLabel, subTitleLabel, titleAlignment, title2Alignment) {
        case let (_, otherLabel, _,textAlignTitle2)
            where textAlignTitle2 == AlignmentString.right.rawValue:
            // Right alignment
            otherLabel.textAlignment = .right
            
        case let (_, otherLabel, _,textAlignTitle2)
            where textAlignTitle2 == AlignmentString.left.rawValue:
            // Left alignment
            otherLabel.textAlignment = .left
            
        default:
            // Center alignment
            subTitleLabel?.textAlignment = .center
        }
    }
    
    
    /// Align main title
    public func title1Align(){
        
        switch (titleLabel, subTitleLabel, titleAlignment, title1Alignment) {
        case let (titleLabel?, _, _,textAlignTitle1)
            where textAlignTitle1 == AlignmentString.right.rawValue:
            // Right alignment
            titleLabel.textAlignment = .right
            
        case let (titleLabel?, _, _,textAlignTitle1)
            where textAlignTitle1 == AlignmentString.left.rawValue:
            // Left alignment
            titleLabel.textAlignment = .left
            
        default:
            // Center alignment
            titleLabel?.textAlignment = .center
            
        }
    }
    
    /// Align main and sub title together in the button
    public func title1AndTitle2AlignTogether(){
        switch (titleLabel, subTitleLabel, titleAlignment, title1Alignment) {
        case let (titleLabel?, otherLabel?, textAlign?, _)
            // Horizontal style
            where textAlign == AlignmentString.horizontal.rawValue:
            
            //Scale subTitle
            if otherLabel.frame.size.width >= title2Scale * self.frame.width{
                otherLabel.frame.size.width = title2Scale * self.frame.width
                otherLabel.font = UIFont.systemFont(ofSize: title2Scale * self.frame.height)
            }
            
            //Set up origin-y of sub title and main title
            otherLabel.frame.origin.y = bounds.midY - otherLabel.frame.height / 2 + imageEdgeInsets.left
            titleLabel.frame.origin.y = bounds.midY - (titleLabel.frame.height) / 2 + titleEdgeInsets.right
            
            //Size = total width of two titles
            let size = (titleLabel.frame.width) + titleEdgeInsets.right + imageEdgeInsets.left + otherLabel.frame.width
            
            //Set up origin-x of sub title and main title
            titleLabel.frame.origin.x = bounds.midX - size/2 + itemsXPos
            otherLabel.frame.origin.x = (titleLabel.frame.origin.x) + (titleLabel.frame.width) + titleEdgeInsets.right + paddingBetweenTitle
            otherLabel.frame.origin.x += title2Position
            titleLabel.frame.origin.x += title2Position
            
            
        default:
            //Vertical style
            
            //Scale subtitle
            if subTitleLabel.frame.size.height >= title2Scale * self.frame.height{
                subTitleLabel.frame.size.height = title2Scale * self.frame.height
                
                //Change font size to fit height
                _ = title2Scale * self.frame.height
                subTitleLabel.font = UIFont.systemFont(ofSize: title2Scale * self.frame.height)
            }
            
            //Scale width of main title to fit the button
            titleLabel?.frame.origin.x = 5
            titleLabel?.frame.size.width = bounds.width - 10
            
            //Scale width of sub title to fit the button
            subTitleLabel.frame.origin.x = 5
            subTitleLabel.frame.size.width = bounds.width - 10
            
            // size = total height of 2 titles
            let size = (titleLabel?.frame.height)! + titleEdgeInsets.top + titleEdgeInsets.bottom + subTitleLabel.frame.height + imageEdgeInsets.top + imageEdgeInsets.bottom
            
            //Set up origin-y of main and sub title
            titleLabel?.frame.origin.y = bounds.midY - size/2 + itemsYPos
            subTitleLabel.frame.origin.y = (titleLabel?.frame.origin.y)! + (titleLabel?.frame.height)! + imageEdgeInsets.top + titleEdgeInsets.bottom + titleEdgeInsets.top
            titleLabel?.frame.origin.y += title2Position
            subTitleLabel.frame.origin.y += title2Position
        }
    }
    
    /// Set content of sub title
    ///
    /// - Parameter titleValue: string of sub title
    public func setTitleOtherLable(titleValue: String){
        self.subTitleLabel.text = titleValue
    }
}
