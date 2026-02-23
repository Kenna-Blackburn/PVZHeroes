//
//  Folder.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation

public struct Folder: FileWrapperConvertible {
    public var name: String
    public var children: [any FileWrapperConvertible]
    
    public init(
        _ name: String,
        @ArrayBuilder<any FileWrapperConvertible> children: () throws -> [any FileWrapperConvertible]
    ) rethrows {
        self.name = name
        self.children = try children()
    }
    
    public var fileWrapper: FileWrapper {
        let folder = FileWrapper(directoryWithFileWrappers: [:])
        folder.preferredFilename = name
        children.forEach({ folder.addFileWrapper($0.fileWrapper) })
        
        return folder
    }
}
