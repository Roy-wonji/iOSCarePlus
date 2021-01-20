//
//  GameDetailPageViewController.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2021/01/20.
//

import UIKit

class GameDetailPageViewController: UIPageViewController {
    var orderedViewControllers: [UIViewController]? = []
    var model: NewGameContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dataSource = self //pageviewcontroller에게 필요한거 있음 나한테 물어봐라 내가 처리해주겠다는 의미
    
        guard let screenShots = model?.screenshots else { return }
        for screenShot in screenShots {
            guard let url = screenShot.images.first?.url else { return }

            let imageViewController = getImageViewController(url: url)
            orderedViewControllers?.append(imageViewController)
        }
        
//        orderedViewControllers = [getImageViewController(), getImageViewController(), getImageViewController()]
        if let firstViewController = orderedViewControllers?.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    private func getImageViewController(url: String) -> UIViewController {
        guard let imageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailImageViewController") as? GameDetailImageViewController else { return UIViewController() }
        imageViewController.url = url
        return imageViewController
//        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailImageViewController")
    }
}

extension GameDetailPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = orderedViewControllers?.firstIndex(of: viewController) else {
            return nil
        }
        let beforeIndex: Int = currentIndex - 1
        
        guard beforeIndex >= 0, (orderedViewControllers?.count ?? 0) > beforeIndex else { return nil }
        return orderedViewControllers?[beforeIndex]
}
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = orderedViewControllers?.firstIndex(of: viewController) else { return nil }
        let afterIndex: Int = currentIndex + 1
        
        guard let count = orderedViewControllers?.count, count > afterIndex else {
            return nil
        }
        
        return orderedViewControllers?[afterIndex]
    }
}
