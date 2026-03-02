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
                EvolutionaryLeap()
                KitchenSinkZombie()
                Peacock()
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
            
            Tribes(.nut)
            
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
                TriggeredAbility(.onCardDidDamage) {
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
                TriggeredAbility(.onRoundEnded) {
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
                            IsOfFaction(.zombies)
                            IsInPlay()
                        }
                    }
                    
                    DestroyTarget()
                }
                
                TriggeredAbility(.onCardDestroyed) {
                    Guard(.triggerTarget) {
                        AllOf {
                            WasDestroyedBy({ IsSelf() })
                            
                            IsOfFaction(.zombies)
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
                    
                    SummonCardInTargetLane(guid: 312)
                }
            }
        }
    }
    
    struct EvolutionaryLeap: Card {
        var components: [any ComponentGroup] {
            GUID(621)
            PrefabID("Evolutionary Leap")
            
            Faction(.zombies)
            Kind(.trick)
            RawComponent("Components.Surprise")
            
            Class(.brainy)
            Banner(.colossalSuperRare)
            
            Cost(2)
            
            UniqueAbilities {
                TriggeredAbility(.onSelfPlayed) {
                    RawEnginePiece("Components.TransformWithCreationSource", [
                        "SourceGuid": -1,
                    ])
                    
                    Select.Raw(selectionType: .manual) {
                        AllOf {
                            IsOfFaction(.zombies)
                            IsInPlay()
                        }
                    }
                    
                    RawEffect("Components.TransformIntoCardFromSubsetEffectDescriptor", [
                        "SubsetQuery": {
                            AllOf {
                                Not({ HasComponent("Components.Superpower") })
                                
                                IsOfFaction(.zombies)
                                IsFighter()
                                
                                RawQuery("Queries.SunCostPlusNComparisonQuery", [
                                    "ComparisonOperator": "Equal",
                                    "AdditionalCost": 1,
                                ])
                            }
                            .rawQuery
                        }()
                    ])
                }
                .groupID(0)
                
                TriggeredAbility(.onSelfPlayed) {
                    RawEnginePiece("Components.TransformWithCreationSource", [
                        "SourceGuid": -1,
                    ])
                    
                    Select.Raw(selectionType: .manual) {
                        IsHero(for: .zombies)
                    }
                    
                    DrawCard()
                }
                .groupID(0)
            }
        }
    }
    
    struct KitchenSinkZombie: Card {
        var components: [any ComponentGroup] {
            GUID(482)
            PrefabID("Kitchen Sink Zombie")
            
            Faction(.zombies)
            Kind(.fighter)
            
            Class(.brainy)
            Banner(.event)
            
            Tribes(.professional, .mustache)
            
            Name("Kitchen Sink Zombie")
            Description("[truestrike], [frenzy], [armored=1], [overshoot=2], [ambush=3]")
            Flavor("He's got everything but the- no wait, he's got that too.")
            
            Cost(6)
            Stats(3, 6)
            
            Bullseye()
            Frenzy()
            Armored()
            
            UniqueAbilities {
                ContinuousAbility {
                    Guard(.`self`) {
                        AllOf {
                            IsAlive()
                            WillTriggerAbilities()
                            RawQuery("Queries.InUnopposedLaneQuery")
                        }
                    }
                    
                    MarkEffectAsContinuous()
                    
                    Select.Self()
                    BuffTarget(3, 0)
                }
            }
        }
    }
    
    // https://www.reddit.com/r/PvZHeroes/comments/1rhmh3z/plant_card_idea_peacock/
    struct Peacock: Card {
        var components: [any ComponentGroup] {
            GUID(10)
            PrefabID("43d3b20a-90b4-4a34-8d55-674b02a38dc1")
            
            Faction(.plants)
            Kind(.fighter)
            
            Class(.megaGrow)
            Banner(.premiumLegendary)
            
            Cost(3)
            Stats(3, 4)
            
            UniqueAbilities {
                TriggeredAbility(.onSelfPlayed) {
                    Guard(.`self`) {
                        AllOf {
                            IsFighter()
                            
                            AnyOf {
                                WillTriggerAbilities()
                                WillTriggerOnCardDestroyedAbilities()
                            }
                        }
                    }
                    
                    RawEnginePiece("Components.QueryEntityCondition", [
                        "Finder": {
                            AllOf {
                                IsInPlay()
                                IsOfFaction(.plants)
                                
                                RawQuery("Queries.SubtypeQuery", [
                                    "Subtype": 0
                                ])
                            }
                            .rawQuery
                        }(),
                        "ConditionEvaluationType": "Any",
                        "Query": {
                            RawQuery("Queries.InAdjacentLaneQuery", [
                                "Side": "Either",
                            ])
                            .rawQuery
                        }(),
                    ])
                    
                    Select.Raw(selectionType: .all) {
                        IsHero(for: .plants)
                    }
                    
                    RawEffect("Components.DrawCardFromSubsetEffectDescriptor", [
                        "DrawAmount": 1,
                        "SubsetQuery": {
                            AllOf {
                                HasComponent("Components.Superpower")
                                IsOfFaction(.plants)
                            }
                            .rawQuery
                        }(),
                    ])
                }
            }
        }
    }
    
    try MyMod().compile(to: .downloadsDirectory.appending(path: "pvzh1"))
}
