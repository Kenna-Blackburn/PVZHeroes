//
//  UniqueAbilities.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation
import Helpers

extension ComponentGroups {
    public struct UniqueAbilities: ComponentGroup {
        public var abilities: () -> [any UniqueAbility]
        
        public init(
            @ArrayBuilder<any UniqueAbility> abilities: @escaping () -> [any UniqueAbility]
        ) {
            self.abilities = abilities
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.EffectEntitiesDescriptor", [
                "entities": {
                    var nextFreeGroupID = 0
                    return abilities()
                        .map { ability in
                            [
                                "components": {
                                    switch ability {
                                    case var copy as TriggeredAbility:
                                        if let groupID = copy.groupID {
                                            nextFreeGroupID = groupID + 1
                                        } else {
                                            copy.groupID = nextFreeGroupID
                                            nextFreeGroupID += 1
                                        }
                                        
                                        return copy.compile()
                                    default:
                                        return ability.compile()
                                    }
                                }()
                            ]
                        }
                }()
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias UniqueAbilities = ComponentGroups.UniqueAbilities
}

extension ComponentGroups.UniqueAbilities {
    public protocol UniqueAbility: EnginePieceGroup {
        
    }
}

extension ComponentGroups.UniqueAbilities {
    public struct TriggeredAbility: UniqueAbility {
        public var groupID: Int?
        public var trigger: Trigger
        public var pieces: () -> [any EnginePieceGroup] // TODO: strengthen typing?
        
        public init(
            _ trigger: Trigger,
            groupID: Int? = nil,
            @ArrayBuilder<any EnginePieceGroup> _ pieces: @escaping () -> [any EnginePieceGroup],
        ) {
            self.trigger = trigger
            self.pieces = pieces
        }
        
        public func compile() -> [RawEnginePiece] {
            AnyEnginePieceGroup(pieces: {
                if let groupID {
                    RawEnginePiece("Components.EffectEntityGrouping", [
                        "AbilityGroupId": groupID,
                    ])
                }
                
                RawEnginePiece("Components.\(trigger.id)")
                trigger.filter?().compile()
                
                pieces().flatMap({ $0.compile() })
            })
            .compile()
        }
    }
}

extension ComponentGroups.UniqueAbilities.TriggeredAbility {
    public func groupID(_ groupID: Int?) -> Self {
        var copy = self
        copy.groupID = groupID
        return copy
    }
}

extension EnginePieceGroup {
    public typealias TriggeredAbility = ComponentGroups.UniqueAbilities.TriggeredAbility
}

extension ComponentGroups.UniqueAbilities {
    public struct ContinuousAbility: UniqueAbility {
        public var pieces: () -> [any EnginePieceGroup] // TODO: strengthen typing?
        
        public init(
            @ArrayBuilder<any EnginePieceGroup> _ pieces: @escaping () -> [any EnginePieceGroup],
        ) {
            self.pieces = pieces
        }
        
        public func compile() -> [RawEnginePiece] {
            AnyEnginePieceGroup(pieces: pieces)
                .compile()
        }
    }
}

extension EnginePieceGroup {
    public typealias ContinuousAbility = ComponentGroups.UniqueAbilities.ContinuousAbility
}

extension ComponentGroups.UniqueAbilities {
    public struct Trigger: Sendable {
        public var id: String
        public var filter: (@Sendable () -> any FilterGroup)?
        
        public init(_ id: String, filter: (@Sendable () -> any FilterGroup)? = nil) {
            self.id = id
            self.filter = filter
        }
    }
}

extension ComponentGroups.UniqueAbilities.Trigger {
    public func filter(_ filter: @escaping @Sendable () -> any FilterGroup) -> Self {
        var copy = self
        copy.filter = filter
        return copy
    }
}

extension ComponentGroups.UniqueAbilities.Trigger {
    public static let onRoundStarted: Self = .init("TurnStartTrigger")
    public static let onTricksStarted: Self = .init("SurprisePhaseStartTrigger")
    public static let onCombatStartedHere: Self = .init("LaneCombatStartTrigger")
    public static let onCombatEndedHere: Self = .init("LaneCombatEndTrigger")
    public static let onRoundEnded: Self = .init("CombatEndTrigger")
    
    public static let onHeroDrewCard: Self = .init("DrawCardTrigger")
    public static let onHeroConjuredCard: Self = .init("DrawCardFromSubsetTrigger")
    
    public static let onCardPlayed: Self = .init("PlayTrigger")
    public static let onCardRevealed: Self = .init("RevealTrigger")
    public static let onCardEnteredBoard: Self = .init("EnterBoardTrigger")
    public static let onCardBounced: Self = .init("ReturnToHandTrigger")
    
    public static let onCardDidDamage: Self = .init("DamageTrigger")
    public static let onCardDidDestroy: Self = .init("DestroyCardTrigger")
    public static let onCardDidBonusAttack: Self = .init("ExtraAttackTrigger")
    
    public static let onCardHealed: Self = .init("HealTrigger")
    public static let onCardFrozen: Self = .init("SlowedTrigger")
    public static let onCardDestroyed: Self = .init("DiscardFromPlayTrigger")
    public static let onCardBuffed: Self = .init("BuffTrigger")
    public static let onCardMoved: Self = .init("MoveTrigger")
}

extension ComponentGroups.UniqueAbilities.Trigger {
    public static let onSelfPlayed: Self = .onCardPlayed.filter {
        FilterGroups.Guard(.triggerTarget) {
            Queries.IsSelf()
        }
    }
}
