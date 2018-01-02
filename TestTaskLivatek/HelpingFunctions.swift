//
//  HelpingFunctions.swift
//  TestTaskLivatek
//
//  Created by October Hammer on 12/29/17.
//  Copyright © 2017 October Hammer. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit



protocol Player {
  var currentFraction: CGFloat {
    get
  }
  
  func prepareToPlay() -> Bool
  
  func play() -> Bool
  
  func stop()
  
  func pause()
}


extension AVAudioPlayer: Player {
  var currentFraction: CGFloat {
    return CGFloat((self.currentTime)/(self.duration))
  }
}




func cast<Value, Result>(value: Value) -> Result? {
  return value as? Result
}


func cast<Value, Result>(value: Value) -> Result {
  return value as! Result
}
















