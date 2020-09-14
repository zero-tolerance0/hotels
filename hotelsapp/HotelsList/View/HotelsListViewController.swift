//
//  ViewController.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit
import RxSwift

class HotelsListViewController: UIViewController {
    
    let bag = DisposeBag()
    
    private var refreshControl: UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func handleSortButton(sender: UIBarButtonItem){
        handleSortAlert()
    }

    var viewModel: HotelsViewModelType!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControlConfigure()
        tableViewConfigure()
        bindViews()
    }
}

private extension HotelsListViewController{
    func handleSortAlert(){
        let actions: [UIAlertController.AlertAction] = [
            .action(title: "Sort by rating"),
            .action(title: "Sort by distance"),
            .action(title: "No Sort"),
            .action(title: "Отменить", style: .cancel)
        ]
        
        UIAlertController
            .present(in: self, title: nil, message: nil, style: .alert, actions: actions)
            .subscribe(onNext: { [weak self] buttonIndex in
                if let sortOption = SortOption(rawValue: buttonIndex){
                    self?.viewModel.input.handleSort(sortOption)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension HotelsListViewController: UITableViewDelegate{
    func refreshControlConfigure(){
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
    }
    func tableViewConfigure() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.registerNib(HotelCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.rx.setDelegate(self).disposed(by: bag)
    }
    
    func bindViews(){
        //MARK: -- bind table view
        viewModel.output.hotels.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: HotelCell.identifier   , cellType: HotelCell.self)) { (index, item, cell) in
            let model = HotelCell.ViewModel(name: item.name, address: item.address,
                                                   starsCount: item.stars, distanceAway: item.distance)
            cell.fill(model)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Hotel.self)
        .subscribe(onNext: { [weak self] item in
            self?.viewModel.input.moveToHotelDetails(item.id)
        })
        .disposed(by: bag)
        
        //MARK: -- bind activity indicator
        _ = viewModel.output.isBusy.bind(to: activityIndicator.rx.isAnimating)
        
        //MARK: -- bind refresh control
        _ = refreshControl.rx.controlEvent(.valueChanged).bind(to: viewModel.input.refreshControlAction)
        _ = viewModel.output.isBusy.bind(to: refreshControl.rx.isRefreshing)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
