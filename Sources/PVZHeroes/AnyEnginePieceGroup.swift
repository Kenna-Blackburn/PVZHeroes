//
//  AnyEnginePieceGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/15/26.
//

import Foundation
import Helpers

public struct AnyEnginePieceGroup: EnginePieceGroup {
    public var _compile: () -> [RawEnginePiece]
    
    public init(
        compile: @escaping () -> [RawEnginePiece],
    ) {
        self._compile = compile
    }
    
    public init(
        @ArrayBuilder<any EnginePieceGroup> pieces: () -> [any EnginePieceGroup],
    ) {
        let pieces = pieces()
        
        self.init {
            pieces.flatMap({ $0.compile() })
        }
    }
    
    public func compile() -> [RawEnginePiece] {
        _compile()
    }
}
