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
        public var groups: () -> [UniqueAbilityGroup]
        
        public init(
            @ArrayBuilder<UniqueAbilityGroup> groups: @escaping () -> [UniqueAbilityGroup]
        ) {
            self.groups = groups
        }
        
        public init(
            @ArrayBuilder<UniqueAbility> abilities: @escaping () -> [UniqueAbility]
        ) {
            self.init {
                for ability in abilities() {
                    UniqueAbilityGroup({ ability })
                }
            }
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.EffectEntitiesDescriptor", [
                "entities": {
                    groups()
                        .enumerated()
                        .map { (id, group) in
                            [
                                "components": {
                                    AnyEnginePieceGroup(pieces: {
                                        for ability in group.abilities() {
                                            RawEnginePiece("EffectEntityGrouping", [
                                                "AbilityGroupId": id,
                                            ])
                                            
                                            RawComponent("Components.\(ability.trigger.id)")
                                            ability.trigger.filter?().compile()
                                            
                                            ability.pieces().flatMap({ $0.compile() })
                                        }
                                    })
                                    .compile()
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
    public struct UniqueAbilityGroup {
        public var abilities: () -> [UniqueAbility]
        
        public init(
            @ArrayBuilder<UniqueAbility> _ abilities: @escaping () -> [UniqueAbility]
        ) {
            self.abilities = abilities
        }
    }
}

extension EnginePieceGroup {
    public typealias UniqueAbilityGroup = ComponentGroups.UniqueAbilities.UniqueAbilityGroup
}

extension ComponentGroups.UniqueAbilities {
    public struct UniqueAbility {
        public var trigger: Trigger
        public var pieces: () -> [any EnginePieceGroup] // TODO: strengthen typing?
        
        public init(
            trigger: Trigger,
            @ArrayBuilder<any EnginePieceGroup> _ pieces: @escaping () -> [any EnginePieceGroup],
        ) {
            self.trigger = trigger
            self.pieces = pieces
        }
    }
}

extension EnginePieceGroup {
    public typealias UniqueAbility = ComponentGroups.UniqueAbilities.UniqueAbility
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
