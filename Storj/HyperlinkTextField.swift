//
//  HyperlinkTextField.swift
//  Storj
//
//  Created by Koray Koska on 15/09/2017.
//  Copyright © 2017 Koray Koska. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
class HyperlinkTextField: NSTextField {

    @IBInspectable var href: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()

        setHyperlinkText()
    }

    func setHyperlinkText() {
        let textRange = NSMakeRange(0, stringValue.characters.count)
        let color = NSColor(red: 0, green: 0, blue: 238/255, alpha: 1)

        let attributedText = NSMutableAttributedString(string: stringValue)
        attributedText.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        // attributedText.addAttribute(NSLinkAttributeName, value: "url", range: textRange)
        attributedText.addAttribute(NSForegroundColorAttributeName, value: color, range: textRange)

        self.attributedStringValue = attributedText
    }

    override func mouseDown(with event: NSEvent) {
        guard let url = URL(string: href) else {
            return
        }

        NSWorkspace.shared().open(url)
    }
}
