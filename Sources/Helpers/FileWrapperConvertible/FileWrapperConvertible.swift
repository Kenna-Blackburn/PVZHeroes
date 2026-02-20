//
//  FileWrapperConvertible.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation

public protocol FileWrapperConvertible {
    var fileWrapper: FileWrapper { get }
}

extension FileWrapper: FileWrapperConvertible {
    public var fileWrapper: FileWrapper {
        return self
    }
}
