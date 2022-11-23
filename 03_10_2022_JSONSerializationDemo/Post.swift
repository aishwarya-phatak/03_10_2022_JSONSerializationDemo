//
//  Post.swift
//  03_10_2022_JSONSerializationDemo
//
//  Created by Vishal Jagtap on 17/11/22.
//

import Foundation
struct Post : Decodable{
    var id : Int
    var title: String
    var body : String
}


/*struct APIResponseForQuotes {
    var quotes : [Quote]
    var limit : Int
    var title : String
}

struct Quote {
    var id : Int
}*/
