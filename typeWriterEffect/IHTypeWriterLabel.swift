//
//  IHTypeWriterLabel.swift
//  typeWriterEffect
//
//  Created by Md Ibrahim Hassan on 14/04/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

@IBDesignable class IHTypeWriterLabel: UILabel {

    var animationTime : Double!
    
    @IBInspectable var animationDuration: Double = 1.0 {
        didSet {
            animationTime = animationDuration
            setUp()
        }
    }
    
    fileprivate var notUsingAutoLayout : Bool = false
    
    override init(frame: CGRect) {
        notUsingAutoLayout = true
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (notUsingAutoLayout) {
            if (self.preferredMaxLayoutWidth != self.bounds.width) {
                self.preferredMaxLayoutWidth = self.bounds.size.width
            }
        }
    }
    
    private func setUp() {
        if (!notUsingAutoLayout){
            self.preferredMaxLayoutWidth = self.bounds.width
        }
        let operation1 : BlockOperation = BlockOperation (block: {
            self.animateLabelWithDuration()
        })
        operationQueue.addOperation(operation1)
    }

    var operationQueue = OperationQueue()

    fileprivate func animateLabelWithDuration()
    {
         DispatchQueue.main.sync {
            let newText = self.text
            self.text = ""
            let characterDelay: TimeInterval = self.animationTime / Double((newText?.characters.count)!)
            for (i,character) in (newText?.characters)!.enumerated() {
                
            DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(i)) {
                    self.text?.append(character)
                if (!self.notUsingAutoLayout) {
                    self.sizeToFit()
                    self.setNeedsUpdateConstraints()
                }
                else {
                    self.frame.size.height = (self.text?.height(withConstrainedWidth: self.bounds.width, font: self.font))!
                }
             }
            }
        if (self.attributedText != nil)
        {
            let combination = NSMutableAttributedString.init(attributedString: self.attributedText!)
            let combination1 = NSMutableAttributedString.init()
            self.attributedText = NSMutableAttributedString.init(string: "")
            let characterDelay : TimeInterval = self.animationTime / Double(combination.length)
            for (index, character) in (combination.string.characters).enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                let rangePointer : NSRangePointer = NSRangePointer.allocate(capacity: 1)
                let attributes = combination.attributes(at: index, effectiveRange: rangePointer)
                let tempAttrString = NSAttributedString.init(string: String(character), attributes: attributes)
                combination1.append(tempAttrString)
                self.attributedText = combination1
                    
                    if (!self.notUsingAutoLayout) {
                        self.sizeToFit()
                        self.setNeedsUpdateConstraints()
                    }
                    else {
                        self.frame.size.height = (self.text?.height(withConstrainedWidth: self.bounds.width, font: self.font))!
                        }
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
}
