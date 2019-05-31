//
//  Route.swift
//  MobileTTC
//
//  Created by Ringa - mac mini 2 on 29/05/19.
//  Copyright © 2019 Ringa - mac mini 2. All rights reserved.
//

import Foundation
import SWXMLHash

struct Route: XMLIndexerDeserializable {
  let tag:String
  let title:String
  let shortTitle:String?
  let color:String
  let oppositeColor:String
  let latMin:Double
  let latMax:Double
  let directions:[RouteDirection]
  let stops:[Stop]

  static func deserialize(_ node: XMLIndexer) throws -> Route {
      let attributes = node.element!.allAttributes
      return try Route (
        tag: attributes["tag"]!.text,
        title: attributes["title"]!.text,
        shortTitle: attributes["shortTitle"]?.text,
        color: attributes["color"]!.text,
        oppositeColor: attributes["oppositeColor"]!.text,
        latMin: Double(attributes["latMin"]!.text)!,
        latMax: Double(attributes["latMax"]!.text)!,
        directions: node["direction"].value(),
        stops: node["stop"].value()
      )
  }
}

struct RouteDirection: XMLIndexerDeserializable {
  let tag:String
  let title:String
  let name:String?
  let branch:String
  let stops:[Stop]
  
  static func deserialize(_ node: XMLIndexer) throws -> RouteDirection {
    return try RouteDirection(tag: node.value(ofAttribute: "tag"),
                         title: node.value(ofAttribute: "title"),
                         name: node.value(ofAttribute: "name"),
                         branch: node.value(ofAttribute: "branch"),
                         stops: node["stop"].value())
  }
}

struct Stop: XMLIndexerDeserializable {
  let tag:String
  let title:String?
  let shortTitle:String?
  let lat:Double?
  let long:Double?
  let stopId:Int?
  static func deserialize(_ node: XMLIndexer) throws -> Stop {
    return try Stop(tag: node.value(ofAttribute: "tag"),
                    title: node.value(ofAttribute: "title"),
                    shortTitle: node.value(ofAttribute: "shortTitle"),
                    lat: node.value(ofAttribute: "lat"), long: node.value(ofAttribute: "lon"), stopId: node.value(ofAttribute: "stopId"))
  }
  
}


