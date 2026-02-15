
#  PVZHeroes for Swift

```swift
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
        
        Name("Debug Card 1") // not implemented
        Description("This attacks using its [h] instead of its [a].") // not implemented
        
        Cost(1)
        Stats(0, 3)
        
        HealthAttack()
    }
}
```
