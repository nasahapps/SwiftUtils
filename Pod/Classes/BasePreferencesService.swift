//
//  BasePreferencesService.swift
//  Pods
//
//  Created by Hakeem on 12/15/15.
//
//

import Foundation

public class BasePreferencesService {
    
    var prefs: NSUserDefaults!
    
    public init() {
        self.prefs = NSUserDefaults.standardUserDefaults()
    }
    
    public func putInt(key: String, value: Int) {
        prefs.setInteger(value, forKey: key)
        prefs.synchronize()
    }
    
    public func getInt(key: String) -> Int {
        return prefs.integerForKey(key)
    }
    
    public func putBool(key: String, value: Bool) {
        prefs.setBool(value, forKey: key)
        prefs.synchronize()
    }
    
    public func getBool(key: String) -> Bool {
        return prefs.boolForKey(key)
    }
    
    public func putObject(key: String, value: AnyObject) {
        prefs.setObject(value, forKey: key)
        prefs.synchronize()
    }
    
    public func getObject(key: String) -> AnyObject? {
        return prefs.objectForKey(key)
    }
    
}