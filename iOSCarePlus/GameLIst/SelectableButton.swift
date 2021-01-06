//
//  SelectableButton.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2021/01/06.
//

import UIKit

class SelectableButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(UIColor(named: "black"), for: .selected)
        setTitleColor(UIColor(named: "VeryLightPink"), for: .normal)
        tintColor = .clear
    }
    
        
    //    func select(_ value: Bool){
//        if value{
//            setTitleColor(UIColor.init(named: "black"), for: .normal)
//        } else{
//            setTitleColor(UIColor.init(named: "VeryLightPink"), for: .normal)
//
//        }
//
//
//    }
}
