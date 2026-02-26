//
//  File.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/25/26.
//

import Foundation

public struct EmptyComponentGroup: ComponentGroup {
    public var components: [any ComponentGroup] {
        return []
    }
}
