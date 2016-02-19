//
//  FFSObject.swift
//  appBus
//
//  Created by frayien on 15/02/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import Foundation

public class FFSObject
{
    var m_children: [String : FFSObject];
    var m_values: [String : String];
    var m_arrays: [String : [String]];
    
    ///static null
    public static let nullFFSObject: FFSObject = FFSObject();
    public static var nullVector: [String] = [];
    
    public init()
    {
        m_children = [:];
        m_values = [:];
        m_arrays = [:];
    }
    
    public func addChild(key: String)
    {
    if(m_children.keys.contains((key)))
        {
        return;
        }
        m_children[key] = FFSObject();
    }
    public func addValue(key: String, value: String)
    {
        if(m_values.keys.contains(key))
        {
            return;
        }
        m_values[key] = value;
    }
    public func addArray(key: String, array: [String])
    {
    if(m_arrays.keys.contains(key))
    {
        return;
    }
    m_arrays[key] = array;
    }
    
    ///ffsobject
    public func c(key: String) -> FFSObject
    {
    if(!m_children.keys.contains(key))
    {
        return FFSObject.nullFFSObject;
    }
    return m_children[key]!;
    }
    
    public func  getFFSObjectArray() -> [FFSObject]
    {
        var returned: [FFSObject] = [];
    
    for (_,child) in m_children
    {
        returned.append(child);
    }
    return returned;
    }
    public func getFFSObjectMap() -> [String : FFSObject]
    {
    return m_children;
    }
    
    ///value
    public func getValue(key: String) -> String
    {
        if(!m_values.keys.contains(key))
        {
            return "";
        }
        return m_values[key]!;
    }
    public func getIntValue(key: String) -> Int
    {
        let val: String = getValue(key);
        return Int(val)!;
    }
    public func getBoolValue(key: String) -> Bool
    {
        let val: String = getValue(key);
        return val == "true";
    }
    
    ///array
    public func getArray(key: String) -> [String]
    {
        if(!m_arrays.keys.contains(key))
        {
            return FFSObject.nullVector;
        }
        return m_arrays[key]!;
    }
    public func getIntArray(key: String) -> [Int]
    {
        return IOCore.stringVectorToInt(getArray(key));
    }
    
    //writing array pour sav
    func writeArray(inout str: String, tab: [String])
    {
        for(var i: Int = 0; i<tab.count; i++)
        {
            if(i>0 && i<tab.count)
            {
                str += ",";
            }
            str += tab[i];
        }
    }
    
    ///sav
    public func writeInString(inout str: String)
    {
    ///values
   for (val_key, val_val) in m_values
    {
        str += "#var " + val_key + " " + val_val + ";";
    }
    
    ///arrays
    for (array_key,array_val) in m_arrays
    {
    str += "#array " + array_key + ":";
    writeArray(&str, tab: array_val);
    str += ";";
    }
    
    ///children
    for (child_key,child_val) in m_children
    {
    str += "#def " + child_key + "{";
    child_val.writeInString(&str);
    str += "}";
    }
    }
}