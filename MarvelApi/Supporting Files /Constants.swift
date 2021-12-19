//
//  Constants.swift
//  MarvelApi
//
//  Created by lapshop on 11/8/21.
//

import Foundation
import UIKit


enum CustomError : Error {
    case badRequest
    case noData
    case errorDecodingResponse
}



extension CustomError : CustomStringConvertible {
    
    var description: String {
        switch  self {
        case .badRequest:
            return  "bad request"
        case .noData:
            return "no data to be fetched"
        case .errorDecodingResponse:
            return "couldnot decode the response"
        }
    }
    
   
}


extension Notification.Name {
   static let comicCellSelected = Notification.Name(rawValue: "comicCellSelected")
}

enum ImageSize : String {
    case portraitSmall  = "portrait_small"
    case portraitMedium   =  "portrait_medium"
    case portraitXlarge =  "portrait_xlarge"
    case portraitFantastic =  "portrait_fantastic"
    case portraitUncanny =  "portrait_uncanny"
    case portraitIncredible =  "portrait_incredible"
    
    case standardSmall  =  "standard_small"
    case standardMedium  = "standard_medium"
    case standardlarge  =  "standard_large"
    case standardxlarge =   "standard_xlarge"
    case standardFantastic =   "standard_fantastic"
    case standardAmazing =   "standard_amazing"
}

struct APISettings {
    static let publicApiKey = "bc976714e55c5c11dbdf7a7ff7f5cc86"
    static let privateApiKey = "893c310131859a166c9374a7b1e6d7c9b8317299"
    static let timeStamp  = Date.timeIntervalBetween1970AndReferenceDate
    static let hash = "\(timeStamp)\(privateApiKey)\(publicApiKey)".MD5()
}

enum EndPoint  {
    
    static let baseUrl = "https://gateway.marvel.com:443/v1/public"
    static let timeStampParameter = "&ts="
    static let apiKeyParameter = "&apikey="
    static let hashParameter = "&hash="

    static let offsetParameter = "offset="
    static let nameParameter = "&name="
    
    case getAllMarvelCharacters(offset:Int)
    case getMarvelCharacters(word:String,offset:Int)
    case getSizedMarvelCharacterImage(path:String,extension:String,imageSize:ImageSize)
    case getNormalSizeMarvelCharacterImage(path:String,extension:String)
    case getAllMarvelCharacterComics(ID:Int64)
    
    var url : URL? {
        
        if let url = URL(string:self.stringUrl) {
            return url
        }
        return nil
    }
    
    var stringUrl : String {
        switch self {
        case .getAllMarvelCharacters(let offset):
            return EndPoint.baseUrl + "/characters?" + EndPoint.offsetParameter + "\(offset)" + EndPoint.timeStampParameter + "\(APISettings.timeStamp)" + EndPoint.apiKeyParameter + APISettings.publicApiKey + EndPoint.hashParameter + APISettings.hash
        case .getSizedMarvelCharacterImage(let imagePath,let  ImageExtension,let  imageSize):
            return imagePath + "/\(imageSize.rawValue)" + "." + ImageExtension
        case .getMarvelCharacters( let word, let offset):
            return  EndPoint.baseUrl + "/characters?" + EndPoint.offsetParameter + "\(offset)" + EndPoint.nameParameter + "\(word)" + EndPoint.timeStampParameter + "\(APISettings.timeStamp)" + EndPoint.apiKeyParameter + APISettings.publicApiKey + EndPoint.hashParameter + APISettings.hash
        
        case .getAllMarvelCharacterComics(let ID):
            return EndPoint.baseUrl + "/characters" + "/\(ID)/comics?" + EndPoint.timeStampParameter + "\(APISettings.timeStamp)" + EndPoint.apiKeyParameter + APISettings.publicApiKey + EndPoint.hashParameter + APISettings.hash
            
        case .getNormalSizeMarvelCharacterImage(let imagePath,let imageExtension):
            return imagePath + "." + imageExtension
        }
    }
    
}
