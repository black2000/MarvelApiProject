//
//  ServiceWrapper.swift
//  MarvelApi
//
//  Created by lapshop on 11/9/21.
//

import Foundation

class ServiceWrapper {
    
    var networkManager : NetworkManagerProtocol
    
    init(with networkManager : NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
}
