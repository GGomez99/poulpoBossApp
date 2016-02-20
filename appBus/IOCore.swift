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
    public static func staticReadWord(str: [CChar], i: Int, separator: CChar, enter: Bool) -> [CChar]
    {
        var j: Int = i;
    return readWord(str, i: &j, separator: separator, enter: enter);
    }
    
    public static func readWord(str: [CChar], inout i: Int, separator: CChar, enter: Bool) -> [CChar]
    {
    //si str vide return rien
    if(str.count <= i)
    {
        return [];
    }
    var result: [CChar] = [];
    var lecture: CChar;
    
    repeat
    {
        lecture = str[i];
    if(lecture == separator || (enter ? lecture == "\n".cStringUsingEncoding(NSASCIIStringEncoding)![0]: false))
        {
            break;
        }
    i++;
    result.append(lecture);
    }
    while(str.count > i);
        return result;
    }
    
    ///lecture d'un block
    public static func readBlock(str: [CChar], inout i: Int) -> [CChar]
    {
    //si str vide return rien
        if(str.count <= i)
        {
            return [];
        }
        var result: [CChar] = [];
        var lecture: CChar;
        var dans: Int = 1;
    
    repeat
    {
    lecture = str[i];
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
    while(str.count > i);
    
        return result
    }
    
    
    ///useful
    public static func removeSpaces(inout str: [CChar])
    {
        var returned: [CChar] = [];
        
        for(var i: Int = 0; i<str.count; i++)
        {
            if(str[i] != " ".cStringUsingEncoding(NSASCIIStringEncoding)![0] && str[i] != "\u{31}".cStringUsingEncoding(NSASCIIStringEncoding)![0] && str[i] != "\n".cStringUsingEncoding(NSASCIIStringEncoding)![0])
        {
            returned.append(str[i]);
            }
        }
        str = returned;
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