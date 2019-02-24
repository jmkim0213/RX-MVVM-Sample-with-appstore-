//
//  SearchHomeViewController.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchHomeViewController: KKBViewController {
    override var viewModel          : SearchHomeViewModel { return self.connector.getViewModel(type: SearchHomeViewModel.self) }
    
    @IBOutlet var tableView         : UITableView?
    
    var searchController            : UISearchController?             = nil
    var searchViewController        : SearchViewController? {
        return self.searchController?.searchResultsController as? SearchViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSearchControler()
        self.initTableView()
    }
    
    func initSearchControler() {
        guard let resultViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        resultViewController.delegate = self
        
        let searchController = UISearchController(searchResultsController: resultViewController)
        resultViewController.searchController = searchController
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            self.tableView?.tableHeaderView = searchController.searchBar
        }
        self.searchController = searchController
    }
    
    func initTableView() {
        guard let tableView = self.tableView else { return }
        tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.viewModel.cellTypes.bind(to: tableView.rx.items) { (tableView, row, cellType) in
            return tableView.configuredCell(cellType, for: IndexPath(row: row, section: 0))
        }.disposed(by: self.disposeBag)
        
        tableView.rx.modelSelected(SearchHomeCellType.self).bind { [weak self] cellType in
            guard let data = cellType.data as? SearchKeywordModel2 else { return }
            self?.searchViewController?.search(keyword: data.term)
        }.disposed(by: self.disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier {
        case "showDetailVCSG":
            guard let vc = segue.destination as? DetailViewController else { return }
            vc.appInfo = sender as? SoftwareModel
            
        default:
            break
        }
        
    }
}

extension SearchHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.cellTypes.value[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.cellTypes.value[indexPath.row].height
    }
}

extension SearchHomeViewController: SearchViewControllerDelegate {
    func appInfoDidSelected(_ appInfo: SoftwareModel) {
        self.performSegue(withIdentifier: "showDetailVCSG", sender: appInfo)
    }
}
