//
//  PDFDetailViewController.swift
//  appBus
//
//  Created by Guyllian Gomez on 01/01/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import UIKit
import WebKit

class PDFDetailViewController: UIViewController {
    
    var webView: WKWebView!
    var PDFDetail: String!
    
    //load WK
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    //give PDF to WK to load it
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://www.google.com")!
        webView.loadRequest(NSURLRequest(URL: url))
    }

}
