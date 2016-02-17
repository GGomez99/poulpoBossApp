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
    let via: String
    let direction: String
}

struct Horaire
{
    let line: Line
    let state: hState
    let time0: String?
    let time1: String?
    
}

struct Arret
{
    let name: String
    let horaires: [Horaire]
}

enum hState
{
    case prochain, pasDeBus, pasDeConection
}