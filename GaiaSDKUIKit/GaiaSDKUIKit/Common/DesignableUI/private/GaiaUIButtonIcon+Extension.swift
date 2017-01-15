//
//  GaiaUIButtonIcon.swift
//  GaiaSDKUIKit
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

// MARK: - Lifecycle
extension GaiaUIButtonIcon {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public var intrinsicContentSize : CGSize {
        if let imageView = imageView,
            let titleLabel = titleLabel,
            let textAlign = textAlignment,
            textAlign == AlignmentString.top.rawValue || textAlign == AlignmentString.bottom.rawValue {
            titleLabel.sizeToFit()
            imageView.sizeToFit()
            var height = titleLabel.frame.height + imageView.frame.height
                + titleEdgeInsets.top + titleEdgeInsets.bottom
                + titleEdgeInsets.top + titleEdgeInsets.bottom
                + imageEdgeInsets.top + imageEdgeInsets.bottom
            
            height += 10
            return CGSize(
                width: titleLabel.frame.width + imageView.frame.width,
                height: height
            )
        }
        
        return super.intrinsicContentSize
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setImageTitlePosition()
    }
    
}

// MARK: - Methods
extension GaiaUIButtonIcon {
    /// Type for scale image
    ///
    /// - height: scale in height
    /// - width: scale in width
    private enum sizeType{
        case height, width
    }
    
    /// Scale suitable dimension of imageView
    ///
    /// - Parameters:
    ///   - imageView: imageView you want to scale
    ///   - type: dimension you want to scale
    private func scaleImageView(_ imageView: UIImageView, for type: sizeType){
        switch type {
        case .height:
            if imageView.frame.size.height > iconScale * self.frame.height{
                imageView.frame.size.height = iconScale * self.frame.height
            }
        case .width:
            if imageView.frame.size.width > iconScale * self.frame.width{
                imageView.frame.size.width = iconScale * self.frame.width
            }
        }
    }
    
    /// Place title on top of image
    ///
    /// - Parameters:
    ///   - title: titleLabel
    ///   - image: imageView
    private func alignTop(title: UILabel, image: UIImageView){
        //Calculate x-origin of title and image
        title.frame.origin.x = bounds.midX - title.frame.width / 2
        image.frame.origin.x = bounds.midX - image.frame.width / 2
        
        //Total height of image and title
        let size = title.frame.height + titleEdgeInsets.top + titleEdgeInsets.bottom + image.frame.height + imageEdgeInsets.top + imageEdgeInsets.bottom
        
        //Calculate y-origin of title
        title.frame.origin.y = bounds.midY - size/2 + itemsYPos
        
        //Calculate y-origin of image
        image.frame.origin.y = title.frame.origin.y + title.frame.height + imageEdgeInsets.top + titleEdgeInsets.bottom + titleEdgeInsets.top
        image.frame.origin.y += iconPosition
    }
    
    /// Place title below image
    ///
    /// - Parameters:
    ///   - title: titleLabel
    ///   - image: imageView
    private func alignBottom(title: UILabel, image: UIImageView){
        //Calculate x-origin of image and title
        image.frame.origin.x = bounds.midX - image.frame.width / 2
        title.frame.origin.x = bounds.midX - title.frame.width / 2
        
        //Total height of image and title
        let size = title.frame.height + titleEdgeInsets.top + titleEdgeInsets.bottom + image.frame.height + imageEdgeInsets.top + imageEdgeInsets.bottom
        
        //Calculate y-origin of image
        image.frame.origin.y = bounds.midY - size/2 + itemsYPos
        image.frame.origin.y += iconPosition
        
        //Calculate y-origin of title
        title.frame.origin.y = image.frame.origin.y + image.frame.height + imageEdgeInsets.top + imageEdgeInsets.bottom + titleEdgeInsets.top
        
    }
    
    /// Place title on the left of image
    ///
    /// - Parameters:
    ///   - title: titleLable
    ///   - image: imageView
    private func alignLeft(title: UILabel, image: UIImageView){
        //Set the height of title label is equal to image
        title.frame.size.height = image.frame.size.height
        
        //Calculate the y-origin of image and title
        image.frame.origin.y = bounds.midY - image.frame.height / 2 + imageEdgeInsets.left
        title.frame.origin.y = bounds.midY - title.frame.height / 2 + titleEdgeInsets.right
        
        //Total width of image and title
        let size = title.frame.width + titleEdgeInsets.right + imageEdgeInsets.left + image.frame.width
        
        //Calculate x-origin of title
        title.frame.origin.x = bounds.midX - size/2 + itemsXPos
        
        //Caculate x-origin of image
        image.frame.origin.x = title.frame.origin.x + title.frame.width + titleEdgeInsets.right
        image.frame.origin.x += iconPosition
    }
    
    /// Place title on the right of image
    ///
    /// - Parameters:
    ///   - title: titleLable
    ///   - image: imageView
    private func alignRight(title: UILabel, image: UIImageView){
        //Set the height of title label is equal to image
        title.frame.size.height = imageView!.frame.size.height
        
        //Calculate the y-origin of image and title
        image.frame.origin.y = bounds.midY - image.frame.height / 2 + imageEdgeInsets.left
        title.frame.origin.y = bounds.midY - title.frame.height / 2 + titleEdgeInsets.right
        
        //Total width of image and title
        let size = title.frame.width + titleEdgeInsets.left + imageEdgeInsets.right + image.frame.width
        
        //Calculate x-origin of image
        image.frame.origin.x = self.bounds.midX - size/2 + itemsXPos
        image.frame.origin.x += iconPosition
        
        //Calculate x-origin of title
        title.frame.origin.x = image.frame.origin.x + image.frame.width + titleEdgeInsets.left
    }
    
    /// Set up position for icon and title
    /// - Scale icon to fit text field
    /// - Calculate origin of title and image
    func setImageTitlePosition(){
        //Ensure image and title fit view
        self.imageView?.image = self.currentImage
        self.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        self.titleLabel!.sizeToFit() //Set height of label to center label and icon
        if self.currentImage != nil{
            imageView!.frame.size.width = (imageView?.image?.size.width)!
        }
        
        //Only use for demo app, to hide image or title
        if titleEnable == false{
            titleLabel!.frame.size.width = CGFloat(0)
        }
        
        if imageEnable == false{
            imageView!.frame.size.width = CGFloat(0)
        }
        
        // Align image and title
        switch (titleLabel, imageView, textAlignment) {
        case let (titleLabel?, imageView?, textAlign?)
            where textAlign == AlignmentString.bottom.rawValue:
            
            //Scale image
            scaleImageView(imageView, for: .height)
            //Align title and image
            alignBottom(title: titleLabel, image: imageView)
            
        case let (titleLabel?, imageView?, textAlign?)
            where textAlign == AlignmentString.top.rawValue:
            
            //Scale image
            scaleImageView(imageView, for: .height)
            //Align title and image
            alignTop(title: titleLabel, image: imageView)
            
        case let (titleLabel?, imageView?, textAlign?)
            where textAlign == AlignmentString.left.rawValue:
            
            //Scale image
            scaleImageView(imageView, for: .width)
            //Align title and image
            alignLeft(title: titleLabel, image: imageView)
            
        case let (titleLabel?, imageView?, textAlign?)
            where textAlign == AlignmentString.right.rawValue:
            
            //Scale image
            scaleImageView(imageView, for: .width)
            //Align title and image
            alignRight(title: titleLabel, image: imageView)
            
        default:
            break
        }
    }
}
