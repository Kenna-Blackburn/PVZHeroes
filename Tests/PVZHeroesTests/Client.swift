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
    struct MyMod: Mod {
        var modules: [any Module] {
            Cards {
                BeserkerWallNut()
            }
        }
    }
    
    struct BeserkerWallNut: Card {
        var components: [any ComponentGroup] {
            GUID(646)
            PrefabID("Primal Wall-Nut")
            
            //Name("Beserker Wall-Nut")
            //Description("""
            //This attacks using its [h] instead of its [a].
            //<b>When this does damage:</b> it gets [+1h].
            //""") // TODO: add custom String interpolation (ie. "...\(.health)...")?
            
            Cost(4)
            Stats(0, 4)
            
            HealthAttack()
            
            UniqueAbilities {
                UniqueAbility(trigger: .onCardDidDamage) {
                    Guard.TriggerTarget {
                        IsSelf()
                    }
                    
                    //SelectSelf()
                    
                    ApplyBuff(0, 1)
                }
            }
        }
    }
    
    try MyMod().compile(to: .downloadsDirectory.appending(path: "pvzh1"))
}
