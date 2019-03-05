//
//  SearchViewController.swift
//  RxSwift-Demo-github-browse
//
//  Created by Sean Yin on 2019/3/4.
//  Copyright © 2019 Sean Yin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class SearchViewController: UIViewController {
    
    @IBOutlet private var tableview:UITableView!
    
    private var searchController:UISearchController? = nil
    private var viewModel:SearchViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchViewModel()
        
        definesPresentationContext = true
        
        setSearchController()
        setTableView()
    }

    private func setSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController?.searchBar.rx.text
            .orEmpty
            .throttle(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.keywords)
            .disposed(by: disposeBag)
    }
    
    private func setTableView() {
     
        let nib = UINib.init(nibName: "RepoCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "RepoCell")
        
        viewModel.repos
            .asDriver(onErrorJustReturn: [])
            .drive(tableview.rx.items(cellIdentifier: "RepoCell", cellType: RepoCell.self)) { (_, repo, cell) in
                cell.setCell(data: repo)
            }
            .disposed(by: disposeBag)
        
        tableview.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension SearchViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
