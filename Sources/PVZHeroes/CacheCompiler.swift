//
//  CacheCompiler.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation
import Helpers

public protocol CacheCompiler: Compiler {
    func compile(_ cache: CompilationCache) throws -> any FileWrapperConvertible
}

extension CacheCompiler {
    public func compile(_ mod: any Mod) throws -> any FileWrapperConvertible {
        let cache = CompilationCache()
        mod.modules.forEach({ $0.compile(into: cache) })
        
        return try compile(cache)
    }
}
