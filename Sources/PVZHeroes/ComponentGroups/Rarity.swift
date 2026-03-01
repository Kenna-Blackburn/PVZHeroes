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
            
            RawComponent { accumulating in
                accumulating.rarity = rarity
                
                if accumulating.collectionValue == nil {
                    accumulating.collectionValue = rarity.associatedCollectionValue
                }
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
    public var associatedCollectionValue: CollectionValue
    
    public init(
        _ id: Int,
        _ componentID: String,
        _ associatedCollectionValue: CollectionValue = .init(),
    ) {
        self.id = id
        self.componentID = componentID
        self.associatedCollectionValue = associatedCollectionValue
    }
}

extension Rarity {
    public static let common: Self = .init(4, "R0", .common)
    public static let uncommon: Self = .init(0, "R1", .uncommon)
    public static let rare: Self = .init(1, "R2", .rare)
    public static let superRare: Self = .init(2, "R3", .superRare)
    public static let legendary: Self = .init(3, "R4", .legendary)
    
    public static let event: Self = .init(5, "Event", .event)
    public static let token: Self = .init(4, "R0", .token)
}
