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
    
    func getTime(arret: String, lignes: [Line]) -> Arret
    {
        var str: String = "http://envibus.kyrandia.org/?arret="+arret+"&lines=";
        
        for(var i: Int = 0; i < lignes.count; i++)
        {
            str += lignes[i].direction + "," + ELine.listOflineNo[lignes[i].name]!;
            if(i+1 < lignes.count)
            {
               str += ";";
            }
        }
        
        let url = NSURL(string: str)
        if let html = try? NSString(contentsOfURL: url!, usedEncoding: nil)
        {
            let ffile: FFS = FFS(file: html as String);
            for o in ffile.getFFSObjectArray()
            {
                
            }
        }
        
        var res: Arret = Arret(name: "", horaires: []);
        
        return res;
    }
    
    /*func getTime(arret: String) -> Arret
    {
        var res: Arret = Arret(name: arret, horaires: []);
        let url = NSURL(string: "http://envibus.kyrandia.org/?arret="+arret)
        if let html = try? NSString(contentsOfURL: url!, usedEncoding: nil)
        {
            let ffile: FFS = FFS(file: html as String);
            for o in ffile.getFFSObjectArray()
            {
                let l: Line = Line(name: ELine.getELineFromNo(o.getValue("name"), via: IOCore.);
                var a: Horaire
                //o.c()
            }
        }
        
        return res;
    }*/
    
    func test()
    {
        let url = NSURL(string: "http://envibus.kyrandia.org/?id=4$43$31,5$44$31")
        if let html = try? NSString(contentsOfURL: url!, usedEncoding: nil)
        {
            let ffile: FFS = FFS(file: html as String);
            for o in ffile.getFFSObjectArray()
            {
                
            }
        }
        else
        {
            print("error")
        }

    }
    
}