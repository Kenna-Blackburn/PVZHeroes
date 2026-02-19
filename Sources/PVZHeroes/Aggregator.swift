//
//  Aggregator.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

public protocol Aggregator: Sendable {
    func aggregate(_ cache: CompilationCache, into root: FileWrapper) throws
}

public enum Aggregators {
    public static let catalog: [any Aggregator] = [
        CardsData(),
    ]
}
