//
//  Modules+Cards.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation
import Helpers

extension Modules {
    public struct Cards: Module {
        public var cards: [any Card]
        
        public init(cards: [any Card]) {
            self.cards = cards
        }
        
        public init(@ArrayBuilder<any Card> _ cards: () -> [any Card]) {
            self.init(cards: cards())
        }
        
        public func compile(into cache: CompilationCache) {
            cache[CompilationCache.Keys.Cards.self] = cards.map({ $0.resolve() })
        }
    }
}

extension Mod {
    public typealias Cards = Modules.Cards
}
