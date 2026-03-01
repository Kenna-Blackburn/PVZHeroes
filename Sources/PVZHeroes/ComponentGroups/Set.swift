//
//  Set.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct Set: ComponentGroup {
        public var set: PVZHeroes.Set
        
        public init(_ set: PVZHeroes.Set) {
            self.set = set
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { accumulating in
                accumulating.set = set
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Set = ComponentGroups.Set
}

public struct Set: Sendable {
    public var id: String
    
    public init(_ id: String) {
        self.id = id
    }
}

extension Set {
    public static let superpower: Self = .init("Superpower")
    public static let signatureSuperpower: Self = .init("Hero")
    public static let deprecatedSuperpower: Self = .init("")
    
    public static let token: Self = .init("Token")
    public static let event: Self = .init("Event")
    
    public static let basic: Self = .init("Silver")
    public static let premium: Self = .init("Gold")
    public static let galacticGardens: Self = .init("Set2")
    public static let colossalFossils: Self = .init("Set3")
    public static let triassicTriumph: Self = .init("Set4")
    
    public static let blank: Self = .init("Blank")
    public static let cheats: Self = .init("Cheats")
    public static let boardAbility: Self = .init("Board")
}
