//
//  IOCore.swift
//  appBus
//
//  Created by frayien on 15/02/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import Foundation

public class IOCore
{
    private init() { }
    
    ///lecture d'un mot
    public static func staticReadWord(str: String, i: Int, separator: CChar, enter: Bool) -> String
    {
        var j: Int = i;
    return readWord(str, i: &j, separator: separator, enter: enter);
    }
    
    public static func readWord(str: String, inout i: Int, separator: CChar, enter: Bool) -> String
    {
    //si str vide return rien
    if(str.characters.count <= i)
    {
        return "";
    }
    var result: [CChar] = [];
    var lecture: CChar;
    
    repeat
    {
        lecture = str.cStringUsingEncoding(NSASCIIStringEncoding)![i];
    if(lecture == separator || (enter ? lecture == "\n".cStringUsingEncoding(NSASCIIStringEncoding)![0]: false))
        {
            break;
        }
    i++;
    result.append(lecture);
    }
    while(str.characters.count > i);
    return String(result);
    }
    
    ///lecture d'un block
    public static func readBlock(str: String, inout i: Int) -> String
    {
    //si str vide return rien
        if(str.characters.count <= i)
        {
            return "";
        }
        var result: [CChar] = [];
        var lecture: CChar;
        var dans: Int = 1;
    
    repeat
    {
    lecture = str.cStringUsingEncoding(NSASCIIStringEncoding)![i];
    if(lecture == "}".cStringUsingEncoding(NSASCIIStringEncoding)![0])
    {
    dans--;
    if(dans == 0)
        {
            break;
        }
    }
        else if(lecture == "{".cStringUsingEncoding(NSASCIIStringEncoding)![0])
        {
            dans++;
        }
    i++;
    result.append(lecture);
    }
    while(str.characters.count > i);
    
    return String(result);
    }
    
    
    ///useful
    public static func removeSpaces(inout str: String)
    {
        var returned: [CChar] = [];
        
        for(var i: Int = 0; i<str.characters.count; i++)
        {
            if(str.cStringUsingEncoding(NSASCIIStringEncoding)![i] != " ".cStringUsingEncoding(NSASCIIStringEncoding)![0] && str.cStringUsingEncoding(NSASCIIStringEncoding)![i] != "\u{31}".cStringUsingEncoding(NSASCIIStringEncoding)![0] && str.cStringUsingEncoding(NSASCIIStringEncoding)![i] != "\n".cStringUsingEncoding(NSASCIIStringEncoding)![0])
        {
            returned.append(str.cStringUsingEncoding(NSASCIIStringEncoding)![i]);
            }
        }
        str = String(returned);
    }
    
    public static func stringVectorToInt(vect: [String]) -> [Int]
    {
        var returned: [Int] = [];
        for(var i: Int = 0; i<vect.count; i++)
        {
            returned.append(Int(vect[i])!);
        }
    return returned;
    }
    
    public static func displayVector(vect: [AnyObject])
    {
        for(var i: Int = 0; i<vect.count; i++)
        {
            if(i>0 && i<vect.count)
            {
                print(",");
            }
            print(vect[i]);
        }
    }
}