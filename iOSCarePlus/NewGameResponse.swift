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
    let screenshot: [NewGameScreenshot]
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
        case screenshot
    }
}

struct NewGameScreenshot: Decodable {
    let images: [NewGameScreenshotURL]
}

struct NewGameScreenshotURL: Decodable {
    let url: String
}

struct NewGameResponse: Decodable {
    let contents: [NewGameContent]
    let length: Int
    let offset: Int
    let total: Int
//    let screenshot: [NewGameScreenshot]
//    let url: String
}
