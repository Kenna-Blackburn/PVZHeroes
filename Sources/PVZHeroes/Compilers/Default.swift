//
//  Default.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation
import Helpers

extension Compilers {
    public final class Default: CacheCompiler {
        public init() {}
        
        public func compile(_ cache: CompilationCache) throws -> any FileWrapperConvertible {
            try Folder("files") {
                try Folder("cards") {
                    // TODO: take in or fetch index
                    try Folder("card_data_1") {
                        try File("cards.json", data: { try compileCardsJSON(in: cache) })
                    }
                }
                
                try Folder("loc") {
                    // TODO: take in or fetch index
                    try File("en_11", data: { try compileLocalizations(in: cache) })
                }
            }
        }
    }
}

extension Compilers.Default {
    public func compileCardsJSON(in cache: CompilationCache) throws -> Data {
        guard let cards = cache[CompilationCache.Keys.Cards.self] else {
            return Data()
        }
        
        var contents = [String: Any]()
        
        for card in cards {
            contents[String(card.guid)] = [
                "prefabName": card.prefabID,
                "displaySunCost": card.cost,
                "displayAttack": card.strength,
                "displayHealth": card.health,
                
                "faction": card.faction.id,
                
                "baseId": card.kind.baseID(for: card.faction),
                "isFighter": card.kind == .fighter,
                "isEnv": card.kind == .environment,
                "isPower": [.trick(.isSuperpower), .trick(.isSignatureSuperpower)].contains(card.kind),
                "isPrimaryPower": card.kind == .trick(.isSignatureSuperpower),
                
                "color": card.class.id,
                
                "set": card.set.id,
                "rarity": card.rarity.id,
                "setAndRarityKey": card.banner.id,
                
                "craftingBuy": card.collectionValue.sparksToCraft,
                "craftingSell": card.collectionValue.sparksFromRecycling,
                
                "entity": [
                    "components": card.components,
                ],
            ]
        }
        
        let data = try JSONEncoder().encode(AnyEncodable(contents))
        
        return data
    }
}

extension Compilers.Default {
    public func compileLocalizations(in cache: CompilationCache) throws -> Data {
        var locTable = [String: String]()
        
        if let cards = cache[CompilationCache.Keys.Cards.self] {
            for card in cards {
                locTable["\(card.prefabID)_name"] = card.name
                locTable["\(card.prefabID)_longDesc"] = card.description
                locTable["\(card.prefabID)_shortDesc"] = card.summary
                locTable["\(card.prefabID)_flavorText"] = card.flavor
            }
        }
        
        let content = locTable
            .map { (key, value) in
                var value = value
                
                if value.contains(",") || value.contains("\"") {
                    value.replace("\"", with: "\"\"")
                    value.replace("\n", with: "\\n")
                    value = "\"\(value)\""
                }
                
                return "\(key),\(value)"
            }
            .joined(separator: "\n")
        
        guard let data = content.data(using: .utf8) else {
            fatalError("// TODO: throw")
        }
        
        return data
    }
}
