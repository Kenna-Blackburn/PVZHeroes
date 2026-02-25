//
//  ComponentGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation
import Helpers

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
    public enum Select {}
}

extension EnginePieceGroup {
    public typealias Select = ComponentGroups.Select
}
