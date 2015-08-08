//
//  UITextView+Extension.swift
//  EmoticonKeyboard
//
//  Created by 张鹏 on 15/8/7.
//  Copyright © 2015年 cabbage. All rights reserved.
//

import UIKit

extension UITextView {
    
    /// textView里面插入一个表情
    ///
    /// :param: emoticon 表情模型
    func insertEmoticon(emoticon:Emoticons) {
        
        if emoticon.removeEmoticon {
            
            deleteBackward()
        }
        
        /// 插入Emoji表情
        if emoticon.emoji != nil {
            replaceRange(selectedTextRange!, withText: emoticon.emoji!)
            
            return
        }
        
        /// 插入png表情
        if emoticon.chs != nil {
            
            let attachment = EmoticonAttachment()
            
            attachment.chs = emoticon.chs
            
            attachment.image = UIImage(contentsOfFile: emoticon.imagePath)
            
            let lineH = font!.lineHeight
            
            attachment.bounds = CGRect(x: 0, y: -3.5, width: lineH, height: lineH)
            
            let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
            
            imageText.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(0, 1))
            
            let attrString = NSMutableAttributedString(attributedString: attributedText)
            
            attrString.replaceCharactersInRange(selectedRange, withAttributedString: imageText)
            
            let range = selectedRange
            
            attributedText = attrString
            
            selectedRange = NSRange(location: range.location + 1, length: 0)
            
            delegate?.textViewDidChange!(self)
        }
  
    }

    
    var emoticonText: String {
        
        let attrString = attributedText
        
        var stringM = String()
        
        attrString.enumerateAttributesInRange(NSMakeRange(0, attrString.length), options: NSAttributedStringEnumerationOptions(rawValue: 0)) { (dict , range , _ ) -> Void in
            
            if let attachment = dict["NSAttachment"] as? EmoticonAttachment {
                
                stringM += attachment.chs!
                
            } else {
                let str = (attrString.string as NSString).substringWithRange(range)
                
                stringM += str
            }
            
        }
        return stringM   
    }
  
}
