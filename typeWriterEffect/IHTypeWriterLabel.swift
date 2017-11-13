//  MIT License
//
//Copyright (c) 2017 Md Ibrahim Hassan
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import UIKit

@IBDesignable class IHTypeWriterLabel: UILabel {

    var animationDuration : TimeInterval = 1.0
    @IBInspectable var animationTime: Double = 1.0 {
        didSet {
            animationDuration = animationTime
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        self.preferredMaxLayoutWidth = self.bounds.width
        let operation1 : BlockOperation = BlockOperation (block: {
            self.animateLabelWithDuration()
        })
        operationQueue.addOperation(operation1)
    }
    
    func pauseF()
    {
        operationQueue.isSuspended = true
    }
    func playF()
    {
        operationQueue.isSuspended = false
    }

    var operationQueue = OperationQueue()
    
    var pause : Bool = false {
        didSet {
            if (pause == true)
            {
                self.pauseF()
            }
            if (pause == false)
            {
                self.playF()
            }
        }
    }

    fileprivate func animateLabelWithDuration()
    {
         DispatchQueue.main.sync {
            let newText = self.text
            self.text = ""
            let characterDelay: TimeInterval = self.animationDuration / Double((newText?.characters.count)!)
            for (i,character) in (newText?.characters)!.enumerated() {
                
            DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(i)) {
                    self.text?.append(character)
                self.sizeToFit()
                self.setNeedsUpdateConstraints()
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
                    self.sizeToFit()
                    self.setNeedsUpdateConstraints()

//                self.frame.size.height = (self.attributedText?.height(withConstrainedWidth: self.frame.size.width))!
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
