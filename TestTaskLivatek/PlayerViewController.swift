//
//  PlayerViewController.swift
//  TestTaskLivatek
//
//  Created by October Hammer on 12/28/17.
//  Copyright © 2017 October Hammer. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {


  
  var player: AVAudioPlayer?
  @IBOutlet weak var circleAudioPlayer: CircleAudioPlayer!
  
  var complexGestureRecognizer: DragAndDropAndPushRecognizer?
  
  var currentRelativeHorisontalPosition: CGFloat = 0.5
  var currentRelativeVerticalPosition: CGFloat = 0.5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.complexGestureRecognizer = DragAndDropAndPushRecognizer(parentView: self.view, movableView: self.circleAudioPlayer)
    self.complexGestureRecognizer?.delegateCallBackForDragAndDrop = self.dragAndDropCircleAudioPlayer
    self.complexGestureRecognizer?.delegateCallBackForPush = self.pushCircleAudioPlayerToTheEndge
    self.circleAudioPlayer.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
    //1
    NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

  }


  @IBAction func useLocalFile(_ sender: UISwitch) {
    if sender.isOn {
      let audioPath = Bundle.main.path(forResource: "02 - Suzanne Vega - Tom's Diner", ofType: "mp3")
      let url = URL(fileURLWithPath: audioPath!)
      
      do {
        player = try AVAudioPlayer(contentsOf: url)
        guard let player = player else { return }
        circleAudioPlayer.setPlayer(player)
      } catch let error  {
        print(error.localizedDescription)
      }
    } else {
      circleAudioPlayer.fetch()
    }
    
  }


  
  func dragAndDropCircleAudioPlayer(dx: CGFloat, dy: CGFloat) {
    print(dx, dy)
    if dx != 0 {
      self.currentRelativeHorisontalPosition = self.circleAudioPlayer.center.x / self.view.bounds.maxX
      let relativeChange = dx/self.view.bounds.maxX
      self.circleAudioPlayer.center.x = (self.currentRelativeHorisontalPosition + relativeChange) * self.view.bounds.maxX
    }
    if dy != 0 {
      self.currentRelativeVerticalPosition = self.circleAudioPlayer.center.y / self.view.bounds.maxY
      let relativeChange = dy/self.view.bounds.maxY
      self.circleAudioPlayer.center.y = (self.currentRelativeVerticalPosition + relativeChange) * self.view.bounds.maxY
    }
  }

  
  func pushCircleAudioPlayerToTheEndge(direction: UISwipeGestureRecognizerDirection) {
    var animation: ()->() = {}
    switch direction {
    case UISwipeGestureRecognizerDirection.left:
      animation = { self.circleAudioPlayer.center.x = 0 + self.circleAudioPlayer.bounds.width / 2}
    case UISwipeGestureRecognizerDirection.right:
      animation = { self.circleAudioPlayer.center.x = self.view.bounds.maxX -  self.circleAudioPlayer.bounds.width / 2}
    case UISwipeGestureRecognizerDirection.down:
      animation = { self.circleAudioPlayer.center.y = self.view.bounds.maxY - self.circleAudioPlayer.bounds.height / 2 }
    case UISwipeGestureRecognizerDirection.up:
      animation = { self.circleAudioPlayer.center.y = 0 + self.circleAudioPlayer.bounds.height / 2}
    default:
      break
    }
    //Animation during 0.5 seconds, with no delay, Acceleration at the Begin, deceleratin at the End
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut,
                   animations: animation, completion: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
  }
  
  @objc func deviceOrientationDidChange() {
    self.circleAudioPlayer.center.x = self.currentRelativeHorisontalPosition * self.view.bounds.maxX
    self.circleAudioPlayer.center.y = self.currentRelativeVerticalPosition * self.view.bounds.maxY
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  



}
