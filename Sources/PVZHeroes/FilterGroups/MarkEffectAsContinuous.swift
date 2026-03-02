//
//  MarkEffectAsContinuous.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension FilterGroups {
    public struct MarkEffectAsContinuous: FilterGroup {
        public var filters: [any FilterGroup] {
            RawFilter("Components.Continuous")
            RawFilter("Components.ActiveTargets")
        }
    }
}

extension EnginePieceGroup {
    public typealias MarkEffectAsContinuous = FilterGroups.MarkEffectAsContinuous
}
