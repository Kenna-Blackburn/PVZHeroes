//
//  AnyComponentGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

public struct AnyComponentGroup: ComponentGroup {
    public var children: [any ComponentGroup]
    
    public init(children: [any ComponentGroup]) {
        self.children = children
    }
    
    public func compile(into resolved: inout Card.Resolved) {
        children.forEach({ $0.compile(into: &resolved) })
    }
    
    public var body: some ComponentGroup {
        fatalError()
    }
}
