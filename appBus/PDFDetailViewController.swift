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
    var PDFDetail: NSURL?
    
    //load WK
    override func loadView() {
        webView = WKWebView()
        view = webView
        
    }
    
    //give PDF to WK to load it
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
            var PDFLoaded = false
            var pdfLinkReload = self.PDFDetail
            
            while PDFLoaded == false {
                pdfLinkReload = self.PDFDetail
                
                if let url = pdfLinkReload as NSURL! {
                    print("Loading \(url)")
                    self.webView.loadRequest(NSURLRequest(URL: url))
                    PDFLoaded = true
                } else {
                    print("URL fucked up : \(pdfLinkReload)")
                }
                
                sleep(3)
            }
        }
    }

}
