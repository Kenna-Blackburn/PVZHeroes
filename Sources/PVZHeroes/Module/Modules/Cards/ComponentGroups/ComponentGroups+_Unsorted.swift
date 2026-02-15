//
//  ComponentGroups+_Unsorted.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation
import Helpers

public struct Counters: Encodable {
    public var isPersistent: Bool
    public var counters: [Counter]
    
    public init(
        isPersistent: Bool = true,
        counters: [Counter] = [.init()],
    ) {
        self.isPersistent = isPersistent
        self.counters = counters
    }
    
    private enum CodingKeys: String, CodingKey {
        case isPersistent = "IsPersistent"
        case counters = "Counters"
    }
    
    public struct Counter: Encodable {
        public var sourceID: Int
        public var value: Int
        public var duration: Int
        
        public init(
            sourceID: Int = -1,
            value: Int = 0,
            duration: Int = 0,
        ) {
            self.sourceID = sourceID
            self.value = value
            self.duration = duration
        }
        
        private enum CodingKeys: String, CodingKey {
            case sourceID = "SourceId"
            case value = "Value"
            case duration = "Duration"
        }
    }
}

// MARK: GUID
extension ComponentGroups {
    public struct GUID: ComponentGroup {
        public var guid: Int
        
        public init(_ guid: Int) {
            self.guid = guid
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Card", [
                "Guid": guid,
            ])
            
            RawComponent { resolved in
                resolved.guid = guid
            }
        }
    }
}

extension ComponentGroup {
    public typealias GUID = ComponentGroups.GUID
}

// MARK: PrefabID
extension ComponentGroups {
    public struct PrefabID: ComponentGroup {
        public var prefabID: String
        
        public init(_ prefabID: String) {
            self.prefabID = prefabID
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { resolved in
                resolved.prefabID = prefabID
            }
        }
    }
}

extension ComponentGroup {
    public typealias PrefabID = ComponentGroups.PrefabID
}

// MARK: Cost
extension ComponentGroups {
    public struct Cost: ComponentGroup {
        public var cost: Int
        
        public init(_ cost: Int) {
            self.cost = cost
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.SunCost", [
                "SunCostValue": [
                    "BaseValue": cost,
                ],
            ])
            
            RawComponent { resolved in
                resolved.cost = cost
            }
        }
    }
}

extension ComponentGroup {
    public typealias Cost = ComponentGroups.Cost
}

// MARK: Strength
extension ComponentGroups {
    public struct Strength: ComponentGroup {
        public var strength: Int
        
        public init(_ strength: Int) {
            self.strength = strength
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Attack", [
                "AttackValue": [
                    "BaseValue": strength,
                ],
            ])
            
            RawComponent { resolved in
                resolved.strength = strength
            }
        }
    }
}

extension ComponentGroup {
    public typealias Strength = ComponentGroups.Strength
}

// MARK: Health
extension ComponentGroups {
    public struct Health: ComponentGroup {
        public var health: Int
        
        public init(_ health: Int) {
            self.health = health
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Health", [
                "HealthValue": [
                    "BaseValue": health,
                ],
                "CurrentDamage": 0,
            ])
            
            RawComponent { resolved in
                resolved.health = health
            }
        }
    }
}

extension ComponentGroup {
    public typealias Health = ComponentGroups.Health
}


// MARK: Stats
extension ComponentGroups {
    public struct Stats: ComponentGroup {
        public var strength: Int
        public var health: Int
        
        public init(_ strength: Int, _ health: Int) {
            self.strength = strength
            self.health = health
        }
        
        public var components: [any ComponentGroup] {
            Strength(strength)
            Health(health)
        }
    }
}

extension ComponentGroup {
    public typealias Stats = ComponentGroups.Stats
}

// MARK: HealthAttack
extension ComponentGroups {
    public struct HealthAttack: ComponentGroup {
        public var counters: Counters
        
        public init(counters: Counters = .init(counters: [.init(value: 2)])) {
            self.counters = counters
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.AttackOverride", [
                "Counters": counters,
            ])
        }
    }
}

extension ComponentGroup {
    public typealias HealthAttack = ComponentGroups.HealthAttack
}

// MARK: UniqueAbilities
extension ComponentGroups {
    public struct UniqueAbilities: ComponentGroup {
        public var children: [any Trigger]
        
        public init(children: [any Trigger]) {
            self.children = children
        }
        
        public init(
            @ArrayBuilder<any Trigger> _ children: () -> [any Trigger],
        ) {
            self.init(children: children())
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.EffectEntitiesDescriptor", [
                "entities": children.enumerated().map { (i, child) in
                    let components = AnyEnginePieceGroup {
                        RawComponent("Components.EffectEntityGrouping", [
                            "AbilityGroupId": i,
                        ])
                        
                        child
                    }
                    
                    var resolved = Card.Resolved()
                    components.compile(into: &resolved)
                    
                    return [
                        "components": resolved.components,
                    ]
                }
            ])
        }
    }
}

extension ComponentGroup {
    public typealias UniqueAbilities = ComponentGroups.UniqueAbilities
}

public protocol Trigger: ComponentGroup {
    
}

public typealias RawTrigger = RawEnginePiece

public enum Triggers {
    
}

extension Triggers {
    public struct OnPlay: Trigger {
        public var effect: [any ComponentGroup]
        
        public init(
            @ArrayBuilder<any ComponentGroup> _ effect: () -> [any ComponentGroup]
        ) {
            self.effect = effect()
        }
        
        public var components: [any ComponentGroup] {
            RawTrigger("Components.PlayTrigger")
            
            effect
        }
    }
}

extension Card {
    public typealias OnPlay = Triggers.OnPlay
}

// MARK: ApplyBuff
extension ComponentGroups {
    public struct ApplyBuff: ComponentGroup {
        public var strength: Int
        public var health: Int
        public var duration: Duration
        
        public init(_ strength: Int, _ health: Int, duration: Duration = .indefinite) {
            self.strength = strength
            self.health = health
            self.duration = duration
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.BuffEffectDescriptor", [
                "AttackAmount": strength,
                "HealthAmount": health,
                "Duration": duration,
            ])
        }
        
        public enum Duration: String, Encodable {
            case indefinite = "Permanent"
            case untilEndOfTurn = "EndOfTurn"
        }
    }
}

extension ComponentGroup {
    public typealias ApplyBuff = ComponentGroups.ApplyBuff
}

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }

//  // MARK: <#ComponentGroup#>
//  extension ComponentGroups {
//      public struct <#ComponentGroup#>: ComponentGroup {
//          <#data#>
//
//          public var components: [any ComponentGroup] {
//              RawComponent("Components.<#ID#>", [
//                  <#data#>
//              ])
//          }
//      }
//  }
//
//  extension ComponentGroup {
//      public typealias <#ComponentGroup#> = ComponentGroups.<#ComponentGroup#>
//  }
