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
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PDFDetail)
        let url: NSURL = NSURL(string: PDFDetail)!
        webView.loadRequest(NSURLRequest(URL: url))
    }

}
