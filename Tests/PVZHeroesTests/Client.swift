//
//  Client.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/13/26.
//

import Foundation
import Testing
@testable import PVZHeroes

@Test("Client")
func client() async throws {
    struct MyMod: Mod {
        var modules: [any Module] {
            Cards {
                BeserkerWallNut()
            }
        }
    }
    
    struct BeserkerWallNut: Card {
        var components: [any ComponentGroup] {
            GUID(646)
            PrefabID("Primal Wall-Nut")

            Faction(.plants)

            Name("Beserker Wall-Nut")
            Description("""
            This attacks using its [h] instead of its [a].
            <b>When this does damage:</b> it gets [+1h].
            """) // TODO: add custom String interpolation (ie. "...\(.health)...")?
            Flavor("He and Shieldcrusher Viking go way back.")

            Cost(4)
            Stats(0, 4)

            HealthAttack()

            UniqueAbilities {
                UniqueAbility(trigger: .onCardDidDamage) {
                    Guard.TriggerTarget {
                        AllOf {
                            IsSelf()
                            IsAlive()
                            WillTriggerEffects()
                        }
                    }
                    
                    Select.Self()
                    ApplyBuff(0, 1)
                }
            }
        }
    }
    
    try MyMod().compile(to: .downloadsDirectory.appending(path: "pvzh1"))
}

@Test("Fetch card_data_1")
func fetchCardData1() async throws {
    let url = URL(string: "https://pvzheroes-live.ecs.popcap.com/assetbundles/android/1.64.39/cards/card_data_1")!
    var req = URLRequest(url: url)
    req.httpMethod = "GET"
    req.setValue("gzip, identity", forHTTPHeaderField: "Accept-Encoding")
    req.setValue("Keep-Alive, TE", forHTTPHeaderField: "Connection")
    req.setValue("0", forHTTPHeaderField: "Content-Length")
    req.setValue("pvzheroes-live.ecs.popcap.com", forHTTPHeaderField: "Host")
    req.setValue("identity", forHTTPHeaderField: "TE")
    req.setValue("BestHTTP", forHTTPHeaderField: "User-Agent")
    
    let session = URLSession(configuration: .ephemeral)
    let (outputURL, response) = try await session.download(for: req) as! (URL, HTTPURLResponse)
    
    guard (200..<300).contains(response.statusCode) else {
        throw URLError(.badServerResponse, userInfo: [
            NSDebugDescriptionErrorKey: "Got \(response.statusCode)."
        ])
    }
    
    print(outputURL)
}
