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
    
    fileprivate var usingRect : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        usingRect = true
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    var operationQueue = OperationQueue()
    
    private func setUp() {
        self.preferredMaxLayoutWidth = self.bounds.width
        let operation1 : BlockOperation = BlockOperation (block: {
            self.animateLabelWithDuration()
        })
        operationQueue.addOperation(operation1)
    }
    
    fileprivate func animateLabelWithDuration()
    {
        DispatchQueue.main.sync {
//        let range = NSRange()
//        self.attributedText?.attributes(at: 0, effectiveRange: range as? NSRangePointer)
//        var isAttributed: Bool = self.text?.count == range.length
            if (!self.isAttributed) {
                let newText = self.text
                self.text = ""
                let characterDelay: TimeInterval = self.animationDuration / Double((newText?.characters.count)!)
                for (i,character) in (newText?.characters)!.enumerated() {

                    DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(i)) {
                        self.text?.append(character)
                        if (!self.usingRect){
                            self.sizeToFit()
                            self.setNeedsUpdateConstraints()
                        }
                        else  {
                            self.frame.size.height = (self.text?.height(withConstrainedWidth: self.bounds.width, font: self.font))!
                        }
                    }
                }
            }
            else if (self.isAttributed){
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
                            if (!self.usingRect) {
                                self.sizeToFit()
                                self.setNeedsUpdateConstraints()
                            }
                            else {
                                self.frame.size.height = (self.attributedText?.height(
                                    withConstrainedWidth: self.frame.size.width))!
                            }
                        }
                    }
                }
            }
        }
//    }
    
}

extension UILabel {
    var isAttributed: Bool {
        guard let attributedText = attributedText else { return false }
        let range = NSMakeRange(0, attributedText.length)
        var allAttributes = [Dictionary<String, Any>]()
        attributedText.enumerateAttributes(in: range, options: []) { attributes, _, _ in
            allAttributes.append(attributes)
        }
        return allAttributes.count > 1
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
