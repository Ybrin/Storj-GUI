//
//  ViewControllerExtensions.swift
//  Storj
//
//  Created by Koray Koska on 19/09/2017.
//

import Foundation
import Cocoa

extension NSViewController {

    /**
     * Creates an OK/Cancel sheet dialog with the given title and detail text.
     * Does nothing if self.view == nil.
     */
    func sheetDialog(title: String, text: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        guard let window = self.view.window else {
            return
        }
        alert.beginSheetModal(for: window, completionHandler: nil)
    }
}
