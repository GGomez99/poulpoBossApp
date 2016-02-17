//
//  Error.swift
//  appBus
//
//  Created by frayien on 15/02/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import Foundation

public class Error
{
    private var m_state: Bool;
    private var m_error: String;
    
    public init()
    {
        m_state = true;
        m_error = "";
    }
    
    public init(state: Bool, error: String)
    {
        m_state = state;
        m_error = error;
    }
    
    public func state() -> Bool
    {
        return m_state;
    }
    public func error() -> String
    {
        return m_error;
    }
    
    public func setState(state: Bool)
    {
        m_state = state;
    }
    public func setError(error: String)
    {
        m_error = error;
    }
    public func set(state: Bool, error: String)
    {
        m_state = state;
        m_error = error;
    }
    
    
}