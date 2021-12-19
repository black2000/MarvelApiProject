//
//  SearchResultViewController.swift
//  MarvelApi
//
//  Created by lapshop on 11/27/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultViewController: UIViewController {
    
    var viewModel : SearchViewModel!
    var disposeBag = DisposeBag()
        
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.onAction(action: .clearResults)
    }
    
    
    
    func setupObservers() {
        viewModel.stateObservable.subscribe(onNext: { [weak self] in
            guard let weakself = self else {return }
            switch $0 {
            case .noresults:
                break
            case .removingResults:
                weakself.tableView.reloadData()
            case .loadingCharacters:
                weakself.tableView.reloadData()
            }
        }).disposed(by:disposeBag )
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(CharacterTableViewCell.self)", bundle: nil) , forCellReuseIdentifier: "\(CharacterTableViewCell.self)")
    }
    
}


extension SearchResultViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "\(CharacterTableViewCell.self)", for: indexPath) as? CharacterTableViewCell {
            let marvelCharacter = viewModel.characters[indexPath.row]
            cell.configureCell(with: marvelCharacter)
            return cell
        }
        return UITableViewCell()
    }
    
}
