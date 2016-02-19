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
        
        let url = NSURL(string: str)
        if let html = try? NSString(contentsOfURL: url!, usedEncoding: nil)
        {
            let ffile: FFS = FFS(file: html as String);
            //on crée l'horaire
            for o in ffile.getFFSObjectArray()
            {
                let h: Horaire = Horaire(line: ELine.getELineFromNo(o.getValue("name")), direction: o.getValue("direction"), via: IOAPI.tabToString(o.getArray("via")), time0: o.getValue("time"), time1: o.getValue("time"));
                var isset = false;
                //on cherche si il existe on set l'horaire 2
                for var ho in res.horaires
                {
                    if(ho.line == h.line && ho.direction == h.direction && ho.via == h.via)
                    {
                        ho.time1 = h.time0;
                        isset = true;
                        break;
                    }
                    
                }
                //sinon on add
                if(!isset)
                {
                    res.horaires.append(h);
                }
            }
        }
        return res;
    }
    
    func getTime(arret: String) -> Arret
    {
        var res: Arret = Arret(name: arret, horaires: []);
        let url = NSURL(string: "http://envibus.kyrandia.org/tempsReel/?arret="+arret)
        if let html = try? NSString(contentsOfURL: url!, usedEncoding: nil)
        {
            let ffile: FFS = FFS(file: html as String);
            //on crée l'horaire
            for o in ffile.getFFSObjectArray()
            {
                let h: Horaire = Horaire(line: ELine.getELineFromNo(o.getValue("name")), direction: o.getValue("direction"), via: IOAPI.tabToString(o.getArray("via")), time0: o.getValue("time"), time1: o.getValue("time"));
                var isset = false;
                //on cherche si il existe on set l'horaire 2
                for var ho in res.horaires
                {
                    if(ho.line == h.line && ho.direction == h.direction && ho.via == h.via)
                    {
                        ho.time1 = h.time0;
                        isset = true;
                        break;
                    }
                    
                }
                //sinon on add
                if(!isset)
                {
                    res.horaires.append(h);
                }
            }
        }
        
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