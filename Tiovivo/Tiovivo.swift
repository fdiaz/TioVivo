//
//  Tiovivo.swift
//  Tiovivo
//
//  Created by Francisco Díaz on 10/15/15.
//  Copyright © 2015 Francisco Díaz. All rights reserved.
//

import UIKit

internal struct Tiovivo {
    private let scrollView: UIScrollView
    private var contentView: UIView
    private var imageViews: [UIImageView] = []
    private var contentViewRightMarginConstraint: NSLayoutConstraint?
    
    init(scrollView: UIScrollView, images: [UIImage]) {
        self.scrollView = scrollView
        contentView = UIView(frame: CGRectZero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        let viewsDictionary = ["contentView": contentView, "scrollView": scrollView]
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: .AlignAllLeft, metrics: nil, views: viewsDictionary))
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: .AlignAllLeft, metrics: nil, views: viewsDictionary))
        
        images.forEach { image in
            addImage(image)
        }
    }
    
    mutating func addImage(image: UIImage) {
        let previousImageView = imageViews.last
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .TopMargin, relatedBy: .Equal, toItem: contentView, attribute: .TopMargin, multiplier: 1, constant: 0)
        let leftConstraint: NSLayoutConstraint
        if previousImageView == nil {
            leftConstraint = NSLayoutConstraint(item: imageView, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: 0)
        } else {
            leftConstraint = NSLayoutConstraint(item: imageView, attribute: .Left, relatedBy: .Equal, toItem: imageViews.first!, attribute: .Right, multiplier: 1, constant: 0)
        }
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1, constant: 0)
        contentView.addConstraints([topConstraint, leftConstraint, heightConstraint])
        
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1, constant: 0)
        scrollView.addConstraint(widthConstraint)
        
        imageViews.append(imageView)
        if let constraint = contentViewRightMarginConstraint {
            contentView.removeConstraint(constraint)
        }
        contentViewRightMarginConstraint = NSLayoutConstraint(item: contentView, attribute: .Right, relatedBy: .Equal, toItem: imageView, attribute: .Right, multiplier: 1, constant: 0)
        contentView.addConstraint(contentViewRightMarginConstraint!)
    }
}