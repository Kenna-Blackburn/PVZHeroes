//
//  EnginePieceGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation
import Helpers

public protocol EnginePieceGroup {
    func compile(into resolved: inout Card.Resolved)
}

extension Never: EnginePieceGroup {
    public func compile(into resolved: inout Card.Resolved) {
        fatalError()
    }
}
