//
//  File.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation

public struct File: FileWrapperConvertible {
    public var name: String
    public var data: Data
    
    public init(_ name: String, data: () -> Data) {
        self.name = name
        self.data = data()
    }
    
    public var fileWrapper: FileWrapper {
        let file = FileWrapper(regularFileWithContents: data)
        file.preferredFilename = name
        
        return file
    }
}
