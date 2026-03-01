//
//  RawEnginePiece.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation
import Helpers

public enum RawEnginePiece: Encodable, EnginePieceGroup {
    case encodable(type: String, data: [String: Any])
    case sideEffect((inout Card.Resolved.Accumulating) -> Void)
    
    public init(_ partialType: String, _ data: [String: Any] = [:]) {
        self = .encodable(type: Self.type(completing: partialType), data: data)
    }
    
    public init(_ sideEffect: @escaping (inout Card.Resolved.Accumulating) -> Void) {
        self = .sideEffect(sideEffect)
    }
    
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .encodable(let type, let data):
            let dictionary: [String: Any] = [
                "$type": type,
                "$data": data,
            ]
            
            try AnyEncodable(dictionary).encode(to: encoder)
        default:
            break
        }
    }
    
    public func compile() -> [RawEnginePiece] {
        return [self]
    }
    
    public func compile(into accumulating: inout Card.Resolved.Accumulating) {
        switch self {
        case .encodable:
            accumulating.components.append(self)
        case .sideEffect(let sideEffect):
            sideEffect(&accumulating)
        }
    }
}

extension RawEnginePiece {
    public static func type(completing partialType: String) -> String {
        "PvZCards.Engine.\(partialType), EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
    }
}
