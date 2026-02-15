//
//  AnyEnginePieceGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/15/26.
//

import Foundation
import Helpers

public struct AnyEnginePieceGroup: EnginePieceGroup {
    public var compile: (inout Card.Resolved) -> Void
    
    public init(
        _ compile: @escaping (inout Card.Resolved) -> Void,
    ) {
        self.compile = compile
    }
    
    public init(
        @ArrayBuilder<any EnginePieceGroup> _ pieces: () -> [any EnginePieceGroup],
    ) {
        let pieces = pieces()
        
        self.init { resolved in
            pieces.forEach({ $0.compile(into: &resolved) })
        }
    }
    
    public func compile(into resolved: inout Card.Resolved) {
        compile(&resolved)
    }
}
