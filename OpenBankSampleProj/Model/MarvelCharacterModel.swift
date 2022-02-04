//
//  MarvelCharacterModel.swift
//  OpenBankSampleProj
//
//  Created by Amrita on 28/01/22.
//

import Foundation

struct MarvelCharacterJsonData : Codable{
    //let code : NSNumber?
    /*let status : String?
    let copyright : String?
    let attributionText : String?
    let attributionHTML : String?
    let etag : String?*/
    let data : MarvelData
}
struct MarvelData : Codable{
//    let offset : Int?
//    let limit : Int?
//    let total : Int?
//    let count : Int?
    let results : [MarvelCharacter]
}

struct MarvelCharacter : Codable{
    
    let name : String?
    //let id : Int?
    let description : String?
   // let modified : String?
    let thumbnail : Thumbnail
    var fullImgPath : String {
        get {
            return thumbnail.path + "." + thumbnail.extensionImgPath
        }
    }
}
struct Thumbnail : Codable {
    let path : String
    let extensionImgPath : String
    
    enum CodingKeys: String, CodingKey {
        case extensionImgPath = "extension"
        case path = "path"
    }
}
