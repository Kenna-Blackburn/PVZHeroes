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
    case sideEffect((inout Card.Resolved) -> Void)
    
    public init(_ partialType: String, _ data: [String: Any]) {
        let type = "PvZCards.Engine.\(partialType), EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
        self = .encodable(type: type, data: data)
    }
    
    public init(_ sideEffect: @escaping (inout Card.Resolved) -> Void) {
        self = .sideEffect(sideEffect)
    }
    
    public var shouldEncode: Bool {
        switch self {
        case .encodable:
            return true
        case .sideEffect:
            return false
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        guard shouldEncode else {
            return
        }
        
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
    
    public func compile(into resolved: inout Card.Resolved) {
        resolved.components.append(self)
        
        switch self {
        case .sideEffect(let sideEffect):
            sideEffect(&resolved)
        default:
            break
        }
    }
}
