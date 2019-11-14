//
//  X_UILabel.swift
//
//  Created by Muji Paracha on 2019-10-26.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

extension UILabel {
    
    var mutableAttributedString: NSMutableAttributedString {
        // Returns a mutable attributed string.
        // Assumes the label has text
        get {
            if let attrText = self.attributedText {
                // Make an existing attributed string mutable, so we can add new attributes to it
                return NSMutableAttributedString(attributedString: attrText)
            } else {
                // Make a new mutable attributed string to add attributes to
                return NSMutableAttributedString(string: self.text!)
            }
        }
    }
    
    func addKerning(_ k: CGFloat) {
        // If there is no text, abort
        // If there is already an attributed string, use that, otherwise make a new one
        // Add kern attribute to the attributed string
        // Assign the label's attributedText property to this attributed string
        
        // emojis will be displayed properly
        
        guard self.text != nil else { return }
        let attrStr = self.mutableAttributedString
        attrStr.addAttribute(NSAttributedString.Key.kern, value: k, range: NSRange(location: 0, length: self.text!.utf16.count)) // added -1 which corrected the issue where it added spacing at the end of the last character as well. Replaced s.characters.count - 1 with attrStr.length - 1, since characters is apparently deprecated.
        // Can't just use -1 to remove last character's padding; it may end with an emoji, and mess it up.
        self.attributedText = attrStr
        
        // Note: See this about kerning with emojis
        // https://stackoverflow.com/questions/49576593/emoji-support-for-nsattributedstring-attributes-kerning-paragraph-style
    }
    
    func addLineSpacing(_ k: CGFloat) {
        guard self.text != nil else { return }
        let attrStr = self.mutableAttributedString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = k
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrStr.length)) // no need for -1 here
        self.attributedText = attrStr
    }
}
