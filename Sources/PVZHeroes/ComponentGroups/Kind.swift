//
//  Kind.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/25/26.
//

import Foundation

extension ComponentGroups {
    public struct Kind: ComponentGroup {
        public var kind: PVZHeroes.Kind
        
        public init(_ kind: PVZHeroes.Kind) {
            self.kind = kind
        }
        
        public var components: [any ComponentGroup] {
            switch kind {
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
                RawComponent("Components.Environment")
            }
            
            RawComponent { resolved in
                resolved.kind = kind
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Kind = ComponentGroups.Kind
}

public enum Kind: Sendable {
    case fighter
    case trick(TrickKind?)
    case environment
    
    public enum TrickKind: Sendable {
        case isSuperpower
        case isSignatureSuperpower
    }
}

extension Kind {
    public static let trick: Self = .trick(nil)
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
