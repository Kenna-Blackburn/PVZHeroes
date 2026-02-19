//
//  _Unsorted.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/13/26.
//

import Foundation
import Helpers

// TODO: sort all

// MARK: ComponentGroup
public protocol ComponentGroup: EnginePieceGroup {
    @ArrayBuilder<any ComponentGroup>
    var components: [any ComponentGroup] { get }
}

extension ComponentGroup {
    public func compile() -> [RawEnginePiece] {
        return components.flatMap({ $0.compile() })
    }
}

public typealias RawComponent = RawEnginePiece

extension RawComponent: ComponentGroup {
    public var components: [any ComponentGroup] {}
}

public enum ComponentGroups {
    
}

// MARK: Query
// TODO: replace with QueryGroup
public protocol Query: EnginePieceGroup {
    var query: RawQuery { get }
}

extension Query {
    public func compile() -> [RawEnginePiece] {
        query.compile()
    }
}

public typealias RawQuery = RawEnginePiece

extension RawQuery: Query {
    public var query: RawQuery {
        fatalError()
    }
}

public enum Queries {
    
}

extension Never: Query {
    public var query: RawQuery {
        fatalError()
    }
}

// MARK: Effect
public protocol Effect: EnginePieceGroup {
    var effect: RawEffect { get }
}

extension Effect {
    public func compile() -> [RawEnginePiece] {
        effect.compile()
    }
}

public typealias RawEffect = RawEnginePiece

extension RawEffect: Effect {
    public var effect: RawEffect {
        fatalError()
    }
}

public enum Effects {
    
}

extension Never: Effect {
    public var effect: RawEffect {
        fatalError()
    }
}

// MARK: FilterGroup
public protocol FilterGroup: EnginePieceGroup {
    @ArrayBuilder<any FilterGroup>
    var filters: [any FilterGroup] { get }
}

extension FilterGroup {
    public func compile() -> [RawEnginePiece] {
        return filters.flatMap({ $0.compile() })
    }
}

public typealias RawFilter = RawEnginePiece

extension RawFilter: FilterGroup {
    public var filters: [any FilterGroup] {}
}

public enum FilterGroups {
    
}

// MARK: Unsorted
extension FilterGroups {
    public enum Guard {
        
    }
}

extension EnginePieceGroup {
    public typealias Guard = FilterGroups.Guard
}

extension FilterGroups.Guard {
    public struct TriggerTarget: FilterGroup {
        public var query: any Query
        
        public init(_ query: any Query) {
            self.query = query
        }
        
        public var filters: [any FilterGroup] {
            RawFilter("Components.TriggerTargetFilter", [
                "Query": query.compile().first!,
            ])
        }
    }
}

extension FilterGroups.Guard {
    public struct TriggerSource: FilterGroup {
        public var query: any Query
        
        public init(_ query: any Query) {
            self.query = query
        }
        
        public var filters: [any FilterGroup] {
            RawFilter("Components.TriggerTargetFilter", [
                "Query": query.compile().first!,
            ])
        }
    }
}

extension Queries {
    public struct IsSelf: Query {
        public var query: RawQuery {
            RawQuery("Queries.SelfQuery")
        }
    }
}

extension EnginePieceGroup {
    public typealias IsSelf = Queries.IsSelf
}
