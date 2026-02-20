//
//  Select.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/20/26.
//

import Foundation

//{
//    "$type":"PvZCards.Engine.Components.PrimaryTargetFilter, EngineLib, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
//    "$data":{
//        "SelectionType": <#enum: Manual|Random|All#>,
//        "NumTargets": <#Int#>,
//        "TargetScopeType": <#enum: All|Sorted#>,
//        "TargetScopeSortValue": <#enum: None|Attack|Health#>,
//        "TargetScopeSortMethod": <#enum: None|Highest|Lowest#>,
//        "AdditionalTargetType": <#enum: None|Query#>,
//        "AdditionalTargetQuery": <#Query?#>,
//        "OnlyApplyEffectsOnAdditionalTargets": <#Bool#>,
//        "Query": <#Query#>
//        }
//    }
//}

extension ComponentGroups {
    // TODO: this
    // TODO: rename?
    public struct Select: ComponentGroup {
        public var components: [any ComponentGroup] {
            
        }
    }
}

extension EnginePieceGroup {
    public typealias Select = ComponentGroups.Select
}
