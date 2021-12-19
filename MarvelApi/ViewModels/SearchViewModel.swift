//
//  SearchViewModel.swift
//  MarvelApi
//
//  Created by lapshop on 11/9/21.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    var serviceWrapper : ServiceWrapper
    var characters : [MarvelCharacter] = []
    private var offset = 0
    private var viewState = BehaviorRelay<State>(value: .noresults)
    private var searchWord : String = ""
    
   
    var stateObservable : Observable<State>   {
        return viewState.asObservable().observeOn(MainScheduler.asyncInstance)
    }
    
    init(serviceWrapper: ServiceWrapper) {
        self.serviceWrapper = serviceWrapper
    }
    
    enum State {
        case removingResults
        case noresults
        case loadingCharacters
    }
        
    enum Action {
        case clearResults
        case clickOnCharacter(CharaterID:Int)
        case requestMarvelCharacter(name:String)
    }
    
    func requestMarvelCharacter(name : String) {
        
        if self.searchWord != name  {
            self.offset = 0
            self.characters.removeAll()
        }
        
        serviceWrapper.networkManager
            .getAllMarvelCharacters(endPoint: .getMarvelCharacters(word: name, offset: self.offset)) { [weak self] (result) in
            guard let  weakSelf = self else { return }
            switch result  {
            case .success(let characters):
                weakSelf.characters.append(contentsOf: characters)
                weakSelf.offset += 20 
                weakSelf.viewState.accept(.loadingCharacters)
            case .failure(let customerError):
                print("failure--> \(customerError.description)")
            }
        
        }
    }
    
    func onAction(action:Action)  {
        switch action {
        case .clickOnCharacter(let CharaterID):
            break
        case .requestMarvelCharacter(let name):
            requestMarvelCharacter(name: name)
        case .clearResults:
            self.characters.removeAll()
            viewState.accept(.removingResults)
        default:
            break
        }
    }
    
        
    
    
    
    
    
    
    
    
    
    
}
