//
//  HomeViewController.swift
//  MarvelApi
//
//  Created by lapshop on 11/7/21.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
   
    var viewModel : HomeViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        setupCollectionView()
        setupSearchViewController()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        let navImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        navImageView.image = UIImage(named: "navItemImage")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.titleView  = navImageView
    }
    
    
    func setupSearchViewController() {
        
        guard  let searchviewController = UIUtitly.getSearchViewController() else {
            return
        }
        
        let searchController = UISearchController(searchResultsController: searchviewController)
        
        searchController.searchBar.barStyle = .black
        
        searchController.searchBar.rx
            .text
            .asDriver()
            .debounce(DispatchTimeInterval.milliseconds(1000))
            .drive(onNext: {
                guard let text = $0 , !text.isEmpty  else {
                    searchviewController.viewModel.onAction(action: .clearResults)
                    return
                }
                
                searchviewController.viewModel.onAction(action: .requestMarvelCharacter(name: text))
            }).disposed(by: disposeBag)
            
        self.navigationItem.searchController = searchController
    }
    
    private func setupCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "\(CharacterCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CharacterCollectionViewCell.self)")
    }
    
    
    private func setupObserver() {
        
        viewModel.stateObservable.drive(onNext: { [weak self] in
            guard let weakSelf = self else {return}
            switch $0 {
                case .gettingCharacters:
                    UIUtitly.showActivityIndicator(in: weakSelf.view)
                case .loadingCharacters:
                    UIUtitly.hideActivityIndicator()
                    weakSelf.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
        
    }
    
}



extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterCollectionViewCell.self)", for: indexPath) as? CharacterCollectionViewCell {
            let marvelChaaracter = viewModel.characters[indexPath.row]
            cell.configure(with: marvelChaaracter)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width - 45
        let itemWidth = width / 2
        
        return CGSize(width: itemWidth, height: itemWidth + 100)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let position = scrollView.contentOffset.y
        if position > collectionView.contentSize.height - collectionView.frame.height  {
            viewModel.onAction(action: .requestMoreCharacters)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        
        viewModel.onAction(action: .clickOnCharacter(viewController: self, charaterID: Int64(character.id)))
    }
    
    
   

    
}

