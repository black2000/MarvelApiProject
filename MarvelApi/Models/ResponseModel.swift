//
//  ResponseModel.swift
//  MarvelApi
//
//  Created by lapshop on 11/9/21.
//

import Foundation


struct ResponseModel<T : Codable> : Codable {
    var data : MarvelData<T>
}

struct MarvelData<T : Codable> : Codable {
    var offset : Int
    var limit: Int
    var total: Int
    var count: Int
    var results : [T]
}

struct Comic : Codable {
    var id : Int
    var title : String
    var description : String?
    var thumbnail :  Thumbnail
}

struct MarvelCharacter : Codable {
    var id : Int
    var name : String
    var description : String?
    var thumbnail :  Thumbnail
}


struct Thumbnail : Codable {
    var path : String
    var fileExtension : String
    
    enum CodingKeys : String , CodingKey {
        case path
        case fileExtension = "extension"
    }
}





