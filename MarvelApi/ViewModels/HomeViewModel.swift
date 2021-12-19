//
//  SearchViewModel.swift
//  MarvelApi
//
//  Created by lapshop on 11/9/21.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    var serviceWrapper : ServiceWrapper
    var characters : [MarvelCharacter] = []
    private var offset = 0
    private var viewState = BehaviorRelay<State>(value: .gettingCharacters)
    
   
    var stateObservable : Driver<State>   {
        return viewState.asDriver()
    }
    
    init(serviceWrapper: ServiceWrapper) {
        self.serviceWrapper = serviceWrapper
        requestAllMarvelCharacters()
    }
    
    enum State {
        case gettingCharacters
        case loadingCharacters
    }
        
    enum Action {
        case clickOnCharacter(viewController : UIViewController,charaterID:Int64)
        case requestMoreCharacters
    }
    
    func requestAllMarvelCharacters() {
        serviceWrapper.networkManager
            .getAllMarvelCharacters(endPoint: .getAllMarvelCharacters(offset: self.offset)) { [weak self] (result) in
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
    
    func presentCharacterComicsViewController(in viewController:UIViewController,characterId:Int64) {
        guard  let characterComicsViewController = UIUtitly.getCharacterComicViewController(characterId: characterId) else {
            return
        }
        
        viewController.present(characterComicsViewController, animated: true, completion: nil)
    }
    
    
    func onAction(action:Action)  {
        switch action {
        case .clickOnCharacter(let viewController,let characterID):
            presentCharacterComicsViewController(in: viewController, characterId: characterID)
            break
        case .requestMoreCharacters:
            viewState.accept(.gettingCharacters)
            requestAllMarvelCharacters()
        default:
            break
        }
    }
    
        
    
    
    
    
    
    
    
    
    
    
}
