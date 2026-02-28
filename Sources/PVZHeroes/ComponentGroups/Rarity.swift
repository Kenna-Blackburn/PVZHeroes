//
//  Rarity.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct Rarity: ComponentGroup {
        public var rarity: PVZHeroes.Rarity
        
        public init(_ rarity: PVZHeroes.Rarity) {
            self.rarity = rarity
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Rarity", [
                "Value": rarity.componentID,
            ])
            
            RawComponent { resolved in
                resolved.rarity = rarity
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Rarity = ComponentGroups.Rarity
}

public struct Rarity: Sendable {
    public var id: Int
    public var componentID: String
    
    public init(_ id: Int, _ componentID: String) {
        self.id = id
        self.componentID = componentID
    }
}

extension Rarity {
    private static let commonOrToken: Self = .init(4, "R0")
    
    public static let common: Self = .commonOrToken
    public static let uncommon: Self = .init(0, "R1")
    public static let rare: Self = .init(1, "R2")
    public static let superRare: Self = .init(2, "R3")
    public static let legendary: Self = .init(3, "R4")
    
    public static let event: Self = .init(5, "Event")
    public static let token: Self = .commonOrToken
}
