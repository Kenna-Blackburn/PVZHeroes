//
//  Effect.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

public protocol Effect: EnginePieceGroup {
    var rawEffect: RawEffect { get }
}

extension Effect {
    public func compile() -> [RawEnginePiece] {
        rawEffect.compile()
    }
}

public typealias RawEffect = RawEnginePiece

extension RawEffect: Effect {
    public var rawEffect: RawEffect {
        return self
    }
}

public enum Effects {
    
}

extension Never: Effect {
    public var rawEffect: RawEffect {
        fatalError()
    }
}
