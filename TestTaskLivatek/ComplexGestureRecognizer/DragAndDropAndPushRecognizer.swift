//
//  DragAndDropAndPushRecognizer.swift
//  TestTaskLivatek
//
//  Created by October Hammer on 1/2/18.
//  Copyright © 2018 October Hammer. All rights reserved.
//

import Foundation
import UIKit

class DragAndDropAndPushRecognizer {
  var panGesture  = UIPanGestureRecognizer()
  
  var swipes: [UISwipeGestureRecognizer]  = []

  weak var parentView: UIView?
  weak var movableView: UIView?
  
  
  init(parentView: UIView, movableView: UIView) {
    self.parentView = parentView
    self.movableView = movableView

    panGesture = UIPanGestureRecognizer(target: self, action: #selector(DragAndDropAndPushRecognizer.dragAndDropView(_:)))
    
    let directionArray = [UISwipeGestureRecognizerDirection.right, UISwipeGestureRecognizerDirection.left, UISwipeGestureRecognizerDirection.up, UISwipeGestureRecognizerDirection.down]
    
    for everyDirection in directionArray {
      let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(DragAndDropAndPushRecognizer.pushView(_:)))
      swipeRecognizer.direction = everyDirection
      self.swipes.append(swipeRecognizer)
      movableView.addGestureRecognizer(swipeRecognizer)
      //swipes need to be preferable
      panGesture.require(toFail: swipeRecognizer)
    }
    
    movableView.addGestureRecognizer(panGesture)
  }
  
  
  @objc private func dragAndDropView(_ sender:UIPanGestureRecognizer){
    guard let parentView = self.parentView, let movableView = self.movableView else {return}
    parentView.bringSubview(toFront: movableView)
    let translation = sender.translation(in: parentView)
    movableView.center = CGPoint(x: movableView.center.x + translation.x, y: movableView.center.y + translation.y)
    sender.setTranslation(CGPoint.zero, in: parentView)
  }
 
  
  @objc private func pushView(_ gesture: UISwipeGestureRecognizer) {
    var animation: ()->() = {}
    guard let parentView = self.parentView, let movableView = self.movableView else {return}
    switch gesture.direction {
    case UISwipeGestureRecognizerDirection.left:
      animation = { movableView.center.x =  movableView.bounds.width / 2 }
    case UISwipeGestureRecognizerDirection.right:
      animation = { movableView.center.x = parentView.bounds.width - movableView.bounds.width / 2 }
    case UISwipeGestureRecognizerDirection.down:
      animation = { movableView.center.y = parentView.bounds.height - movableView.bounds.height / 2 }
    case UISwipeGestureRecognizerDirection.up:
      animation = { movableView.center.y = movableView.bounds.height / 2 }
    default:
      break
    }
    //Animation during 0.5 seconds, with no delay, Acceleration at the Begin, deceleratin at the End
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut,
                   animations: animation, completion: nil)
  }
  
  
}

