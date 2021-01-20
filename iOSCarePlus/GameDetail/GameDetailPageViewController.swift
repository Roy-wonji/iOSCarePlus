//
//  GameDetailPageViewController.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2021/01/20.
//

import UIKit

class GameDetailPageViewController: UIPageViewController {
    var orderedViewControllers: [UIViewController]?
    var model: NewGameContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dataSource = self
    
        orderedViewControllers = [getImageViewController(), getImageViewController(), getImageViewController()]

        if let firstViewController = orderedViewControllers?.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    private func getImageViewController() -> UIViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailImageViewController")
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
