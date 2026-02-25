//
//  Raw.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation

//{
//    "$type":"PvZCards.Engine.Components.PrimaryTargetFilter, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
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
        public var selectionType: SelectionType
        public var maxTargets: Int?
        public var query: Query
        
        public var sortedTargetScope: SortedTargetScope?
        
        public var secondaryTargetQuery: (any Query)?
        public var onlyApplyEffectsToSecondaryTargets: Bool
        
        public init(
            selectionType: SelectionType,
            maxTargets: Int? = nil,
            sortedTargetScope: SortedTargetScope? = nil,
            onlyApplyEffectsToSecondaryTargets: Bool = false,
            query: () -> Query,
            secondaryTargetQuery: (() -> any Query)? = nil,
        ) {
            self.selectionType = selectionType
            self.maxTargets = maxTargets
            self.query = query()
            
            self.sortedTargetScope = sortedTargetScope
            
            self.secondaryTargetQuery = secondaryTargetQuery?()
            self.onlyApplyEffectsToSecondaryTargets = onlyApplyEffectsToSecondaryTargets
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.PrimaryTargetFilter", [
                "SelectionType": selectionType.rawValue,
                "NumTargets": maxTargets ?? 0,
                "Query": query,
                
                "TargetScopeType": sortedTargetScope == nil ? "All" : "Sorted",
                "TargetScopeSortValue": sortedTargetScope?.value.rawValue ?? "None",
                "TargetScopeSortMethod": sortedTargetScope?.method.rawValue ?? "None",
                
                "AdditionalTargetType": secondaryTargetQuery == nil ? "None" : "Query",
                "AdditionalTargetQuery": secondaryTargetQuery?.query as Any,
                "OnlyApplyEffectsOnAdditionalTargets": onlyApplyEffectsToSecondaryTargets,
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
