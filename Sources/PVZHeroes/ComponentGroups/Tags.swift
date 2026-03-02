//
//  Tags.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension ComponentGroups {
    public struct Tags: ComponentGroup {
        public var tags: [Tag]
        
        public init(_ tags: Tag...) {
            self.tags = tags
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Tags", [
                "tags": tags.map(\.id),
            ])
            
            RawComponent { accumulating in
                accumulating.tags = tags
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Tags = ComponentGroups.Tags
}

public struct Tag: Sendable {
    public var id: String
    
    public init(_ id: String) {
        self.id = id
    }
}

// TODO: rename
// NOTE: good luck
extension Tag {
    public static let `2costzombie`: Self = .init("2costzombie")
    public static let `anyaquaticplantcard`: Self = .init("anyaquaticplantcard")
    public static let `anyaquaticplantfighter`: Self = .init("anyaquaticplantfighter")
    public static let `anyplantfighter`: Self = .init("anyplantfighter")
    public static let `aquatic`: Self = .init("aquatic")
    public static let `attack`: Self = .init("attack")
    public static let `bad`: Self = .init("bad")
    public static let `basicpeashooter`: Self = .init("basicpeashooter")
    public static let `bonus`: Self = .init("bonus")
    public static let `brains`: Self = .init("brains")
    public static let `buff`: Self = .init("buff")
    public static let `can be gravestone`: Self = .init("can be gravestone")
    public static let `can be transmogrified`: Self = .init("can be transmogrified")
    public static let `caresaboutenvironment`: Self = .init("caresaboutenvironment")
    public static let `cheats`: Self = .init("cheats")
    public static let `control`: Self = .init("control")
    public static let `cost6orless`: Self = .init("cost6orless")
    public static let `damage`: Self = .init("damage")
    public static let `deadbeard`: Self = .init("deadbeard")
    public static let `defense`: Self = .init("defense")
    public static let `destroy`: Self = .init("destroy")
    public static let `draw`: Self = .init("draw")
    public static let `environment`: Self = .init("environment")
    public static let `fatty`: Self = .init("fatty")
    public static let `freeze`: Self = .init("freeze")
    public static let `galaxyplant`: Self = .init("galaxyplant")
    public static let `galaxyzombie`: Self = .init("galaxyzombie")
    public static let `gargantaur`: Self = .init("gargantaur")
    public static let `gargantuar`: Self = .init("gargantuar")
    public static let `goat`: Self = .init("goat")
    public static let `gravestone`: Self = .init("gravestone")
    public static let `grow`: Self = .init("grow")
    public static let `heal`: Self = .init("heal")
    public static let `invisibility`: Self = .init("invisibility")
    public static let `knightofthelivingdead`: Self = .init("knightofthelivingdead")
    public static let `leftovers`: Self = .init("leftovers")
    public static let `madebygardener`: Self = .init("madebygardener")
    public static let `madebyzucchini`: Self = .init("madebyzucchini")
    public static let `mayflower`: Self = .init("mayflower")
    public static let `meow`: Self = .init("meow")
    public static let `narrow`: Self = .init("narrow")
    public static let `needsfighter`: Self = .init("needsfighter")
    public static let `not pine clone`: Self = .init("not pine clone")
    public static let `notpineclone`: Self = .init("notpineclone")
    public static let `notplankwalker`: Self = .init("notplankwalker")
    public static let `pineclone`: Self = .init("pineclone")
    public static let `piratezombie`: Self = .init("piratezombie")
    public static let `plantevent`: Self = .init("plantevent")
    public static let `plantfighter6orless`: Self = .init("plantfighter6orless")
    public static let `plantlegend`: Self = .init("plantlegend")
    public static let `poison`: Self = .init("poison")
    public static let `potatomine`: Self = .init("potatomine")
    public static let `randomplantcard`: Self = .init("randomplantcard")
    public static let `randomzombie`: Self = .init("randomzombie")
    public static let `randomzombiefigher`: Self = .init("randomzombiefigher")
    public static let `randomzombiefighter`: Self = .init("randomzombiefighter")
    public static let `randomzombietrick`: Self = .init("randomzombietrick")
    public static let `rush`: Self = .init("rush")
    public static let `saboteur`: Self = .init("saboteur")
    public static let `set3plant`: Self = .init("set3plant")
    public static let `set3zombie`: Self = .init("set3zombie")
    public static let `set4`: Self = .init("set4")
    public static let `splash`: Self = .init("splash")
    public static let `sun`: Self = .init("sun")
    public static let `teamup`: Self = .init("teamup")
    public static let `trick`: Self = .init("trick")
    public static let `trickortreat`: Self = .init("trickortreat")
    public static let `tricks`: Self = .init("tricks")
    public static let `truestrike`: Self = .init("truestrike")
    public static let `vimpire`: Self = .init("vimpire")
    public static let `weenie`: Self = .init("weenie")
    public static let `weeniebean`: Self = .init("weeniebean")
    public static let `yetilunchbox`: Self = .init("yetilunchbox")
    public static let `zombieevent`: Self = .init("zombieevent")
    public static let `zombielegend`: Self = .init("zombielegend")
}
