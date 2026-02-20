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
            Folder("files") {
                Folder("cards") {
                    Folder("card_data_1") {
                        File("cards.json") {
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
                            
                            let data = try! JSONEncoder().encode(AnyEncodable(contents))
                            
                            return data
                        }
                    }
                }
            }
        }
    }
}
