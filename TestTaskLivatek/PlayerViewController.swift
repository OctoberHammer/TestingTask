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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.complexGestureRecognizer = DragAndDropAndPushRecognizer(parentView: self.view, movableView: self.circleAudioPlayer)
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
  
  
  
  

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  



}
