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
                    try Folder("card_data_1") {
                        try File("cards.json") {
                            guard let cards = cache[CompilationCache.Keys.Cards.self] else {
                                return Data()
                            }
                            
                            var contents = [String: Any]()
                            
                            for card in cards {
                                contents[String(card.guid)] = [
                                    "prefabName": card.prefabID,
                                    "entity": [
                                        "components": card.components,
                                    ],
                                    "displaySunCost": card.cost,
                                    "displayAttack": card.strength,
                                    "displayHealth": card.health,
                                ]
                            }
                            
                            let data = try JSONEncoder().encode(AnyEncodable(contents))
                            
                            return data
                        }
                    }
                }
                
                try Folder("loc") {
                    try File("en_11") { // TODO: take in or fetch index
                        var locTable = [String: String]()
                        
                        for card in cache[CompilationCache.Keys.Cards.self] ?? [] {
                            locTable["\(card.prefabID)_name"] = card.name
                            locTable["\(card.prefabID)_longDesc"] = card.description
                            locTable["\(card.prefabID)_shortDesc"] = card.summary
                            locTable["\(card.prefabID)_flavorText"] = card.flavor
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
                            throw EncodingError.invalidValue(content, .init(codingPath: [], debugDescription: "Failed to encode content"))
                        }
                        
                        return data
                    }
                }
            }
        }
    }
}
