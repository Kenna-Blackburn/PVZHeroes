//
//  Compiler.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation
import Helpers

public protocol Compiler {
    func compile(_ mod: any Mod) throws -> any FileWrapperConvertible
}

public enum Compilers {
    
}
