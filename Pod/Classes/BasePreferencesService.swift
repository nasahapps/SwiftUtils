//
//  BasePreferencesService.swift
//  Pods
//
//  Created by Hakeem on 12/15/15.
//
//

import Foundation

open class BasePreferencesService {
    
    var prefs: UserDefaults!
    
    public init() {
        self.prefs = UserDefaults.standard
    }
    
    open func putInt(_ key: String, value: Int) {
        prefs.set(value, forKey: key)
        prefs.synchronize()
    }
    
    open func getInt(_ key: String) -> Int {
        return prefs.integer(forKey: key)
    }
    
    open func putBool(_ key: String, value: Bool) {
        prefs.set(value, forKey: key)
        prefs.synchronize()
    }
    
    open func getBool(_ key: String) -> Bool {
        return prefs.bool(forKey: key)
    }
    
    open func putObject(_ key: String, value: AnyObject) {
        prefs.set(value, forKey: key)
        prefs.synchronize()
    }
    
    open func getObject(_ key: String) -> AnyObject? {
        return prefs.object(forKey: key) as AnyObject
    }
    
}
