//
//  ComponentGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/15/26.
//

import Foundation
import Helpers

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
