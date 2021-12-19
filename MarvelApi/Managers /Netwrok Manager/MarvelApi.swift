//
//  MarvelApi.swift
//  MarvelApi
//
//  Created by lapshop on 11/8/21.
//

import Foundation

class MarvelApi :  NetworkManagerProtocol {
    
    func getAllMarvelCharacterComics(endPoint: EndPoint, completion: @escaping ((Result<[Comic], CustomError>) -> Void)) {
        
        guard  let url = endPoint.url else {
            return
        }
        
        MarvelApi.getData (endPointURL: url) { (result:Result<ResponseModel<Comic>,CustomError>) in
            switch result {
             case .success(let responseData):
                completion(.success(responseData.data.results))
             case .failure(let customError):
                completion(.failure(customError))
            }
            
        }
        
        
    }
    
    
    func getAllMarvelCharacters(endPoint: EndPoint, completion: @escaping ((Result<[MarvelCharacter], CustomError>) -> Void)) {
        
        guard  let url = endPoint.url else {
            return
        }
        
        MarvelApi.getData (endPointURL: url) { (result:Result<ResponseModel<MarvelCharacter>,CustomError>) in
            switch result {
             case .success(let responseData):
                completion(.success(responseData.data.results))
             case .failure(let customError):
                completion(.failure(customError))
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
