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

  var parentView: UIView
  var movableView: UIView
  
  
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
      panGesture.require(toFail: swipeRecognizer)
    }
    
//    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(DragAndDropAndPushRecognizer.pushView(_:)))
//    swipeLeft.direction = .left
//    movableView.addGestureRecognizer(swipeLeft)
//
//    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(DragAndDropAndPushRecognizer.pushView(_:)))
//    swipeRight.direction = .right
//    movableView.addGestureRecognizer(swipeRight)
//
//    let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(DragAndDropAndPushRecognizer.pushView(_:)))
//    swipeUp.direction = .up
//    movableView.addGestureRecognizer(swipeUp)
//
//    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(DragAndDropAndPushRecognizer.pushView(_:)))
//    swipeDown.direction = .down
//    movableView.addGestureRecognizer(swipeDown)
//
//    self.swipes = [swipeLeft, swipeRight , swipeUp, swipeDown]
//
//
    
    
//    panGesture.require(toFail: swipeLeft)
//    panGesture.require(toFail: swipeRight)
//    panGesture.require(toFail: swipeUp)
//    panGesture.require(toFail: swipeDown)
    
    movableView.addGestureRecognizer(panGesture)
  }
  
  
  @objc func dragAndDropView(_ sender:UIPanGestureRecognizer){
    self.parentView.bringSubview(toFront: movableView)
    let translation = sender.translation(in: self.parentView)
    movableView.center = CGPoint(x: movableView.center.x + translation.x, y: movableView.center.y + translation.y)
    sender.setTranslation(CGPoint.zero, in: self.parentView)
  }
 
  
  @objc func pushView(_ gesture: UISwipeGestureRecognizer) {
    var animation: ()->() = {}
    print(gesture.direction)
    switch gesture.direction {
    case UISwipeGestureRecognizerDirection.left:
      print("Swiped left")
      animation = { self.movableView.center.x =  self.movableView.bounds.width / 2 }
    case UISwipeGestureRecognizerDirection.right:
      print("Swiped right")
      animation = { self.movableView.center.x = self.parentView.bounds.width - self.movableView.bounds.width / 2}
    case UISwipeGestureRecognizerDirection.down:
      print("Swiped down")
      animation = { self.movableView.center.y = self.parentView.bounds.height - self.movableView.bounds.height / 2 }
    case UISwipeGestureRecognizerDirection.up:
      print("Swiped up")
      animation = { self.movableView.center.y = self.movableView.bounds.height / 2 }
    default:
      break
    }
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut,
                   animations: animation, completion: nil)
  }
  
  
}

