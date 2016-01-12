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
    let name: String
    let direction: String
}

struct Horaire
{
    let line: Line
    let state: hState
    let time: String?
    
}

struct Arret
{
    let name: String
    let horaires: [Horaire]
}

enum hState
{
    case prochain, horaire, pasDeBus, pasDeConection
}