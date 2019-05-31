//
//  NextBusAPI.swift
//  MobileTTC
//
//  Created by Ringa - mac mini 2 on 29/05/19.
//  Copyright © 2019 Ringa - mac mini 2. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class NextBusAPI {
  private static let basePathXML = "http://webservices.nextbus.com/service/publicXMLFeed?command="
  private static let agencyTag = "ttc"
  
  private struct APIError : XMLElementDeserializable {
    let message:String
    let shouldRetry:Bool
    
    static func deserialize(_ node: XMLIndexer) throws -> APIError {
        return try APIError(message: node.value(), shouldRetry:  node.value(ofAttribute: "shouldRetry"))
    }
  }
  
  class func searchRoute(with number: Int, onComplete: @escaping (Route?,Bool,String?) -> Void)  {
    let url = basePathXML + "routeConfig&a=" + agencyTag + "&r=\(number)" + "&terse"
    Alamofire.request(url).responseString { (response) in
      if let result = response.response, let data = response.result.value {
        if result.statusCode == 200 {
          let xml = SWXMLHash.parse(data)
          if let route:Route = try? xml["body"]["route"].value() {
            onComplete(route,true,nil)
          } else {
           onComplete(nil,false,"Oups. Could not find this route. Please, try another one.")
          }
        } else {
          let xml = SWXMLHash.parse(data)
          let error:APIError = try! xml["body"]["Error"].value()
          if error.shouldRetry {
            onComplete(nil,false,"API not avalaible for now. Please, try again after 10 seconds.")
          } else {
           onComplete(nil,false,"Oups. Something went wrong with the parameters entered.")
          }
        }
      } else {
       onComplete(nil,false,"Oups. Something went wrong when requesting the webservice.Please, try again later.")
      }
    }
  }
  
  class func predictions(of stop:Stop, belogingTo routeTag:String, onComplete: @escaping ([Prediction]?,Bool,String?) -> Void)  {

    let url = basePathXML + "predictions&a=" + agencyTag + "&stopId=\(stop.stopId!)&routeTag=\(routeTag)"
    let convertedURL = URL(string:url)!
    Alamofire.request(convertedURL).responseString { (response) in
      if let result = response.response, let data = response.result.value {
        if result.statusCode == 200 {
          let xml = SWXMLHash.parse(data)
          let values = xml["body"]["predictions"].children
          var predictions:[Prediction] = []
          for child in values {
            let directionTit = child.element!.allAttributes["title"]!.text
            let inner = child.children
            for elt in inner {
              let attrs = elt.element!.allAttributes
              let pred = Prediction(directionTitle: directionTit, seconds: Double(attrs["seconds"]!.text)!, minutes: Double(attrs["minutes"]!.text)!, epochTime: Double(attrs["epochTime"]!.text)!, dirTag: attrs["dirTag"]?.text)
              predictions.append(pred)
            }
          }
          onComplete(predictions,true,nil)
        } else {
          let xml = SWXMLHash.parse(data)
          let error:APIError = try! xml["body"]["Error"].value()
          if error.shouldRetry {
            onComplete(nil,false,"API not avalaible for now. Please, try again after 10 seconds.")
          } else {
            onComplete(nil,false,"Oups. Something went wrong with the parameters entered.")
          }
        }
      } else {
        onComplete(nil,false,"Oups. Something went wrong when requesting the webservice.Please, try again later.")
      }
    }
  }
}
