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
    
    enum MappingException: Error {
        case NotFound, Failed, ResultNil
    }
    
    public func createMap<T, U>(map: @escaping (T) -> U) {
        let newMap = Map<T, U>(map: map)
        mappings.append(newMap)
    }
    
    public func map<T, U>(source: T) throws -> U {
        let target_instance = Map<T, U>()
        
        for map:AnyObject in mappings as Array<AnyObject> {
            let mirror_candidate = Mirror(reflecting: map)
            let mirror_target = Mirror(reflecting: target_instance)
            
            if (mirror_candidate.subjectType == mirror_target.subjectType) {
                guard let mapping = map as? Map<T, U> else {
                    throw MappingException.Failed
                }
                guard let result = mapping.map?(source) else {
                    throw MappingException.ResultNil
                }
                
                return result
            }
        }
        throw MappingException.NotFound
    }
    
    public init() {
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
