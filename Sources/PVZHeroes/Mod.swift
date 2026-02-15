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
        using aggregators: [any Aggregator] = Aggregators.catalog,
    ) throws -> FileWrapper {
        let cache = CompilationCache()
        let root = FileWrapper(directoryWithFileWrappers: [:])
        root.preferredFilename = "files"
        
        modules.forEach({ $0.compile(into: cache) })
        try aggregators.forEach({ try $0.aggregate(cache, into: root) })
        
        return root
    }
    
    public func compile(
        to outputURL: URL,
        using aggregators: [any Aggregator] = Aggregators.catalog,
        shouldOverwrite: Bool = true,
    ) throws {
        if shouldOverwrite {
            if FileManager.default.fileExists(atPath: outputURL.path()) {
                try FileManager.default.removeItem(at: outputURL)
            }
        }
        
        let root = try compile(using: aggregators)
        try root.write(to: outputURL, options: .atomic, originalContentsURL: nil)
    }
}
