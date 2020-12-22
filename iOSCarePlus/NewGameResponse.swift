//
//  NewGameResponse.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2020/12/16.
//

import Foundation

struct NewGameContent: Decodable {
    let formalName: String
    let heroBannerURL: String
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
    }
}

struct NewGameResponse: Decodable {
    let contents: [NewGameContent]
    let length: Int
    let offset: Int
    let total: Int
}
