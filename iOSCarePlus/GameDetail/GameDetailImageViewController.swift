//
//  GameDetailImageViewController.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2021/01/20.
//

import UIKit
import Kingfisher

class GameDetailImageViewController: UIViewController {
    var url: String?
    
    @IBOutlet private weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let stringURL = url else { return }
        let url = URL(string: stringURL)
        imageView.kf.setImage(with: url)
    }
}
