//
//  Raw.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation

//{
//    "$type":"PvZCards.Engine.Components.<#enum: Primary|Secondary#>TargetFilter, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
//    "$data": {
//        "SelectionType": <#enum: Manual|Random|All#>,
//        "NumTargets": <#Int#>,
//        "Query": <#Query#>,
//
//        "TargetScopeType": <#enum: All|Sorted#>,
//        "TargetScopeSortValue": <#enum: None|Attack|Health#>,
//        "TargetScopeSortMethod": <#enum: None|Highest|Lowest#>,
//
//        "AdditionalTargetType": <#enum: None|Query#>,
//        "AdditionalTargetQuery": <#Query?#>,
//        "OnlyApplyEffectsOnAdditionalTargets": <#Bool#>,
//    }
//}

extension ComponentGroups.Select {
    public struct Raw: ComponentGroup {
        public var ordinal: Ordinal
        public var selectionType: SelectionType
        public var maxTargets: Int?
        public var query: Query
        
        public var sortedTargetScope: SortedTargetScope?
        
        public var additionalTargetQuery: (any Query)?
        public var onlyApplyEffectsToAdditionalTargets: Bool
        
        public init(
            ordinal: Ordinal = .primary,
            selectionType: SelectionType,
            maxTargets: Int? = nil,
            sortedTargetScope: SortedTargetScope? = nil,
            onlyApplyEffectsToAdditionalTargets: Bool = false,
            query: () -> Query,
            additionalTargetQuery: (() -> any Query)? = nil,
        ) {
            self.ordinal = ordinal
            self.selectionType = selectionType
            self.maxTargets = maxTargets
            self.query = query()
            
            self.sortedTargetScope = sortedTargetScope
            
            self.additionalTargetQuery = additionalTargetQuery?()
            self.onlyApplyEffectsToAdditionalTargets = onlyApplyEffectsToAdditionalTargets
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.\(ordinal.id)", [
                "SelectionType": selectionType.rawValue,
                "NumTargets": maxTargets ?? 0,
                "Query": query.rawQuery,
                
                "TargetScopeType": sortedTargetScope == nil ? "All" : "Sorted",
                "TargetScopeSortValue": sortedTargetScope?.value.rawValue ?? "None",
                "TargetScopeSortMethod": sortedTargetScope?.method.rawValue ?? "None",
                
                "AdditionalTargetType": additionalTargetQuery == nil ? "None" : "Query",
                "AdditionalTargetQuery": additionalTargetQuery?.rawQuery as Any,
                "OnlyApplyEffectsOnAdditionalTargets": onlyApplyEffectsToAdditionalTargets,
            ])
        }
        
        public enum SelectionType: String {
            case manual = "Manual"
            case random = "Random"
            case all = "All"
        }
        
        public struct SortedTargetScope {
            public var value: Value
            public var method: Method
            
            public init(_ method: Method, _ value: Value) {
                self.value = value
                self.method = method
            }
            
            public enum Value: String {
                case strength = "Attack"
                case health = "Health"
            }
            
            public enum Method: String {
                case highestToLowest = "Highest"
                case lowestToHighest = "Lowest"
            }
        }
    }
}

extension ComponentGroups.Select.Raw {
    public struct Ordinal: Sendable {
        public var id: String
        
        public init(_ id: String) {
            self.id = id
        }
    }
}

extension ComponentGroups.Select.Raw.Ordinal {
    public static let primary: Self = .init("PrimaryTargetFilter")
    public static let secondary: Self = .init("SecondaryTargetFilter")
}
