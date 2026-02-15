//
//  ComponentGroupBuilder.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

@resultBuilder
public enum ComponentGroupBuilder {
    public static func buildBlock(_ componentGroups: any ComponentGroup...) -> AnyComponentGroup {
        AnyComponentGroup(children: componentGroups)
    }
}
