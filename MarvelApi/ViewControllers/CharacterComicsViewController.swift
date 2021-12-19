//
//  CharacterComicsViewController.swift
//  MarvelApi
//
//  Created by lapshop on 12/3/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CharacterComicsViewController: UIPageViewController {
    var disposeBag = DisposeBag()
    var viewModel : CharacterComicsViewModel!
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setupObservers()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "\(ComicImageCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ComicImageCollectionViewCell.self)")
        collectionView.delegate = self
        collectionView.dataSource  = self
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.height.equalTo(200)
        }
    }
    
    func setCurrentPageControllerContent() {
       
       guard let currentPageCotrollerContent = viewModel.getPageControllerContent() else {
           return
       }
       
       setViewControllers([currentPageCotrollerContent], direction: .forward, animated: true, completion: nil)
    }

    private func setupObservers() {
        viewModel.stateObservable.drive(onNext: { [weak self] in
            guard let weakself = self else {return }
            switch $0 {
            case .idle:
                break
            case .loadingComics:
                weakself.setCurrentPageControllerContent()
                weakself.collectionView.reloadData()
            case .getSpecificPage:
                weakself.setCurrentPageControllerContent()
            case .resetPageIndicators:
                weakself.collectionView.scrollToItem(at: IndexPath(row: weakself.viewModel.currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }).disposed(by:disposeBag )
    }
    
}

extension CharacterComicsViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewModel.getPreviousPageContent()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewModel.getNextPageContent()
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let  currentVC = pageViewController.viewControllers?.first as? ComicImageViewController else {
            return
        }
        
        viewModel.currentIndex  = currentVC.index
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel.comics.count
    }
    
}

 
extension CharacterComicsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ComicImageCollectionViewCell.self)", for: indexPath) as? ComicImageCollectionViewCell {
            let comic = viewModel.comics[indexPath.row]
            cell.configureCell(wuth: comic)
            cell.tag  = indexPath.row
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.onAction(action: .getSpecificPage(index: indexPath.row))
    }
    
}



