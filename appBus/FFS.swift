//
//  FFS.swift
//  appBus
//
//  Created by frayien on 15/02/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import Foundation

public class FFS : FFSObject
{
    ///vars
    private var m_error: Error;
    private var m_fileContent: [CChar];
    
    ///constructeur
    public init(file: String)
    {
        m_error = Error();
        m_fileContent = [];
        super.init(); 
        
        load(file);
    }
    
    
    ///load
    public func load(file: String)
    {
        m_error.set(true, error: "");
        
        m_fileContent = file.cStringUsingEncoding(NSASCIIStringEncoding)!;
        
        //precompiler pour macro et verif
        precompiler();
        
        //si pas erreur : on lit et on stoke dans les tab
        if(!m_error.state())
        {
            return;
        }
        
        compiler(self, file: m_fileContent);
        
        if(!m_error.state())
        {
            print(m_error.error());
        }
    }
    
    ///sauvegarde
    public func clear()
    {
        m_fileContent = [];
        m_error.set(true, error: "");
        m_arrays = [:];
        m_values = [:];
        m_children = [:];
    }
    
    /*public func save() -> Error
    {
        //base
        var newfile: String = "#ffs;";
        
        writeInString(&newfile);
        
        Path file = Paths.get(m_path);
        
        try (BufferedWriter out = Files.newBufferedWriter(file))
        {
            out.write(newfile.get());
        } catch (IOException e) {
            return new Error(false, "[ERROR] [FFS] cannot save file");
        }
        
        return new Error();
    }*/
    
    ///recup de l'erreur
    public func getError() -> Error
    {
        return m_error;
    }
    ///recup
    public func getFileContent() -> String
    {
        return String(m_fileContent);
    }
    
    private func substr(tab: [CChar], start: Int, end: Int) -> [CChar]
    {
        var result: [CChar] = [];
        
        for(var i: Int = 0; i<tab.count; i++)
        {
            if(i >= start && i < end)
            {
                result.append(tab[i]);
            }
        }
        
        return result;
    }
    
    ///gestion macro et verif
    private func precompiler()
    {
        //on verif la premiere ligne
        if(m_fileContent[0] == "#".cStringUsingEncoding(NSASCIIStringEncoding)![0])
        {
            //si c'est bien ffs
            if(IOCore.staticReadWord(String(m_fileContent), i: 1, separator: ";".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false) != "ffs")
            {//non
                m_error.set(false, error: "[ERROR] [FFS] file no well formated");
            }
            else
            { //ok bon format
                //on enleve ffs
                m_fileContent = substr(m_fileContent, start: 5, end: m_fileContent.count);
            }
        }
        else
        {
           m_error.set(false, error: "[ERROR] [FFS] file no well formated");
        }
        
        if(!m_error.state())
        {
            return;
        }
        
        //on cherche les #
        for(var i: Int = 0; i < m_fileContent.count; i++)
        {
            if(m_fileContent[i] == "#".cStringUsingEncoding(NSASCIIStringEncoding)![0])
            { //je suis sur un #
                //si c'est une macro
                if(IOCore.staticReadWord(String(m_fileContent), i: i+1, separator: " ".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false) == "macro")
                {
                    var j: Int = i+1;
                    var txtCommand: String = IOCore.readWord(String(m_fileContent), i: &j, separator: ";".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                    loadMacro(txtCommand);
                    m_fileContent = substr(m_fileContent, start: 0, end: i) + substr(m_fileContent, start: j+1, end: m_fileContent.count);
                    i--;
                }
            }
        }
    }
    
    private func compiler(object: FFSObject, file: [CChar])
    {
        //on cherche les #
        for(var i: Int = 0; i < file.count; i++)
        {
            if(file[i] == "#".cStringUsingEncoding(NSASCIIStringEncoding)![0])
            {// on est sur un #
                //on recup la command
                i++;
                var name: String = IOCore.staticReadWord(String(file), i: i, separator: " ".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                
                if(name == "def")
                {
                    //recup command
                    var command: String = IOCore.readWord(String(file), i: &i, separator: "{".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                    i++;
                    var di: Int = 0;
                        //nom de la command
                        IOCore.readWord(command, i: &di, separator: " ".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        di++;
                        //key
                    var child: String = IOCore.readWord(command, i: &di, separator: "{".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        //on enleve les espaces
                        IOCore.removeSpaces(&child);
                        
                        //add du child
                        object.addChild(child);
                        //recup des params
                    var nfile: String = IOCore.readBlock(String(file), i: &i);
                        compiler(object.c(child), file: nfile.cStringUsingEncoding(NSASCIIStringEncoding)!);
                        }
                        else if(name == "var")
                        {
                        //recup command
                            var command: String = IOCore.readWord(String(file), i: &i, separator: ";".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                            var vi: Int = 0;
                        //nom de la command
                        IOCore.readWord(command, i: &vi, separator: " ".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        vi++;
                        //key
                            var key: String = IOCore.readWord(command, i: &vi, separator: " ".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        //on enleve les espaces
                        IOCore.removeSpaces(&key);
                        vi++;
                        //value
                            var value: String = IOCore.readWord(command, i: &vi, separator: ";".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        
                        object.addValue(key, value: value);
                        }
                        else if(name == "array")
                        {
                        //recup command
                            var command: String = IOCore.readWord(String(file), i: &i, separator: ";".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                            var vi: Int = 0;
                        //nom de la command
                        IOCore.readWord(command, i: &vi, separator: " ".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        vi++;
                        //key
                            var key: String = IOCore.readWord(command, i: &vi, separator: ":".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        //on enleve les espaces
                        IOCore.removeSpaces(&key);
                        vi++;
                        //value
                            var strArray: String = IOCore.readWord(command, i: &vi, separator: ";".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        
                        object.addArray(key, array: readArray(strArray));
                        }
                        if(!m_error.state())
                        {
                           break;
                        }
                    }
                }
            }
                        
                        
                        ///gestions des commands
    private func loadMacro(macro: String)
    {
        var i: Int = 0;
                        //si c bien une macro
                if(IOCore.readWord(macro, i: &i, separator: " ".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false) != "macro")
                    {//non
                        m_error.set(false, error: "[ERROR] [FFS] invalid macro");
                        return;
                    }
                        //recup des args
                        i++;
        var macroId: String = IOCore.readWord(macro, i: &i, separator: " ".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        i++;
        var macroValue: String = IOCore.readWord(macro, i: &i, separator: ";".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false);
                        
                        //mise en place
                        for(i = 0; i < m_fileContent.count; i++)
                        {
                        //si on est sur un \ on verif si c'est une macro
                        if(m_fileContent[i] == "\\".cStringUsingEncoding(NSASCIIStringEncoding)![0])
                        {
                            var j: Int = i+1;
                        //si le nom corespond
                        if(IOCore.readWord(String(m_fileContent), i: &j, separator: "\\".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false) == macroId)
                        {
                        //string = son debut + la macro + sa fin
                        //i = pos de /, donc lenght sur char avant
                        //j = pos de /, donc +1 pour char suivant
                        //longueur du string - j+1 pour num du char, longueur restante
                        m_fileContent = (String(substr(m_fileContent, start: 0, end: i)) + macroValue + String(substr(m_fileContent, start: j+1,end: m_fileContent.count))).cStringUsingEncoding(NSASCIIStringEncoding)!;
                        }
                    }
                }
            }
                        
                        
    private func readArray(strArray: String) -> [String]
                        {
                            var returned: [String] = [];
                            var i: Int = 0;
                        
                        //tant que i est pas au bout
                        while(i < strArray.characters.count)
                        {
                        //on add a returned les valeurs
                        returned.append(IOCore.readWord(strArray, i: &i, separator: ",".cStringUsingEncoding(NSASCIIStringEncoding)![0], enter: false));
                        i++;
                        }
                        
                        return returned;
                        }
                        
}