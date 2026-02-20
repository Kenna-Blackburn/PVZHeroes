//
//  CardData.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation
import Helpers

extension Aggregators {
    public struct CardData: Aggregator {
        public func aggregate(_ cache: CompilationCache, into root: FileWrapper) throws {
            guard let cards = cache[CompilationCache.Keys.Cards.self] else {
                return
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
            
            root.addFileWrapper({
                let child1 = FileWrapper(directoryWithFileWrappers: [:])
                child1.preferredFilename = "cards"
                child1.addFileWrapper({
                    let child2 = FileWrapper(directoryWithFileWrappers: [:])
                    child2.preferredFilename = "card_data_1"
                    child2.addRegularFile(withContents: data, preferredFilename: "cards.json")
                    
                    return child2
                }())
                
                return child1
            }())
        }
    }
}
