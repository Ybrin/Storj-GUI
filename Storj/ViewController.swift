//
//  ViewController.swift
//  Storj
//
//  Created by Koray Koska on 14/09/2017.
//  Copyright © 2017 Koray Koska. All rights reserved.
//

import Cocoa
import WebKit
import Cartography
import LibStorj

class ViewController: NSViewController {

    // MARK: - Properties

    @IBOutlet weak var loginBox: NSBox!
    @IBOutlet weak var registerLabel: NSTextFieldCell!
    @IBOutlet weak var storjLogoContainer: NSView!

    var webView: WKWebView!

    // MARK - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI
        setupUI()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // MARK: - UI setup

    func setupUI() {
        // Setup Storj Logo
        setupStorjLogo()

        // Setup Register button
        setupRegisterButton()

        // Setup WebView
        setupWebView()
    }

    func setupStorjLogo() {
        let image = NSImage(named: NSImage.Name("storj_icon_text"))
        let i = NSImageView()
        i.image = image

        i.imageScaling = .scaleProportionallyUpOrDown

        storjLogoContainer.addSubview(i)

        i.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        i.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        constrain(storjLogoContainer, i) { (container, imageView) in
            imageView.left == container.left
            imageView.right == container.right
            imageView.top == container.top
            imageView.bottom == container.bottom
            imageView.centerX == container.centerX
            imageView.centerY == container.centerY
        }
    }

    func setupRegisterButton() {
        /*
        let registerText = "Sign Up"
        let registerTextRange = NSMakeRange(0, registerText.characters.count)
        let color = NSColor(red: 0, green: 0, blue: 238/255, alpha: 1)

        let attributedRegisterText = NSMutableAttributedString(string: registerText)
        attributedRegisterText.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: registerTextRange)
        attributedRegisterText.addAttribute(NSLinkAttributeName, value: "https://app.storj.io/signup", range: registerTextRange)
        attributedRegisterText.addAttribute(NSForegroundColorAttributeName, value: color, range: registerTextRange)

        registerLabel.attributedStringValue = attributedRegisterText
         */
    }

    func setupWebView() {
        webView = WKWebView()
        view.addSubview(webView, positioned: .below, relativeTo: loginBox)

        constrain(view, webView) { (view, web) in
            web.left == view.left
            web.right == view.right
            web.top == view.top
            web.bottom == view.bottom
            web.centerX == view.centerX
            web.centerY == view.centerY
        }

        guard let htmlPath = Bundle.main.path(forResource: "register", ofType: "html") else {
            return
        }
        guard let htmlString = try? String(contentsOfFile: htmlPath, encoding: .utf8) else {
            return
        }

        webView.loadHTMLString(htmlString, baseURL: nil)

        /*
        // Load particles into background
        if let url = URL(string: "http://127.0.0.1:8080/index.html") {
            webView.load(URLRequest(url: url))
        }*/
    }

    // MARK: - Actions

    @IBAction func loginButtonClicked(_ sender: NSButton) {
        // let r = LibStorj.b
    }
}
