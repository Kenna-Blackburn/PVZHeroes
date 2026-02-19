
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
                Guard.TriggerTarget(IsSelf())
                
                ApplyBuff(0, 1)
            }
        }
    }
}

try MyMod().compile(to: .downloadsDirectory.appending(path: "pvzh1")) // partially implemented
```

## Contributions

### Style Guide

* Prefer UI names to internal names (ex. prefer Strength to Attack).
