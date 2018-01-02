//
//  DesignableButtonView.swift
//  TestTaskLivatek
//
//  Created by October Hammer on 12/31/17.
//  Copyright © 2017 October Hammer. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet{
      self.layer.cornerRadius = cornerRadius
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet{
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor = UIColor.clear {
    didSet{
      self.layer.borderColor = borderColor.cgColor
    }
  }
  
}
