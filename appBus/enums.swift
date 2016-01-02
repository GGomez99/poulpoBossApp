//
//  enums.swift
//  appBus
//
//  Created by frayien on 01/01/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import Foundation

enum ELine
{
    case L_1_nuit,L_1_vac, L_1, L_2, L_5, L_6, L_6_vac, L_7, L_8, L_8_vac, L_9, L_10, L_11, L_12, L_14, L_15, L_16, L_17, L_18, L_18_vac, L_19, L_20, L_21, L_22, L_23, L_24, L_25, L_26, L_28, L_30_31, L_100, CFB, Plan_General
}

extension ELine
{
    private static let listOfLines: [ELine : String] =
        [ELine.L_1 : "Ligne 1",
        ELine.L_1_nuit : "Ligne 1 soirée",
        ELine.L_1_vac : "Ligne 1 vacances",
        ELine.L_2 : "Ligne 2",
        ELine.L_30_31 : "Ligne 3",
        ELine.L_5 : "Ligne 5",
        ELine.L_6 : "Ligne 6",
        ELine.L_6_vac : "Ligne 6 vacances",
        ELine.L_7 : "Ligne 7",
        ELine.L_8 : "Ligne 8",
        ELine.L_8_vac : "Ligne 8 vacances",
        ELine.L_9 : "Ligne 9",
        ELine.L_10 : "Ligne 10",
        ELine.L_11 : "Ligne 11",
        ELine.L_12 : "Ligne 12",
        ELine.L_14 : "Ligne 14",
        ELine.L_15 : "Ligne 15",
        ELine.L_16 : "Ligne 16",
        ELine.L_17 : "Ligne 17",
        ELine.L_18 : "Ligne 18",
        ELine.L_18_vac : "Ligne 18 vac",
        ELine.L_19 : "Ligne 19",
        ELine.L_20 : "Ligne 20",
        ELine.L_21 : "Ligne 21",
        ELine.L_22 : "Ligne 22",
        ELine.L_23 : "Ligne 23",
        ELine.L_24 : "Ligne 24",
        ELine.L_25 : "Ligne 25",
        ELine.L_26 : "Ligne 26",
        ELine.L_28 : "Ligne 28",
        ELine.L_100 : "Ligne 100",
        ELine.CFB : "Ligne special CFB",
        ELine.Plan_General : "Plan Géneral"]
    
    static func getListOfLines() -> [String]
    {
        var array: [String] = []
        
        for (_,line) in listOfLines
        {
            array.append(line)
        }
        return array
    }
    
    static func toString(eline: ELine) -> String
    {
        return listOfLines[eline]!
    }
}