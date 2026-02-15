//
//  _Unsorted.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/13/26.
//

import Foundation
import Helpers

// MARK: ComponentGroup
public protocol ComponentGroup: EnginePieceGroup {
    @ArrayBuilder<any ComponentGroup>
    var components: [any ComponentGroup] { get }
}

extension ComponentGroup {
    public func compile(into resolved: inout Card.Resolved) {
        components.forEach({ $0.compile(into: &resolved) })
    }
}

public typealias RawComponent = RawEnginePiece

extension RawComponent: ComponentGroup {
    public var components: [any ComponentGroup] {}
}

public enum ComponentGroups {
    
}

// MARK: QueryGroup
public protocol QueryGroup: EnginePieceGroup {
    @ArrayBuilder<any QueryGroup>
    var queries: [any QueryGroup] { get }
}

extension QueryGroup {
    public func compile(into resolved: inout Card.Resolved) {
        queries.forEach({ $0.compile(into: &resolved) })
    }
}

public typealias RawQuery = RawEnginePiece

extension RawQuery: QueryGroup {
    public var queries: [any QueryGroup] {}
}

public enum QueryGroups {
    
}
