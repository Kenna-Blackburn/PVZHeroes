//
//  Kind.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/25/26.
//

import Foundation

public enum Kind: ComponentGroup, Sendable {
    case fighter
    case trick(TrickKind?)
    case environment
    
    public init(_ base: Self) {
        self = base
    }
    
    public var components: [any ComponentGroup] {
        switch self {
        case .fighter:
            EmptyComponentGroup()
        case .trick(let trickKind):
            RawComponent("Components.Burst")
            
            if trickKind == .isSuperpower || trickKind == .isSignatureSuperpower {
                RawComponent("Components.Superpower")
            }
            
            if trickKind == .isSignatureSuperpower {
                RawComponent("Components.PrimarySuperpower")
            }
        case .environment:
            EmptyComponentGroup()
        }
        
        RawComponent { resolved in
            resolved.kind = self
        }
    }
}

extension Kind {
    public static let trick: Self = .trick(nil)
}

extension Kind {
    public enum TrickKind: Sendable {
        case isSuperpower
        case isSignatureSuperpower
    }
}

extension ComponentGroups {
    public typealias Kind = PVZHeroes.Kind
}

extension EnginePieceGroup {
    public typealias Kind = ComponentGroups.Kind
}

extension Kind {
    public func baseID(for faction: Faction) -> String {
        switch faction {
        case .plants, .boardAbility:
            switch self {
            case .fighter:
                return "Base"
            case .trick:
                return "BasePlantOneTimeEffect"
            case .environment:
                return "BasePlantEnvironment"
            }
        case .zombies:
            switch self {
            case .fighter:
                return "BaseZombie"
            case .trick:
                return "BaseZombieOneTimeEffect"
            case .environment:
                return "BaseZombieEnvironmentbase"
            }
        }
    }
}
