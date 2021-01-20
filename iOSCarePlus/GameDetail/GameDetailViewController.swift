//
//  GameDetailViewController.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2021/01/20.
//

import UIKit

class GameDetailViewController: UIViewController {
    @IBOutlet private weak var containerViewController: UIView!
    var model: NewGameContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let desstination = segue.destination as? GameDetailImageViewController
//        description?.model = model
        
        (segue.destination as? GameDetailPageViewController)?.model = model
    }
}
