//
//  Effect.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

public protocol Effect: EnginePieceGroup {
    var effect: RawEffect { get }
}

extension Effect {
    public func compile() -> [RawEnginePiece] {
        effect.compile()
    }
}

public typealias RawEffect = RawEnginePiece

extension RawEffect: Effect {
    public var effect: RawEffect {
        fatalError()
    }
}

public enum Effects {
    
}

extension Never: Effect {
    public var effect: RawEffect {
        fatalError()
    }
}
