//
//  ViewController.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2020/12/06.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func logoTapAction(_ sender: UITapGestureRecognizer) {
        self.blinkLogoAnmiation()
    }
    @IBOutlet private weak var backgroundImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var logoViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var logoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoView.layer.cornerRadius = 15    }
    private func animationSettingDefault() {
        logoViewTopConstraint.constant = 200
        backgroundImageViewLeadingConstraint.constant = 17
        logoView.alpha = 1
        view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        appearLogoViewAnimation {[weak self] in self?.sliderBackgroundImageAnimation()

            
        }
    }
    
    private func appearLogoViewAnimation(completion: @escaping () -> Void) { UIView.animate(withDuration: 0.7, delay: 1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: []) {
            [weak self] in self?.logoViewTopConstraint.constant = 17
            self?.view.layoutIfNeeded() //제약 조건에 맞게 화면도 갱신해야되는데, 뷰는 일정한 단위에 맞게 갱신이 되는데 이 애니메이션 효과일 때 감지해야되므로, 블록안에서 갱신하라고 말해야 차이 보고 갱신한다. 당장 뷰 업데이트 하라는 의미
} completion: { _ in completion()
}
    }
    private func sliderBackgroundImageAnimation() { UIView.animate(withDuration: 10, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse]) {[weak self] in
            self?.backgroundImageViewLeadingConstraint.constant = -800
            self?.view.layoutIfNeeded()
        }
    }
    private func blinkLogoAnmiation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {[weak self] in
            self?.logoView.alpha = 0
        }}
}

