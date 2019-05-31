//
//  ViewController.swift
//  MobileTTC
//
//  Created by Ringa - mac mini 2 on 28/05/19.
//  Copyright © 2019 Ringa - mac mini 2. All rights reserved.
//

import UIKit

class SearchRouteViewController : UIViewController {

  @IBOutlet var routeNumber: UITextField!
  @IBOutlet var errorMessage: NSLayoutConstraint!
  @IBOutlet var errorMessageLbl: UILabel!
  @IBOutlet var errorMessageView: UIView!
  @IBOutlet var loadingActivity: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let routeData = sender as? Route, let nextViewController = segue.destination as? RouteViewController {
      nextViewController.route = routeData
    }
  }
  
  private func performSearch(_ tccNumber:Int){
    NextBusAPI.searchRoute(with: tccNumber) { (route, success, error) in
      self.loadingActivity.stopAnimating()
      if success {
        self.performSegue(withIdentifier: "routeSegue", sender: route)
      } else {
        DispatchQueue.main.async {
          UIView.animate(withDuration: 1, animations: {
            self.errorMessageView.alpha = 1
            self.errorMessage.constant = 30
            self.errorMessageLbl.text = error
            self.view.layoutIfNeeded()
          })
        }
      }
    }
  }

  @IBAction func searchRoute(_ sender: UIButton) {
    if let routeNumber = Int(routeNumber.text!) {
      loadingActivity.startAnimating()
      performSearch(routeNumber)
      self.routeNumber.resignFirstResponder()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  
  }
  
  @IBAction func closeErrorMessage(_ sender: UIButton) {
    UIView.animate(withDuration: 1, animations: {
      self.errorMessageView.alpha = 0
      self.errorMessage.constant = 0
      self.view.layoutIfNeeded()
    })
  }
}

