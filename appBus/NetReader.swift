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
    
    func getTime()
    {
        
    }
    
    func test()
    {
        let url = NSURL(string: "http://envibus.kyrandia.org/?id=4$43$31,5$44$31")
        if let html = try? NSString(contentsOfURL: url!, usedEncoding: nil)
        {
            print(html)
        }
        else
        {
            print("error")
        }

    }
    
}