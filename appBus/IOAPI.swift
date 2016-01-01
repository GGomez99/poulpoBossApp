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

    static func start() {
    netReader.test()
    }
    
    static func getTime(arret: String) -> Arret
    {
        return Arret(name: "arret", horaires: [])
    }
    
    static func getTime(arret: String, line: String) -> Arret
    {
        return Arret(name: "arret", horaires: [])
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
    * retourne la liste de toute les lignes référencées dans le json
    *
    */
    static func getListOfLine() -> [String]
    {
        return []
    }
}