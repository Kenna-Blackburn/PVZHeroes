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
                WitchHazel()
            }
        }
    }
    
    struct BeserkerWallNut: Card {
        var components: [any ComponentGroup] {
            GUID(646)
            PrefabID("Primal Wall-Nut")
            
            Faction(.plants)
            Kind(.fighter)
            
            Class(.guardian)
            Banner(.premiumUncommon)
            
            Name("Beserker Wall-Nut")
            Description("""
            This attacks using its [h] instead of its [a].
            <b>When this does damage:</b> it gets [+1h].
            """)
            Flavor("He insists Shieldcrusher Viking is his only worthy rival.")
            
            Cost(4)
            Stats(0, 4)
            
            HealthAttack()
            
            UniqueAbilities {
                UniqueAbility(trigger: .onCardDidDamage) {
                    Guard(.triggerTarget) {
                        AllOf {
                            IsSelf()
                            IsAlive()
                            WillTriggerAbilities()
                        }
                    }
                    
                    Select.Self()
                    BuffTarget(0, 1)
                }
            }
        }
    }
    
    struct WitchHazel: Card {
        var components: [any ComponentGroup] {
            GUID(638)
            PrefabID("Witch Hazel")
            
            Faction(.plants)
            Kind(.fighter)
            
            Class(.smarty)
            Banner(.event)
            
            Name("Witch Hazel")
            Description("""
            <b>End of turn:</b> Destroy a random Zombie and make a [1a]/[1h] Puff-Shroom with [teamup] there.
            """)
            Flavor("Zombies are always trying to build a bridge out of her.")
            
            Cost(4)
            Stats(0, 3)
            
            UniqueAbilities {
                UniqueAbility(trigger: .onRoundEnded) {
                    Guard(.`self`) {
                        AllOf {
                            IsFighter()
                            
                            AnyOf {
                                WillTriggerAbilities()
                                WillTriggerOnCardDestroyedAbilities()
                            }
                        }
                    }
                    
                    Select.Raw(selectionType: .random, maxTargets: 1) {
                        AllOf {
                            HasComponent("Components.Zombie")
                            IsInPlay()
                        }
                    }
                    
                    DestroyTarget()
                }
                
                UniqueAbility(trigger: .onCardDestroyed) {
                    Guard(.triggerTarget) {
                        AllOf {
                            WasDestroyedBy({ IsSelf() })
                            
                            HasComponent("Components.Zombie")
                            IsFighter()
                            
                            AnyOf {
                                WillTriggerAbilities()
                                WillTriggerOnCardDestroyedAbilities()
                            }
                        }
                    }
                    
                    Guard(.`self`) {
                        AllOf {
                            IsFighter()
                            
                            AnyOf {
                                WillTriggerAbilities()
                                WillTriggerOnCardDestroyedAbilities()
                            }
                        }
                    }
                    
                    Select.Raw(selectionType: .all) {
                        RawQuery("Queries.SameLaneAsTargetQuery")
                    }
                    
                    SummonCardInTargetLane(312)
                }
            }
        }
    }
    
    try MyMod().compile(to: .downloadsDirectory.appending(path: "pvzh1"))
}
