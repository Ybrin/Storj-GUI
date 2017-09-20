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

    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var mnemonicTextField: NSTextField!
    
    var webView: WKWebView!

    var libStorj: LibStorj!

    /// Saves the current logging in state
    var loggingIn = false

    // MARK - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup LibStorj
        let b = StorjBridgeOptions(
            proto: ConstantHolder.APIValues.apiProto,
            host: ConstantHolder.APIValues.apiUrl,
            port: ConstantHolder.APIValues.apiPort
        )
        libStorj = LibStorj(bridgeOptions: b)

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

    func setupWebView() {
        webView = WKWebView()
        view.addSubview(webView, positioned: .below, relativeTo: loginBox)

        // Position WebView
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
    }

    // MARK: - Actions

    @IBAction func loginButtonClicked(_ sender: NSButton) {
        let user = emailTextField.stringValue
        let pass = passwordTextField.stringValue
        let mnemonic = mnemonicTextField.stringValue

        guard !user.isEmpty && !pass.isEmpty && !mnemonic.isEmpty else {
            sheetDialog(title: "Are you stupid?", text: "Yes/No")
            return
        }

        guard LibStorj.mnemonicCheck(mnemonic: mnemonic) else {
            sheetDialog(title: "Mnemonic is wrong!", text: "Please check your mnemonic")
            return
        }

        let b = StorjBridgeOptions(
            proto: ConstantHolder.APIValues.apiProto,
            host: ConstantHolder.APIValues.apiUrl,
            port: ConstantHolder.APIValues.apiPort,
            user: user,
            pass: pass
        )
        let e = StorjEncryptOptions(mnemonic: mnemonic)
        libStorj = LibStorj(bridgeOptions: b, encryptOptions: e)

        DispatchQueue.global().async {
            _ = self.libStorj.getBuckets(completion: { (success, req) in
                guard success, req.statusCode == 200 else {
                    if req.statusCode == 401 {
                        DispatchQueue.main.async {
                            self.sheetDialog(title: "Email or Password wrong", text: "Please check your entered Email and Password for typos.")
                        }
                    } else {
                        let status = req.statusCode
                        let error = req.errorCode
                        DispatchQueue.main.async {
                            self.sheetDialog(title: "Something went wrong", text: "Oh no! The HTTP status code is \(status) and the error code is \(error). Please open an issue on Github.")
                        }
                    }
                    return
                }

                DispatchQueue.main.async {
                    // TODO: Redirect User to Buckets List
                }
            })
        }
    }
}
