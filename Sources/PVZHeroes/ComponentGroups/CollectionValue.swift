//
//  CollectionValue.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/28/26.
//

import Foundation

extension ComponentGroups {
    public struct CollectionValue: ComponentGroup {
        public var collectionValue: PVZHeroes.CollectionValue
        
        public init(
            collectionValue: PVZHeroes.CollectionValue = .init(toCraft: 0, fromRecycling: 0),
        ) {
            self.collectionValue = collectionValue
        }
        
        public init(
            toCraft sparksToCraft: Int = 0,
            fromRecycling sparksFromRecycling: Int = 0,
        ) {
            self.init(
                collectionValue: .init(
                    toCraft: sparksToCraft,
                    fromRecycling: sparksFromRecycling
                )
            )
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { accumulating in
                accumulating.collectionValue = collectionValue
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias CollectionValue = ComponentGroups.CollectionValue
}

public struct CollectionValue: Sendable {
    public var sparksToCraft: Int
    public var sparksFromRecycling: Int
    
    public init(
        toCraft sparksToCraft: Int = 0,
        fromRecycling sparksFromRecycling: Int = 0,
    ) {
        self.sparksToCraft = sparksToCraft
        self.sparksFromRecycling = sparksFromRecycling
    }
}

extension CollectionValue {
    public static let common: Self = .init(toCraft: 25)
    public static let uncommon: Self = .init(toCraft: 50, fromRecycling: 15)
    public static let rare: Self = .init(toCraft: 250, fromRecycling: 50)
    public static let superRare: Self = .init(toCraft: 1000, fromRecycling: 250)
    public static let legendary: Self = .init(toCraft: 4000, fromRecycling: 1000)
    
    public static let event: Self = .init(toCraft: 1000, fromRecycling: 250)
    public static let token: Self = .init()
}
