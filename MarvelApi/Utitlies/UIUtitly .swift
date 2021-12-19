//
//  UIUtitly .swift
//  MarvelApi
//
//  Created by lapshop on 11/10/21.
//

import Foundation
import UIKit


class UIUtitly {
    private static let activityIndicator = UIActivityIndicatorView()
    
    static func getHomeNavigationViewController() -> UINavigationController? {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let serviceWrapper = ServiceWrapper(with: MarvelApi())
        let homeViewModel = HomeViewModel(serviceWrapper: serviceWrapper)
        guard let homeViewController = storyBoard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {
            return nil
        }
        
        homeViewController.viewModel = homeViewModel
        let homeNavigationViewController = UINavigationController(rootViewController: homeViewController)
        return homeNavigationViewController
    }
    

    static func getSearchViewController() ->  SearchResultViewController? {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let serviceWrapper = ServiceWrapper(with: MarvelApi())
        let searchViewModel = SearchViewModel(serviceWrapper: serviceWrapper)
        guard let searchViewController = storyBoard.instantiateViewController(identifier: "SearchResultViewController") as? SearchResultViewController else {
            return nil
        }
        searchViewController.viewModel = searchViewModel
        return searchViewController
    }
    
    static func getCharacterComicViewController(characterId:Int64) ->  CharacterComicsViewController? {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let serviceWrapper = ServiceWrapper(with: MarvelApi())
        let characterComicViewModel = CharacterComicsViewModel(serviceWrapper: serviceWrapper, characterID:characterId)
        guard let characterComicsViewController = storyBoard.instantiateViewController(identifier: "CharacterComicsViewController") as? CharacterComicsViewController else {
            return nil
        }
        characterComicsViewController.viewModel = characterComicViewModel
        return characterComicsViewController
    }
    
    
    static func showActivityIndicator(in view:UIView) {
        activityIndicator.frame = view.frame
        activityIndicator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        activityIndicator.color = UIColor.black
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        view.addSubview(activityIndicator)
    }
    
    static func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
