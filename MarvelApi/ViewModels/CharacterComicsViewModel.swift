//
//  CharacterComicsViewModel.swift
//  MarvelApi
//
//  Created by lapshop on 12/3/21.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit


class CharacterComicsViewModel {
    var serviceWrapper : ServiceWrapper
    var comics : [Comic] = []
    var currentIndex = 0 
    private var viewState = BehaviorRelay<State>(value: .idle)
    var characterID : Int64 = 0
    var stateObservable : Driver<State>   {
        return viewState.asDriver()
    }

    init(serviceWrapper: ServiceWrapper,characterID:Int64) {
        self.serviceWrapper = serviceWrapper
        self.characterID = characterID
        requestAllMarvelCharacterComics()
    }
    
    enum State {
        case idle 
        case loadingComics
        case getSpecificPage
        case resetPageIndicators
    }
        
    enum Action {
        case getSpecificPage(index:Int)
    }
    
    private func requestAllMarvelCharacterComics() {
        serviceWrapper.networkManager
            .getAllMarvelCharacterComics(endPoint: .getAllMarvelCharacterComics(ID: self.characterID)) { [weak self] (result) in
            guard let  weakSelf = self else { return }
            switch result  {
            case .success(let comics):
                weakSelf.comics.append(contentsOf: comics)
                weakSelf.viewState.accept(.loadingComics)
            case .failure(let customerError):
                print("failure--> \(customerError.description)")
            }
        
        }
    }
    

    func getPageControllerContent() -> ComicImageViewController? {
        guard let comicImageViewController = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(identifier: "ComicImageViewController") as? ComicImageViewController else {return nil}
        
        if let imageUrl = EndPoint.getNormalSizeMarvelCharacterImage(path: comics[currentIndex].thumbnail.path, extension: comics[currentIndex].thumbnail.fileExtension).url {
            comicImageViewController.url = imageUrl
        }
        comicImageViewController.index = currentIndex
        
        return comicImageViewController
    }
    
    
    func getPreviousPageContent() -> ComicImageViewController?{
        guard  currentIndex != 0 && currentIndex < comics.count else {
            return nil
        }
        currentIndex -= 1
        viewState.accept(.resetPageIndicators)
        return getPageControllerContent()
    }
    
    func getNextPageContent() -> ComicImageViewController? {
        guard  currentIndex != comics.count - 1 else {
            return nil
        }
        currentIndex += 1
        viewState.accept(.resetPageIndicators)
        return getPageControllerContent()
    }
    

    func onAction(action:Action) {
        switch action {
        case .getSpecificPage(let index):
            currentIndex = index
            viewState.accept(.getSpecificPage)
        }
    }
    
}
