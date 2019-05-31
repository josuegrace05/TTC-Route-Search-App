//
//  DirectionTableViewCell.swift
//  MobileTTC
//
//  Created by Ringa - mac mini 2 on 29/05/19.
//  Copyright © 2019 Ringa - mac mini 2. All rights reserved.
//

import UIKit

class DirectionTableViewCell: UITableViewCell {

  @IBOutlet var directionName: UILabel!
  @IBOutlet var directionTitle: UILabel!
  @IBOutlet var directionBranch: UILabel!
  
  
  func setupCell(with directionData: RouteDirection){
    if let name  = directionData.name {
      directionName.text = "Name: " + "\(name)"
    } else {
      directionName.text = "Name: no name"
    }
    directionTitle.text = "Sense: " + "\(directionData.title)"
    directionBranch.text = "Branch: " + "\(directionData.branch)"
  }
  
}
