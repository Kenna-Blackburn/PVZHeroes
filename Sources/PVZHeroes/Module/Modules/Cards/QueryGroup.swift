//
//  QueryGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/15/26.
//

import Foundation
import Helpers

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
