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


extension FileManager {
  
  // Merge several files
  func merge(files: [URL], to destination: URL, chunkSize: Int = 1000000) throws {
    
    FileManager.default.createFile(atPath: destination.path, contents: nil, attributes: nil)
    
    let writer = try FileHandle(forWritingTo: destination)
    try files.forEach({ partLocation in
      let reader = try FileHandle(forReadingFrom: partLocation)
      var data = reader.readDataToEndOfFile()
      while data.count > 0 {
        writer.write(data)
        data = reader.readDataToEndOfFile()
      }
      reader.closeFile()
    })
    writer.closeFile()
  }
}




extension String {
  var length: Int {
    return self.count
  }
  
  func substring(_ from: Int) -> String {
    return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
  }
}



func cast<Value, Result>(value: Value) -> Result? {
  return value as? Result
}


func cast<Value, Result>(value: Value) -> Result {
  return value as! Result
}
















