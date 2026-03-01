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
        public var children: () -> [UniqueAbility]
        
        public init(
            @ArrayBuilder<UniqueAbility> _ children: @escaping () -> [UniqueAbility],
        ) {
            self.children = children
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.EffectEntitiesDescriptor", [
                "entities": children().enumerated().map { (i, child) in
                    [
                        "components": AnyEnginePieceGroup.init(pieces: {
                            RawComponent("Components.EffectEntityGrouping", [
                                "AbilityGroupId": i,
                            ])
                            
                            child
                        }).compile(),
                    ]
                }
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias UniqueAbilities = ComponentGroups.UniqueAbilities
}

extension ComponentGroups.UniqueAbilities {
    public struct UniqueAbility: ComponentGroup {
        public var trigger: Trigger
        public var pieces: () -> [any EnginePieceGroup] // TODO: strengthen typing?
        
        public init(
            trigger: Trigger,
            @ArrayBuilder<any EnginePieceGroup> _ pieces: @escaping () -> [any EnginePieceGroup],
        ) {
            self.trigger = trigger
            self.pieces = pieces
        }
        
        public var components: [any ComponentGroup] {
            trigger.compile()
            pieces().flatMap({ $0.compile() })
        }
    }
}

extension EnginePieceGroup {
    public typealias UniqueAbility = ComponentGroups.UniqueAbilities.UniqueAbility
}

extension ComponentGroups.UniqueAbilities.UniqueAbility {
    public struct Trigger: EnginePieceGroup, Sendable {
        public var id: String
        
        public init(_ id: String) {
            self.id = id
        }
        
        public func compile() -> [RawEnginePiece] {
            Array {
                RawEnginePiece("Components.\(id)")
            }
        }
    }
}

extension ComponentGroups.UniqueAbilities.UniqueAbility.Trigger {
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
