//
//  Class.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation


extension ComponentGroups {
    public struct Class: ComponentGroup {
        public var `class`: PVZHeroes.Class
        
        public init(_ `class`: PVZHeroes.Class) {
            self.class = `class`
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { resolved in
                resolved.class = `class`
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Class = ComponentGroups.Class
}

public struct Class: Sendable {
    public var id: String
    
    public init(_ id: String) {
        self.id = id
    }
}

extension Class {
    public static let none: Self = .init("0")
    
    public static let guardian: Self = .init("Guardian")
    public static let kabloom: Self = .init("Kabloom")
    public static let megaGrow: Self = .init("MegaGro")
    public static let smarty: Self = .init("Smarty")
    public static let solar: Self = .init("Solar")
    
    public static let beastly: Self = .init("Hungry")
    public static let brainy: Self = .init("Brainy")
    public static let crazy: Self = .init("Madcap")
    public static let hearty: Self = .init("Hearty")
    public static let sneaky: Self = .init("Sneaky")
}
