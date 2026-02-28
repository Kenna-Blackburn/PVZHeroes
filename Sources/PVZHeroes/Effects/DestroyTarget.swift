//
//  File.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/28/26.
//

import Foundation

extension Effects {
    public struct DestroyTarget: ComponentGroup {
        public var components: [any ComponentGroup] {
            RawComponent("Components.DestroyCardEffectDescriptor")
        }
    }
}

extension EnginePieceGroup {
    public typealias DestroyTarget = Effects.DestroyTarget
}
