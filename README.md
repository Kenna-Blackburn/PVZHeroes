
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
        
        Name("Beserker Wall-Nut") // not implemented
        Description("""
        This attacks using its [h] instead of its [a].
        <b>When this does damage:</b> it gets [+1h].
        """) // not implemented
        
        Cost(4)
        Stats(0, 4)
        
        HealthAttack()
        
        UniqueAbilities {
            UniqueAbility(trigger: .onCardPlayed) {
                Guard.TriggerTarget {
                    IsSelf()
                }
                
                SelectSelf() // not implemented
                
                ApplyBuff(0, 1)
            }
        }
    }
}

try MyMod().compile(to: .downloadsDirectory.appending(path: "pvzh1")) // partially implemented
```

## Contributions

### Style Guide

* Prefer UI names over internal names (ex. prefer Strength over Attack).
* Prefer to unwrap closures at usage over init (ie. prefer `var foo: () -> T` over `var foo: T`) (TODO)
