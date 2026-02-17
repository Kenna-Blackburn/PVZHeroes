//
//  EnginePieceGroups+_Unsorted.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/16/26.
//

import Foundation
import Helpers

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
public protocol Query: EnginePieceGroup {
    associatedtype ChildQuery: Query
    
    var query: ChildQuery { get }
}

extension Query {
    public func compile() -> [RawEnginePiece] {
        query.compile()
    }
}

public typealias RawQuery = RawEnginePiece

extension RawQuery: Query {
    public var query: some Query {
        fatalError()
    }
}

public enum Querys {
    
}

extension Never: Query {
    public var query: some Query {
        fatalError()
    }
}

// MARK: Effect
public protocol Effect: EnginePieceGroup {
    associatedtype ChildEffect: Effect
    
    var effect: ChildEffect { get }
}

extension Effect {
    public func compile() -> [RawEnginePiece] {
        effect.compile()
    }
}

public typealias RawEffect = RawEnginePiece

extension RawEffect: Effect {
    public var effect: some Effect {
        fatalError()
    }
}

public enum Effects {
    
}

extension Never: Effect {
    public var effect: some Effect {
        fatalError()
    }
}
