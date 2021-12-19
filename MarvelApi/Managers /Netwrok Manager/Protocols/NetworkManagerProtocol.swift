//
//  NetworkManagerProtocol.swift
//  MarvelApi
//
//  Created by lapshop on 11/8/21.
//

import Foundation

protocol NetworkManagerProtocol {
    func getAllMarvelCharacters(endPoint:EndPoint,completion: @escaping ((Result<[MarvelCharacter],CustomError>) -> Void))
    
    func getAllMarvelCharacterComics(endPoint:EndPoint,completion: @escaping ((Result<[Comic],CustomError>) -> Void))
}
