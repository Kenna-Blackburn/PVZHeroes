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
        public var children: [UniqueAbility]
        
        public init(children: [UniqueAbility]) {
            self.children = children
        }
        
        public init(
            @ArrayBuilder<UniqueAbility> _ children: () -> [UniqueAbility],
        ) {
            self.init(children: children())
        }
        
        // TODO: rewrite?
        public var components: [any ComponentGroup] {
            RawComponent("Components.EffectEntitiesDescriptor", [
                "entities": children.enumerated().map { (i, child) in
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
        public var pieces: [any EnginePieceGroup] // TODO: strengthen typing
        
        public init(
            trigger: Trigger,
            @ArrayBuilder<any EnginePieceGroup> _ pieces: () -> [any EnginePieceGroup],
        ) {
            self.trigger = trigger
            self.pieces = pieces()
        }
        
        public var components: [any ComponentGroup] {
            trigger.compile()
            pieces.flatMap({ $0.compile() })
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
    public static let onRoundStarted = Self("TurnStartTrigger")
    public static let onTricksStarted = Self("SurprisePhaseStartTrigger")
    public static let onCombatStartedHere = Self("LaneCombatStartTrigger")
    public static let onCombatEndedHere = Self("LaneCombatEndTrigger")
    public static let onRoundEnded = Self("CombatEndTrigger")
    
    public static let onHeroDrewCard = Self("DrawCardTrigger")
    public static let onHeroConjuredCard = Self("DrawCardFromSubsetTrigger")
    
    public static let onCardPlayed = Self("PlayTrigger")
    public static let onCardRevealed = Self("RevealTrigger")
    public static let onCardEnteredBoard = Self("EnterBoardTrigger")
    public static let onCardBounced = Self("ReturnToHandTrigger")
    
    public static let onCardDidDamage = Self("DamageTrigger")
    public static let onCardDidDestroy = Self("DestroyCardTrigger")
    public static let onCardDidBonusAttack = Self("ExtraAttackTrigger")
    
    public static let onCardHealed = Self("HealTrigger")
    public static let onCardFrozen = Self("SlowedTrigger")
    public static let onCardDestroyed = Self("DiscardFromPlayTrigger")
    public static let onCardBuffed = Self("BuffTrigger")
    public static let onCardMoved = Self("MoveTrigger")
}
