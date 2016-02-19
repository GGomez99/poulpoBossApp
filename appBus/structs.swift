//
//  structs.swift
//  appBus
//
//  Created by frayien on 28/12/15.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import Foundation

struct Line
{
    let name: ELine
    let direction: String
}

struct Horaire
{
    let line: ELine
    let direction: String
    let via: String
    let time0: String
    var time1: String
    
}

struct Arret
{
    let name: String
    var horaires: [Horaire]
}

enum hState
{
    case prochain, pasDeBus, pasDeConection
}