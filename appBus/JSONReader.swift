//
//  JSONReader.swift
//  appBus
//
//  Created by frayien on 28/12/15.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import Foundation

class JSONReader
{
    init()
    {
        
    }
    
    func readCode(arret: String, line: ELine, direction: String) -> String?
    {
        //stream vers le fichier
        let stream: NSInputStream = NSInputStream(fileAtPath: "\(NSBundle.mainBundle().resourcePath!)/antibes.json")!
        stream.open()
        
        //file via le stream
        let file = try! NSJSONSerialization.JSONObjectWithStream(stream, options: NSJSONReadingOptions.MutableContainers)
        
        //reading
        if let a = file as? NSArray
        {
            for b in a
            {
                if let c = b["name"] as? String
                {
                    if(c == arret)
                    {
                        if let d = b["directions"] as? NSDictionary
                        {
                            if let e = d["lineNo"] as? String
                            {
                                if(e == ELine.listOflineNo[line])
                                {
                                    if let f = d["name"] as? String
                                    {
                                        if(f == direction)
                                        {
                                            return d["code"] as! String
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
            
        }

        
        return nil
    }
    
    //la liste de toutes les lignes
    static func getAllArret() -> [String]
    {
        var array: [String] = []
        
        //stream vers le fichier
        let stream: NSInputStream = NSInputStream(fileAtPath: "\(NSBundle.mainBundle().resourcePath!)/antibes.json")!
        stream.open()
        
        //file via le stream
        let file = try! NSJSONSerialization.JSONObjectWithStream(stream, options: NSJSONReadingOptions.MutableContainers)
        
        //reading
        if let a = file as? NSArray
        {
            for b in a
            {
                if let c = b["name"] as? String
                {
                    array.append(c);
                }
            }
            
        }
        return array
    }
    
    //les lignes d'un arret
    static func getAllLine(arret: String) -> [Line]
    {
        var array: [Line] = []
        
        //stream vers le fichier
        let stream: NSInputStream = NSInputStream(fileAtPath: "\(NSBundle.mainBundle().resourcePath!)/antibes.json")!
        stream.open()
        
        //file via le stream
        let file = try! NSJSONSerialization.JSONObjectWithStream(stream, options: NSJSONReadingOptions.MutableContainers)
        
        //reading
        if let a = file as? NSArray
        {
            for b in a
            {
                if let c = b["name"] as? String
                {
                    if c == arret
                    {
                        if let d = b["directions"] as? NSArray
                        {
                            for e in d
                            {
                                if let f = e as? NSDictionary
                                {
                                    array.append(Line(name: ELine.getELineFromNo(f["lineNo"] as! String), direction: f["name"] as! String))
                                }
                            }
                        }
                        break;
                    }
                }
            }
        }
        
        return array
    }
}