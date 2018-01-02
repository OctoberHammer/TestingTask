//
//  APAudioPlayer.swift
//  TestTaskLivatek
//
//  Created by October Hammer on 12/29/17.
//  Copyright © 2017 October Hammer. All rights reserved.
//

import UIKit
import AVFoundation






@IBDesignable class CircleAudioPlayer: UIView {
  //MARK: -
  //MARK: Helping Enum
  enum PlayerStates {
    case uninitialised
    case fetching
    case playing
    case paused
    case completed
    
    var description: String {
      switch self {
      case .uninitialised:
        return "Tap me to play"
      case .fetching:
        return "fetching..."
      case .playing:
        return "Pause"
      case .paused:
        return "Play"
      case .completed:
        return ""
      }
    }
    
  }

  //MARK: -
  //MARK: Properties
  @IBInspectable var fraction: CGFloat = 0.0 {
    didSet{
      if fraction >=  1.0 {
        fraction = 0.0
        self.state = .completed
      }
      setNeedsDisplay()
      setNeedsLayout()
      if fraction == 0 {
        self.timer.invalidate()
      }
    }
    
  }

  @IBInspectable var centerBtnRadius: CGFloat = 40 {
    didSet{
      setNeedsDisplay()
      setNeedsLayout()
    }
  }

  private var state: PlayerStates = .uninitialised {
    didSet{
      setNeedsDisplay()
      setNeedsLayout()
    }
  }
  private var timer = Timer()
  private var player: Player?
  
  private lazy var stateLabel: UILabel = createStateLabe()
  
  private lazy var tapGestureRecognizer: UITapGestureRecognizer = createTapGestureRecognizer()
  
  @IBInspectable public var fractionColor: UIColor = .yellow
  @IBInspectable public var solidColor: UIColor = .orange
  @IBInspectable public lazy var radius: CGFloat = {return min(self.bounds.width / 2 , self.bounds.height / 2)}()
  
  //MARK: -
  //MARK: Custom drawing
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
    let solidGround = UIBezierPath(ovalIn: rect)
    solidColor.setStroke()
    solidColor.setFill()
    solidGround.stroke()
    solidGround.fill()
    drawProgressArc()
    //addPlayPauseBtn()
  }
  
  
  func setPlayer(_ player: Player) {
    self.player = player
    self.play()

  }

  override func layoutSubviews() {
    super.layoutSubviews()
    configureStateLabel()
    configureTapGestureRecognizer()
  }
  
  
  private func createTapGestureRecognizer() -> UITapGestureRecognizer {
    let tap = UITapGestureRecognizer(target: self, action: #selector(tappedInside))
    //tap.delegate = self
    self.addGestureRecognizer(tap)
    return tap
  }
  
  private func createStateLabe()-> UILabel {
    let label = UILabel()
    self.addSubview(label)
    return label
  }
  
  private func configureTapGestureRecognizer() {
    self.tapGestureRecognizer.numberOfTapsRequired = 1
  }
  
  private func configureStateLabel(){
    self.stateLabel.text = self.state.description
    //stateLabel.textColor = .green
    self.stateLabel.textAlignment = .center
    self.stateLabel.frame.size = CGSize.zero
    self.stateLabel.translatesAutoresizingMaskIntoConstraints = true
    self.stateLabel.sizeToFit()
    self.stateLabel.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
  }
  
  private func drawProgressArc() {
    let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    //let radius = min(self.bounds.width / 2 , self.bounds.height / 2)
    let startAngle: CGFloat = -(0.5 * .pi)
    let wholeThing: CGFloat = 2 * .pi
    let endAngle: CGFloat = startAngle + wholeThing * fraction
    var path  = UIBezierPath(arcCenter: center, radius: self.radius / 2 , startAngle: startAngle, endAngle: endAngle, clockwise: true)
    path.lineWidth = self.radius
    fractionColor.setStroke()
    path.stroke()
  }
  
  
  @objc private func tappedInside() {
    print("Has been tapped")
    //User can change only limited amount of states
    switch self.state {
    case .uninitialised: self.fetch()
    case .playing: self.pause()
    case .paused: self.play()
    default: self.doNothing()
    }
  }
  
  public func fetch() {
    self.state = .fetching
    self.player?.stop()
    self.player = nil
    print("Let's fetch a file")
  }
  
  
  
  private func pause() {
    self.state = .paused
    player?.pause()
    timer.invalidate()
    print("I'm paused")
  }

  private func play() {
    self.state = .playing
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
    self.player?.prepareToPlay()
    self.player?.play()
    print("I'm pplaying")
  }
  
  private func doNothing() {
    timer.invalidate()
    print("Have nothing to do")
  }
  
  @objc private func updateAudioProgressView() {
    self.fraction = player?.currentFraction ?? 0
  }
  //MARK: -
  //MARK:
  

  
  
  
  
  
  
  
  
    
}
