//
//  SlideInPresentationAnimator.swift
//  MedalCount
//
//  Created by Захар on 21.07.17.
//  Copyright © 2017 Ron Kliffer. All rights reserved.
//

import UIKit

final class SlideInPresentationAnimator: NSObject {
  
  let direction: PresentationDirection
  
  let isPresentation: Bool
  
  init(direction: PresentationDirection, isPresentation: Bool) {
    self.direction = direction
    self.isPresentation = isPresentation
    super.init()
  }
}

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
  func transitionDuration(
    using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let key = isPresentation ? UITransitionContextViewControllerKey.to
      : UITransitionContextViewControllerKey.from
    
    let controller = transitionContext.viewController(forKey: key)!
    
    if isPresentation {
      transitionContext.containerView.addSubview(controller.view)
    }
    
    let presentedFrame = transitionContext.finalFrame(for: controller)
    var dismissedFrame = presentedFrame
    
    dismissedFrame.origin.x = -presentedFrame.width
    
    let initialFrame = isPresentation ? dismissedFrame : presentedFrame
    let finalFrame = isPresentation ? presentedFrame : dismissedFrame
    
    let animationDuration = transitionDuration(using: transitionContext)
    controller.view.frame = initialFrame
    UIView.animate(withDuration: animationDuration, animations: {
      controller.view.frame = finalFrame
    }) { finished in
      transitionContext.completeTransition(finished)
    }
  }
}


