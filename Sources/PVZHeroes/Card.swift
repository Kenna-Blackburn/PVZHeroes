//
//  Card.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

public protocol Card: ComponentGroup {
    
}

extension Card {
    public func resolve() -> Resolved {
        Resolved(self)
    }
}
