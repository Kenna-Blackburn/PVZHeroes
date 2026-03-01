//
//  Banner.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct Banner: ComponentGroup {
        public var banner: PVZHeroes.Banner
        
        public init(_ banner: PVZHeroes.Banner) {
            self.banner = banner
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { accumulating in
                accumulating.banner = banner
                
                if accumulating.set == nil {
                    Set(banner.associatedSet).compile(into: &accumulating)
                }
                
                if accumulating.rarity == nil {
                    Rarity(banner.associatedRarity).compile(into: &accumulating)
                }
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Banner = ComponentGroups.Banner
}

public struct Banner: Sendable {
    public var id: String
    
    public var associatedSet: Set
    public var associatedRarity: Rarity
    
    public init(_ id: String, _ associatedSet: Set, _ associatedRarity: Rarity) {
        self.id = id
        self.associatedSet = associatedSet
        self.associatedRarity = associatedRarity
    }
}

extension Banner {
    public static let basicCommon: Self = .init("Dawn_Common", .basic, .common)
    
    public static let premiumUncommon: Self = .init("Bloom_Common", .premium, .uncommon)
    public static let premiumRare: Self = .init("Bloom_Rare", .premium, .rare)
    public static let premiumSuperRare: Self = .init("Bloom_SuperRare", .premium, .superRare)
    public static let premiumLegendary: Self = .init("Bloom_Legendary", .premium, .legendary)
    
    public static let galacticUncommon: Self = .init("Galactic_Common", .galacticGardens, .uncommon)
    public static let galacticRare: Self = .init("Galactic_Rare", .galacticGardens, .rare)
    public static let galacticSuperRare: Self = .init("Galactic_SuperRare", .galacticGardens, .superRare)
    public static let galacticLegendary: Self = .init("Galactic_Legendary", .galacticGardens, .legendary)
    
    public static let colossalUncommon: Self = .init("Colossal_Common", .colossalFossils, .uncommon)
    public static let colossalRare: Self = .init("Colossal_Rare", .colossalFossils, .rare)
    public static let colossalSuperRare: Self = .init("Colossal_SuperRare", .colossalFossils, .superRare)
    public static let colossalLegendary: Self = .init("Colossal_Legendary", .colossalFossils, .legendary)
    
    public static let triassicUncommon: Self = .init("Triassic_Common", .triassicTriumph, .uncommon)
    public static let triassicRare: Self = .init("Triassic_Rare", .triassicTriumph, .rare)
    public static let triassicSuperRare: Self = .init("Triassic_SuperRare", .triassicTriumph, .superRare)
    public static let triassicLegendary: Self = .init("Triassic_Legendary", .triassicTriumph, .legendary)
    
    public static let superpower: Self = .init("Superpower_SuperRare", .premium, .superRare)
    public static let signatureSuperpower: Self = .premiumLegendary
    
    public static let event: Self = .init("Premium_Event", .premium, .event)
    public static let token: Self = .init("Token", .token, .token)
}
