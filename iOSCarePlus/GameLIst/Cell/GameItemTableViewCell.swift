//
//  GameItemTableViewCell.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2020/12/16.
//

import Kingfisher
import UIKit

class GameItemTableViewCell: UITableViewCell {
    private var model: GameItemModel? {
        didSet {
            setUIFromModel()
        }}
    @IBOutlet private weak var gameTitleLabel: UILabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameOriginPirce: UILabel!
    @IBOutlet private weak var gameCurrentPrice: UILabel!
    
    func setModel(_ model: GameItemModel) {
        self.model = model
    }
    
    func setUIFromModel() {
        guard let model = model else { return }
        
        let imageURL: URL? = URL(string: model.imageURL)
        gameImageView.kf.setImage(with: imageURL)
        
        gameImageView.layer.cornerRadius = 9
        gameImageView.layer.borderWidth = 1
        gameImageView.layer.borderColor = UIColor(red: 236 / 255.0, green: 236 / 255.0, blue: 236 / 255.0, alpha: 1).cgColor
        
//        private func getGamePriceApiCall(id: Int) {
//            AF.request(getGamePriceURL, method: .get, parameters: ["country": "KR", "ids": "\(id)", "lang" : "ko"]).responseJSON {
//            response in
//            guard let data = response.data else { return }
//
//            let decoder = JSONDecoder()
//
//        }
//    }
    
        gameTitleLabel.text = model.gameTitle
        if let discountPrice: Int = model.gameDiscountPrice {
            gameCurrentPrice.text = "\(discountPrice)"
            gameOriginPirce.text = "\(model.gameOriginPrice)"
        } else {
            gameCurrentPrice.text = "\(model.gameOriginPrice)"
            gameOriginPirce.isHidden = true
        }
    }
}
