//
//  ComponentGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

public protocol ComponentGroup {
    associatedtype Body: ComponentGroup
    
    func compile(into resolved: inout Card.Resolved)
    
    @ComponentGroupBuilder // TODO: replace with `ArrayBuilder<any ComponentGroup>`?
    var body: Body { get }
}

extension ComponentGroup {
    public func compile(into resolved: inout Card.Resolved) {
        return body.compile(into: &resolved)
    }
}

public enum ComponentGroups {
    
}

extension Never: ComponentGroup {
    public func compile(into resolved: inout Card.Resolved) {
        fatalError()
    }
    
    public var body: some ComponentGroup {
        fatalError()
    }
}
