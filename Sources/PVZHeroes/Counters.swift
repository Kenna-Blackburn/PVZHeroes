//
//  Counters.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

public struct Counters: Encodable {
    public var isPersistent: Bool
    public var counters: [Counter]
    
    public init(
        isPersistent: Bool = true,
        counters: [Counter] = [.init()],
    ) {
        self.isPersistent = isPersistent
        self.counters = counters
    }
    
    public struct Counter: Encodable {
        public var sourceID: Int
        public var value: Int
        public var duration: Int
        
        public init(
            sourceID: Int = -1,
            value: Int = 0,
            duration: Int = 0,
        ) {
            self.sourceID = sourceID
            self.value = value
            self.duration = duration
        }
        
        private enum CodingKeys: String, CodingKey {
            case sourceID = "SourceId"
            case value = "Value"
            case duration = "Duration"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case isPersistent = "IsPersistent"
        case counters = "Counters"
    }
}
