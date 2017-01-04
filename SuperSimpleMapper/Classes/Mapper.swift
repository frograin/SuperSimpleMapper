//
//  Mapper.swift
//  Pods
//
//  Created by Frograin on 04/01/2017.
//
//

import Foundation

public class Mapper {
    var mappings:Array<AnyObject>
    
    public class func createMap<T, U>(map: @escaping (T) -> U) {
        let mapper:Mapper = Mapper.sharedInstance
        let newMap = Map<T, U>(map: map)
        mapper.mappings.append(newMap)
    }
    
    public class func map<T, U>(source: T) -> U? {
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
    
    private static var sharedInstance: Mapper = Mapper()
    
    private init() {
        self.mappings = Array<AnyObject>()
    }
}

fileprivate class Map<T, U> {
    private (set) var map: ((T) -> U)?
    private (set) var mapInstances:((T, U) -> Void)?
    init(map: @escaping (T) -> U){
        self.map = map
    }
    
    init() {
        
    }
}
