//
//  _Unsorted.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/13/26.
//

import Foundation
import Helpers

public protocol Mod {
    @ArrayBuilder<any Module>
    var modules: [any Module] { get }
}

extension Mod {
    public func compile(using aggregators: [any Aggregator]) throws -> FileWrapper {
        let cache = CompilationCache()
        let root = FileWrapper(directoryWithFileWrappers: [:])
        root.preferredFilename = "files"
        
        modules.forEach({ $0.compile(into: cache) })
        try aggregators.forEach({ try $0.aggregate(cache, into: root) })
        
        return root
    }
}

public final class CompilationCache {
    private var cache: [String: Any]
    
    public init() {
        self.cache = [:]
    }
    
    public subscript<T: Key>(_ key: T.Type) -> T.Value? {
        get {
            cache[key.string] as? T.Value
        }
        
        set {
            guard let newValue else {
                return
            }
            
            if let existingValue = self[key] {
                cache[key.string] = key.reduce(newValue, into: existingValue)
            } else {
                cache[key.string] = newValue
            }
        }
    }
}

extension CompilationCache {
    public protocol Key {
        associatedtype Value
        
        static var string: String { get }
        
        static func reduce(_ newValue: Value, into existingValue: Value) -> Value
    }
}

extension CompilationCache.Key {
    public static var string: String {
        String(reflecting: Self.self)
    }
    
    public static func reduce(_ newValue: Value, into existingValue: Value) -> Value {
        return newValue
    }
}

extension CompilationCache {
    public enum Keys {
        
    }
}

public protocol Module {
    func compile(into cache: CompilationCache)
}

public enum Modules {
    
}

public protocol Aggregator {
    func aggregate(_ cache: CompilationCache, into root: FileWrapper) throws
}

public enum Aggregators {
    
}

extension Modules {
    public struct Cards: Module {
        public var cards: [any Card]
        
        public init(cards: [any Card]) {
            self.cards = cards
        }
        
        public init(@ArrayBuilder<any Card> _ cards: () -> [any Card]) {
            self.init(cards: cards())
        }
        
        public func compile(into cache: CompilationCache) {
            cache[CompilationCache.Keys.Cards.self] = cards.map({ $0.resolve() })
        }
    }
}

extension Mod {
    public typealias Cards = Modules.Cards
}

public protocol Card: ComponentGroup {
    
}

extension Card {
    public func resolve() -> Resolved {
        Resolved(self)
    }
}

public protocol ComponentGroup {
    associatedtype Body: ComponentGroup
    
    func compile(into resolved: inout Card.Resolved)
    
    @ComponentGroupBuilder
    var body: Body { get }
}

extension ComponentGroup {
    public func compile(into resolved: inout Card.Resolved) {
        return body.compile(into: &resolved)
    }
}

public enum RawComponent: Encodable, ComponentGroup {
    case encodable(type: String, data: [String: Any])
    case sideEffect((inout Card.Resolved) -> Void)
    
    public init(_ partialType: String, _ data: [String: Any]) {
        let type = "PvZCards.Engine.\(partialType), EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
        self = .encodable(type: type, data: data)
    }
    
    public init(_ sideEffect: @escaping (inout Card.Resolved) -> Void) {
        self = .sideEffect(sideEffect)
    }
    
    public var shouldEncode: Bool {
        switch self {
        case .encodable:
            return true
        case .sideEffect:
            return false
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .encodable(let type, let data):
            let dictionary: [String: Any] = [
                "$type": type,
                "$data": data,
            ]
            
            try AnyEncodable(dictionary).encode(to: encoder)
        default:
            break
        }
    }
    
    public func compile(into resolved: inout Card.Resolved) {
        resolved.components.append(self)
        
        switch self {
        case .sideEffect(let sideEffect):
            sideEffect(&resolved)
        default:
            break
        }
    }
    
    public var body: some ComponentGroup {}
}

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

extension Never: ComponentGroup {
    public func compile(into resolved: inout Card.Resolved) {
        fatalError()
    }
    
    public var body: some ComponentGroup {
        fatalError()
    }
}

@resultBuilder
public enum ComponentGroupBuilder {
    public static func buildBlock(_ componentGroups: any ComponentGroup...) -> AnyComponentGroup {
        AnyComponentGroup(children: componentGroups)
    }
}

extension Card {
    public typealias Resolved = _Card_Resolved
}

public struct _Card_Resolved {
    public var components: [RawComponent]
    
    public var guid: Int
    public var prefabID: String
    
    public init() {
        self.components = []
        self.guid = 0
        self.prefabID = ""
    }
    
    public init(_ base: any Card) {
        var resolved = Self()
        base.compile(into: &resolved)
        self = resolved
    }
}

extension CompilationCache.Keys {
    public enum Cards: CompilationCache.Key {
        public typealias Value = [Card.Resolved]
        
        public static func reduce(_ newValue: Value, into existingValue: Value) -> Value {
            return existingValue + newValue
        }
    }
}

public enum ComponentGroups {
    
}

extension ComponentGroups {
    public struct GUID: ComponentGroup {
        public var guid: Int
        
        public init(_ guid: Int) {
            self.guid = guid
        }
        
        public var body: some ComponentGroup {
            RawComponent("Components.Card", [
                "Guid": guid,
            ])
            
            RawComponent { resolved in
                resolved.guid = guid
            }
        }
    }
    
    public struct PrefabID: ComponentGroup {
        public var prefabID: String
        
        public init(_ prefabID: String) {
            self.prefabID = prefabID
        }
        
        public var body: some ComponentGroup {
            RawComponent { resolved in
                resolved.prefabID = prefabID
            }
        }
    }
}

extension Card {
    public typealias GUID = ComponentGroups.GUID
    public typealias PrefabID = ComponentGroups.PrefabID
}

extension Aggregators {
    public struct CardsDataAggregator: Aggregator {
        public func aggregate(_ cache: CompilationCache, into root: FileWrapper) throws {
            guard let cards = cache[CompilationCache.Keys.Cards.self] else {
                return
            }
            
            var contents = [String: Any]()
            
            for card in cards {
                contents[String(card.guid)] = [
                    "prefabName": card.prefabID,
                    "entity": [
                        "components": card.components.filter(\.shouldEncode),
                    ],
                ]
            }
            
            let data = try JSONEncoder().encode(AnyEncodable(contents))
            
            root.addFileWrapper({
                let child1 = FileWrapper(directoryWithFileWrappers: [:])
                child1.preferredFilename = "cards"
                child1.addFileWrapper({
                    let child2 = FileWrapper(directoryWithFileWrappers: [:])
                    child2.preferredFilename = "card_data_1"
                    child2.addRegularFile(withContents: data, preferredFilename: "cards.json")
                    
                    return child2
                }())
                
                return child1
            }())
        }
    }
}
