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

    static func start() { }
    
    static func getTime(arret: String) -> Arret
    {
        return Arret(name: "arret", horaires: [])
    }
    
    static func getTime(arret: String, line: String) -> Arret
    {
        return Arret(name: "arret", horaires: [])
    }
    
    static func getListOfArret() -> [String]
    {
        return jsonReader.getAllArret()
    }
    
    static func getListOfLine(nameOfArret: String) -> [Line]
    {
        return jsonReader.getAllLine(nameOfArret)
    }
}