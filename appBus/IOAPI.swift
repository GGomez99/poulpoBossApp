//
//  IOAPI.swift
//  appBus
//
//  Created by frayien on 28/12/15.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import Foundation

class IOAPI
{
    private static let netReader: NetReader = NetReader()
    private static let jsonReader: JSONReader = JSONReader()

    /*static func start() {
        netReader.test()
    }*/
    
    static func getTime(arret: String) -> Arret
    {
        return netReader.getTime(arret)
    }
    
    static func getTime(arret: String, lines: [Line]) -> Arret
    {
        return netReader.getTime(arret, lignes: lines)
    }
    
    
    /*
    * IOAPI.getListOfArret() -> [String]
    *
    * retourne la liste de tout les arrets référencés dans le json
    *
    */
    static func getListOfArret() -> [String]
    {
        return jsonReader.getAllArret()
    }
    
    /*
    * IOAPI.getListOfLine(nameOfArret: String) -> [Line]
    *
    * retourne la liste de toute les lignes référencées dans le json à un arret
    *
    */
    static func getListOfLine(nameOfArret: String) -> [Line]
    {
        return jsonReader.getAllLine(nameOfArret)
    }
    
    /*
    * IOAPI.getListOfLine() -> [String]
    *
    * retourne la liste de toute les lignes
    *
    */
    static func getListOfLine() -> [String]
    {
        return ELine.getListOfLines()
    }
    
    static func tabToString(tab: [String]) -> String
    {
        var res: String = "";
        for(var i: Int = 0; i < tab.count; i++)
        {
            res += tab [i];
            if(i+1 < tab.count)
            {
                res += " / ";
            }
        }
        return res
    }
}