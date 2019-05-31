//
//  StopsViewController.swift
//  MobileTTC
//
//  Created by Ringa - mac mini 2 on 30/05/19.
//  Copyright © 2019 Ringa - mac mini 2. All rights reserved.
//

import UIKit

class StopsViewController: UIViewController {

  @IBOutlet var stopTitle: UINavigationItem!
  var stops:[Stop]!
  var directionName:String!
  var directionTitle:String!
  var routeTag:String!
  var predictionsLoaded = false
  var stopsPredictions:[(Stop,[Prediction])] = []
  
  override func viewDidLoad() {
     super.viewDidLoad()
      stopTitle.title = "\(directionName!) direction stops"
    }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchStopsPredictions()
  }
  
  private func fetchStopsPredictions(){
    for stop in stops {
      if let _ = stop.stopId { // Not implemented
//        NextBusAPI.predictions(of: stop, belogingTo: routeTag) { (predictions, success, error) in
//          if success {
//            if let preds = predictions?.filter({$0.directionTitle == self.directionTitle}) {
//              self.stopsPredictions.append((stop,preds))
//            }
//          } else {
//            print(error!)
//          }
//        }
      }
    }
  }
}

extension StopsViewController : UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stops.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StopTableViewCell
    let stop = stops[indexPath.row]
    cell.setupCell(with: stop)
    return cell
  }
  
}
