//
//  Mod.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation
import Helpers

public protocol Mod {
    @ArrayBuilder<any Module>
    var modules: [any Module] { get }
}

extension Mod {
    public func compile(
        to outputURL: URL,
        using compiler: some Compiler = Compilers.Default(),
    ) throws {
        let output = try compiler.compile(self).fileWrapper
        try output.write(to: outputURL, options: .atomic, originalContentsURL: nil)
    }
}
