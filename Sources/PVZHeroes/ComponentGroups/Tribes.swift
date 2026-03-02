//
//  Tribe.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension ComponentGroups {
    public struct Tribes: ComponentGroup {
        public var tribes: [Tribe]
        
        public init(_ tribes: Tribe...) {
            self.tribes = tribes
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Subtypes", [
                "subtypes": tribes.map(\.componentID),
            ])
            
            RawComponent { accumulating in
                accumulating.tribes = tribes
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Tribes = ComponentGroups.Tribes
}

public struct Tribe: Sendable {
    public var id: String
    public var componentID: Int
    
    public init(_ id: String, _ componentID: Int) {
        self.id = id
        self.componentID = componentID
    }
}

// NOTE: Thanks to PoplGrin
extension Tribe {
    public static let peashooter: Self = .init("Peashooter", 0)
    public static let berry: Self = .init("Berry", 1)
    public static let bean: Self = .init("Bean", 2)
    public static let flower: Self = .init("Flower", 3)
    public static let mushroom: Self = .init("Mushroom", 4)
    public static let nut: Self = .init("Nut", 5)
    public static let sports: Self = .init("Sports", 6)
    public static let science: Self = .init("Science", 7)
    public static let dancing: Self = .init("Dancing", 8)
    public static let imp: Self = .init("Imp", 9)
    public static let pet: Self = .init("Pet", 10)
    public static let gargantuar: Self = .init("Gargantuar", 11)
    public static let pirate: Self = .init("Pirate", 12)
    public static let pinecone: Self = .init("Pinecone", 13)
    public static let mustache: Self = .init("Mustache", 15)
    public static let party: Self = .init("Party", 16)
    public static let gourmet: Self = .init("Gourmet", 18)
    public static let history: Self = .init("History", 19)
    public static let barrel: Self = .init("Barrel", 20)
    public static let seed: Self = .init("Seed", 21)
    public static let animal: Self = .init("Animal", 22)
    public static let cactus: Self = .init("Cactus", 23)
    public static let corn: Self = .init("Corn", 24)
    public static let dragon: Self = .init("Dragon", 25)
    public static let flytrap: Self = .init("Flytrap", 26)
    public static let fruit: Self = .init("Fruit", 27)
    public static let leafy: Self = .init("Leafy", 28)
    public static let moss: Self = .init("Moss", 29)
    public static let root: Self = .init("Root", 31)
    public static let squash: Self = .init("Squash", 32)
    public static let tree: Self = .init("Tree", 33)
    public static let professional: Self = .init("Professional", 37)
    public static let monster: Self = .init("Monster", 39)
    public static let banana: Self = .init("Banana", 40)
    public static let mime: Self = .init("Mime", 41)
}
