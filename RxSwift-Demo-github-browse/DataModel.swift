//
//  DataModel.swift
//  RxSwift-Demo-github-browse
//
//  Created by Sean Yin on 2019/3/4.
//  Copyright © 2019 Sean Yin. All rights reserved.
//

import ObjectMapper
import RxDataSources

struct Owner:Mappable {
    var name:String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["login"]
    }
}

struct GitRepo:Mappable {
    
    var owner:Owner!
    var name:String!
    var isPrivate:Bool!
    var url:String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        owner <- map["owner"]
        name <- map["name"]
        isPrivate <- map["private"]
        url <- map["url"]
    }
}
