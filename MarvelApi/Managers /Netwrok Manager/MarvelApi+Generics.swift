//
//  MarvelApi+Generics.swift
//  MarvelApi
//
//  Created by lapshop on 11/8/21.
//

import Foundation



extension  MarvelApi {
    static func getData<T:Codable>(endPointURL : URL?,completion:@escaping (Result<ResponseModel<T>,CustomError>) -> Void){
        
        guard let url = endPointURL else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
              
            guard  error == nil else {
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let jsonDecode = JSONDecoder()
            
            let dd = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            print(dd)
            
            do {
                let responseData = try jsonDecode.decode(ResponseModel<T>.self, from: data)
                completion(.success(responseData))
            }catch {
                print(error)
                print(error.localizedDescription)
                completion(.failure(.errorDecodingResponse))
            }
        }.resume()
    }
}
