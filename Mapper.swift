//
//  Mapper.swift
//
//  Created by Frograin on 21/05/15.
//  Copyright (c) 2015 Frograin. All rights reserved.
//

import Foundation

class Mapper {
    var mappings:Array<AnyObject>
    
    class func createMap<T, U>(map:(T) -> U) {
        let mapper:Mapper = Mapper.sharedInstance
        let newMap = Map<T, U>(map: map)
        mapper.mappings.append(newMap)
    }
    
    class func map<T, U>(source: T) -> U? {
        let mapper = Mapper.sharedInstance
        
        let target_instance = Map<T, U>()
        
        for map:AnyObject in mapper.mappings as Array<AnyObject> {
            let mirror_candidate = Mirror(reflecting: map)
            let mirror_target = Mirror(reflecting: target_instance)
            
            if (mirror_candidate.subjectType == mirror_target.subjectType) {
                let mapping = map as! Map<T, U>
                return mapping.map!(source)
            }
        }
        return nil
    }
    
    private init() {
        self.mappings = Array<AnyObject>()
    }
    
    class var sharedInstance: Mapper {
        struct Static {
            static var instance: Mapper?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Mapper()
        }
        
        return Static.instance!
    }
}

class Map<T, U> {
    private (set) var map:(T -> U)?
    private (set) var mapInstances:((T, U) -> Void)?
    init(map:(T) -> U){
        self.map = map
    }
    
    init() {
        
    }
}