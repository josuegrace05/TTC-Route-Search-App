//
//  RouteViewController.swift
//  MobileTTC
//
//  Created by Ringa - mac mini 2 on 29/05/19.
//  Copyright © 2019 Ringa - mac mini 2. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController {
  var route:Route!
  
  @IBOutlet var routeTitle: UINavigationItem!
  @IBOutlet var contentView: UIView!
  @IBOutlet var routeTitleLbl: UILabel!
  @IBOutlet var ttcNumber: UILabel!
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let shortTitle = route.shortTitle {
      routeTitle.title = shortTitle
    } else {
      routeTitle.title = route.title
    }
    routeTitleLbl.text = route.title
    ttcNumber.text = route.tag
  }
  
  private func getAllStopsInfos(inThis direction:RouteDirection) -> [Stop] {
    var stops:[Stop] = []
    for stop in direction.stops {
      if let stop = route.stops.first(where: {$0.tag == stop.tag}) {
        stops.append(stop)
      }
    }
    return stops
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let nextViewController = segue.destination as? StopsViewController, let tuple = sender as? (stops:[Stop],directionName:String,directionTitle:String){
      nextViewController.directionName = tuple.directionName
      nextViewController.stops = tuple.stops
      nextViewController.directionTitle = tuple.directionTitle
      nextViewController.routeTag = route.tag
    }
  }

}

extension RouteViewController : UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return route.directions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DirectionTableViewCell
    let direction = route.directions[indexPath.row]
    cell.setupCell(with: direction)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let direction = route.directions[indexPath.row]
    let stops = getAllStopsInfos(inThis: direction)
    performSegue(withIdentifier: "stopsSegue", sender: (stops,direction.name,direction.title))
  }
}
