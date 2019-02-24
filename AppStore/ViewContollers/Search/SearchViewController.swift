//
//  SearchViewController.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol SearchViewControllerDelegate: class {
    func appInfoDidSelected(_ appInfo: SoftwareModel)
}

class SearchViewController: KKBViewController {
    override var viewModel              : SearchViewModel { return self.connector.getViewModel(type: SearchViewModel.self) }
    
    @IBOutlet var tableView             : UITableView?
    @IBOutlet var emptyView             : UIView?
    @IBOutlet var emptyKeywordLabel     : UILabel?

    weak var searchController           : UISearchController?
    weak var delegate                   : SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSearchController()
        self.initTableView()
        self.initEmptyView()
        self.initEmptyKeywordLabel()
    }
    
    func initSearchController() {
        guard let searchController = self.searchController else { return }
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.rx.text.orEmpty.skip(1).throttle(0.3, scheduler: MainScheduler.instance).distinctUntilChanged().bind { [weak self] keyword in
            self?.viewModel.loadRecent(keyword: keyword)
        }.disposed(by: self.disposeBag)
        
        searchController.searchBar.delegate = self
        searchController.searchBar.rx.searchButtonClicked.bind { [weak self] _ in
            guard let keyword = searchController.searchBar.text else { return }
            self?.search(keyword: keyword)
        }.disposed(by: self.disposeBag)
    }
    
    func initTableView() {
        guard let tableView = self.tableView else { return }
        tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.viewModel.cellTypes.bind(to: tableView.rx.items) { (tableView, row, cellType) in
            return tableView.configuredCell(cellType, for: IndexPath(row: row, section: 0))
        }.disposed(by: self.disposeBag)
        
        tableView.rx.modelSelected(SearchCellType.self).bind { [weak self] cellType in
            switch cellType {
            case .keyword(let model, _):
                self?.search(keyword: model.term)
            case .appInfo(let data):
                self?.delegate?.appInfoDidSelected(data)
            }
            
        }.disposed(by: self.disposeBag)
    }
    
    func initEmptyView() {
        guard let emptyView = self.emptyView else { return }
        self.viewModel.isHiddenEmptyViewObserver.bind(to: emptyView.rx.isHidden).disposed(by: self.disposeBag)
    }
    
    func initEmptyKeywordLabel() {
        guard let emptyKeywordLabel = self.emptyKeywordLabel else { return }
        self.searchController?.searchBar.rx.text.orEmpty.map { "'\($0)'" } .distinctUntilChanged().bind(to: emptyKeywordLabel.rx.text).disposed(by: self.disposeBag)
    }
}

extension SearchViewController {
    func search(keyword: String) {
        self.searchController?.searchBar.text = keyword
        self.emptyKeywordLabel?.text = keyword
        self.searchController?.isActive = true
        self.viewModel.loadAppInfo(keyword: keyword)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.cellTypes.value[indexPath.row].height
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard !text.isEmpty else { return true }
        return text.isHangulOnly
    }
}

extension SearchViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
    }
}
