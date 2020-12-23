//
//  GameItemModel.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2020/12/16.
//

import Foundation

struct GameItemModel {
    let gameTitle: String
    let gameOriginPrice: Int
    let gameDiscountPrice: Int?
    let imageURL: String
    let screenshots: [NewGameScreenshot]
}
