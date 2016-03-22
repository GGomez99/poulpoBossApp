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
        var res: Arret = Arret(name: arret, horaires: []);
        var str: String = "http://envibus.kyrandia.org/tempsReel/?arret="+arret+"&lines=";
        
        for(var i: Int = 0; i < lignes.count; i++)
        {
            str += lignes[i].direction + "," + ELine.listOflineNo[lignes[i].name]!;
            if(i+1 < lignes.count)
            {
               str += ";";
            }
        }
        
        let url = NSURL(string: str)!
        if let html = try? NSString(contentsOfURL: url, usedEncoding: nil)
        {
            if let json = try? NSJSONSerialization.JSONObjectWithData(html.dataUsingEncoding(NSUnicodeStringEncoding)!, options: .AllowFragments) as! NSArray
            {
                if(json.count > 0)
                {
                for obj in json
                {
                    let h: Horaire = Horaire(line: ELine.getELineFromNo(obj["name"] as! String), direction: obj["direction"] as! String, via: obj["via"] as! String, time0: obj["time0"] as! String, time1: obj["time1"] as! String);
                    
                    res.horaires.append(h);
                }
                }
            }
        }
        return res;
    }
    
    func getTime(arret: String) -> Arret
    {
        var res: Arret = Arret(name: arret, horaires: []);
        let url = NSURL(string: "http://envibus.kyrandia.org/tempsReel/?arret="+arret.stringByReplacingOccurrencesOfString(" ", withString: "%20"))!;
        if let html = try? NSString(contentsOfURL: url, usedEncoding: nil)
        {
            if let json = try? NSJSONSerialization.JSONObjectWithData(html.dataUsingEncoding(NSUnicodeStringEncoding)!, options: .AllowFragments) as! NSArray
            {
                if(json.count > 0)
                {
                    for obj in json
                    {
                        let h: Horaire = Horaire(line: ELine.getELineFromNo(obj["name"] as! String), direction: obj["direction"] as! String, via: obj["via"] as!    String, time0: obj["time0"] as! String, time1: obj["time1"] as! String);
                    
                        res.horaires.append(h);
                    }
                }
            }
        }
        /*
        let url = NSURL(string: "http://envibus.kyrandia.org/tempsReel/?arret="+arret.stringByReplacingOccurrencesOfString(" ", withString: "%20"))
        if let html = try? NSString(contentsOfURL: url!, usedEncoding: nil)
        {
            let ffile: FFS = FFS(file: html as String);
            //on crée l'horaire
            print(ffile.getFileContent())
            for o in ffile.getFFSObjectArray()
            {
                let h: Horaire = Horaire(line: ELine.getELineFromNo(o.getValue("name")), direction: o.getValue("direction"), via: o.getValue("via"), time0: o.getValue("time0"), time1: o.getValue("time1"));
                
                res.horaires.append(h);
                
            }
        }
        */
        return res;
    }
    
    /*func test()
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

    }*/
    
}