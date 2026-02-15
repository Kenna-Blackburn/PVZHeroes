//
//  ComponentGroups+_Unsorted.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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

//  extension ComponentGroup {
//      public typealias Stats = ComponentGroups.Stats
//  }
//
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
