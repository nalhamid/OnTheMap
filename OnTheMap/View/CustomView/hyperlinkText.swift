//
//  hyperlinkText.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 09/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
// source: https://jaymutzafi.com/how-to-hyperlink-part-of-a-text-in-a-uitextview-swift/

import UIKit

extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            
            self.addAttribute(.link, value: linkURL, range: foundRange)
            
            return true
        }
        return false
    }
}

func hyperlinkText(hyperText: String, targetLink: String, textView: UITextView){
    textView.delaysContentTouches = false
    // required for tap to pass through on to superview & for links to work
    textView.isScrollEnabled = false
    textView.isEditable = false
    textView.isUserInteractionEnabled = true
    textView.isSelectable = true
    
    
    let linkedText = NSMutableAttributedString(attributedString: textView.attributedText)
    let hyperlinked = linkedText.setAsLink(textToFind: hyperText, linkURL: targetLink)
    
    if hyperlinked {
        textView.attributedText = NSAttributedString(attributedString: linkedText)
    }
}
