
# PVZHeroes for Swift

## Usage

```swift
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
        
        Faction(.plants)
        Kind(.fighter)
        
        Class(.guardian)
        Banner(.premiumUncommon)
        
        Name("Beserker Wall-Nut")
        Description("""
        This attacks using its [h] instead of its [a].
        <b>When this does damage:</b> it gets [+1h].
        """)
        Flavor("He and Shieldcrusher Viking go way back.")
        
        Cost(4)
        Stats(0, 4)
        
        HealthAttack()
        
        UniqueAbilities {
            UniqueAbility(trigger: .onCardDidDamage) {
                Guard.TriggerTarget {
                    AllOf {
                        IsSelf()
                        IsAlive()
                        WillTriggerEffects()
                    }
                }
                
                Select.Self()
                ApplyBuff(0, 1)
            }
        }
    }
}

try MyMod().compile(to: .downloadsDirectory.appending(path: "pvzh1")) // does not encode to UAB
```

## Contributions

### Style Guide

* Prefer UI names to internal names (ex. prefer Strength to Attack).
