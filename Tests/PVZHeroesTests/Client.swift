//
//  Client.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/13/26.
//

import Foundation
import Testing
@testable import PVZHeroes

@Test("Client")
func client() async throws {
    struct DebugMod1: Mod {
        var modules: [any Module] {
            Cards {
                DebugCard1()
            }
        }
    }

    struct DebugCard1: Card {
        var components: [any ComponentGroup] {
            GUID(42)
            PrefabID("E621E1F8-C36C-495A-93FC-0C247A3E6E5F")
            
            //Name("Debug Card 1")
            //Description("This attacks using its [h] instead of its [a].") // TODO: add custom String interpolation? "...\(.health)..."
            
            Cost(1)
            Stats(0, 3)
            
            HealthAttack()
            
            UniqueAbilities {
                UniqueAbility(trigger: .onPlay) {
                    // TODO: this
                }
            }
        }
    }

    try DebugMod1().compile(to: .downloadsDirectory.appending(path: "pvzh1"))
}
