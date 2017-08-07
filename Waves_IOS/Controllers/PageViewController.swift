//
//  PageViewController.swift
//  Waves_iOS
//
//  Created by Захар on 24.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerList: [UIViewController] = {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstViewController = storyBoard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController")
        let thirdViewController = storyBoard.instantiateViewController(withIdentifier: "ThirdViewController")
        
        return [firstViewController, secondViewController, thirdViewController]
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()

        self.dataSource = self
        
        next()

        setViewControllers([viewControllerList.first!], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = viewControllerIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
    }
    
    public func next() {
        setViewControllers([viewControllerList.first!], direction: .forward, animated: true, completion: nil)
    }
}
