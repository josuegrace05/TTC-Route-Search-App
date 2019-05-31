//
//  StopTableViewCell.swift
//  MobileTTC
//
//  Created by Ringa - mac mini 2 on 30/05/19.
//  Copyright © 2019 Ringa - mac mini 2. All rights reserved.
//

import UIKit

class StopTableViewCell: UITableViewCell {

  @IBOutlet var stopTitle: UILabel!
  @IBOutlet var stopTag: UILabel!
  @IBOutlet var stopExpectedTime: UILabel!
  
  func setupCell(with stopData:Stop){
    stopTitle.text = stopData.title
    stopTag.text = stopData.tag
  }
  
  func setupPredictions(_ predictions:[Prediction]) {
    
  }
}
