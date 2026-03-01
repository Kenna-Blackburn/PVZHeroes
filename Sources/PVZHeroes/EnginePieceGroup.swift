//
//  EnginePieceGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation
import Helpers

public protocol EnginePieceGroup {
    func compile() -> [RawEnginePiece]
}

extension EnginePieceGroup {
    func compile(into accumulating: inout Card.Resolved.Accumulating) {
        compile().forEach({ $0.compile(into: &accumulating) })
    }
}

extension Never: EnginePieceGroup {
    public func compile() -> [RawEnginePiece] {
        fatalError()
    }
}
