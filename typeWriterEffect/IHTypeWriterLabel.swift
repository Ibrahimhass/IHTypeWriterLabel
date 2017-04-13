//
//  IHTypeWriterLabel.swift
//  typeWriterEffect
//
//  Created by Md Ibrahim Hassan on 14/04/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

@IBDesignable class IHTypeWriterLabel: UILabel {

    var animationDuration : TimeInterval = 1.0
    @IBInspectable var animationTime: Double = 1.0 {
        didSet {
            animationDuration = animationTime
        }
    }
    override func awakeFromNib() {
        self.animateLabelWithDuration()
    }
    


    func animateLabelWithDuration()
    {
        DispatchQueue.main.async {
            let newText = self.text
            self.text = ""
            let characterDelay: TimeInterval = self.animationDuration / Double((newText?.characters.count)!)
            for (i,character) in (newText?.characters)!.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(i)) {
                    self.text?.append(character)
                    self.frame.size.height = (self.text?.height(withConstrainedWidth: self.frame.width, font: self.font))!
                   
                 }
            }
        if (self.attributedText != nil)
        {
            let combination = NSMutableAttributedString.init(attributedString: self.attributedText!)
            let combination1 = NSMutableAttributedString.init()
            self.attributedText = NSMutableAttributedString.init(string: "")
            let characterDelay : TimeInterval = self.animationDuration / Double(combination.length)
            for (index, character) in (combination.string.characters).enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                let rangePointer : NSRangePointer = NSRangePointer.allocate(capacity: 1)
                let attributes = combination.attributes(at: index, effectiveRange: rangePointer)
                let tempAttrString = NSAttributedString.init(string: String(character), attributes: attributes)
                combination1.append(tempAttrString)
                self.attributedText = combination1
                self.frame.size.height = (self.attributedText?.height(withConstrainedWidth: self.frame.size.width))!
                }
            }
        }
    }
}
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}
