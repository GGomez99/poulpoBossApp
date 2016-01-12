//
//  NetReader.swift
//  appBus
//
//  Created by frayien on 28/12/15.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import Foundation

class NetReader
{
    init()
    { }
    func test()
    {
        let url = NSURL(string: "http://envibus.tsi.cityway.fr/")
        let html = try? NSString(contentsOfURL: url!, usedEncoding: nil)
        print(html)

    }
    
}