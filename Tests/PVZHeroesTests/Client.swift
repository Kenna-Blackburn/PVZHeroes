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
                    {
                        "$type":
                            "PvZCards.Engine.Components.TriggerTargetFilter, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                        "$data": {
                            "Query": {
                                "$type":
                                    "PvZCards.Engine.Queries.CompositeAllQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                "$data": {
                                    "queries": [
                                        {
                                            "$type":
                                                "PvZCards.Engine.Queries.SelfQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                            "$data": {}
                                        },
                                        {
                                            "$type":
                                                "PvZCards.Engine.Queries.FighterQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                            "$data": {}
                                        },
                                        {
                                            "$type":
                                                "PvZCards.Engine.Queries.CompositeAnyQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                            "$data": {
                                                "queries": [
                                                    {
                                                        "$type":
                                                            "PvZCards.Engine.Queries.WillTriggerEffectsQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                                        "$data":
                                                            {}
                                                    },
                                                    {
                                                        "$type":
                                                            "PvZCards.Engine.Queries.WillTriggerOnDeathEffectsQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                                        "$data":
                                                            {}
                                                    }
                                                ]
                                            }
                                        }
                                    ]
                                }
                            }
                        }
                    }
                    RawEnginePiece("Components.TriggerTargetFilter", [
                        "Query": RawQuery
                    ])
                    {
                        "$type":
                            "PvZCards.Engine.Components.PrimaryTargetFilter, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                        "$data": {
                            "SelectionType": "All",
                            "NumTargets": 0,
                            "TargetScopeType": "All",
                            "TargetScopeSortValue": "None",
                            "TargetScopeSortMethod": "None",
                            "AdditionalTargetType": "None",
                            "AdditionalTargetQuery": null,
                            "OnlyApplyEffectsOnAdditionalTargets":
                                false,
                            "Query": {
                                "$type":
                                    "PvZCards.Engine.Queries.CompositeAllQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                "$data": {
                                    "queries": [
                                        {
                                            "$type":
                                                "PvZCards.Engine.Queries.HasComponentQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                            "$data": {
                                                "ComponentType":
                                                    "PvZCards.Engine.Components.Plants, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
                                            }
                                        },
                                        {
                                            "$type":
                                                "PvZCards.Engine.Queries.HasComponentQuery, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                                            "$data": {
                                                "ComponentType":
                                                    "PvZCards.Engine.Components.Player, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
                                            }
                                        }
                                    ]
                                }
                            }
                        }
                    }
                    {
                        "$type":
                            "PvZCards.Engine.Components.DamageEffectDescriptor, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
                        "$data": {
                            "DamageAmount": 2
                        }
                    }
                }
            }
        }
    }

    try DebugMod1().compile(to: .downloadsDirectory.appending(path: "pvzh1"))
}
