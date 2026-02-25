//
//  FilterGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation
import Helpers

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
    public enum Guard {}
}

extension EnginePieceGroup {
    public typealias Guard = FilterGroups.Guard
}
