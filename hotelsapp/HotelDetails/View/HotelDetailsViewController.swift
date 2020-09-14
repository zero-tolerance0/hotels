//
//  HotelDetailsViewController.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit
import RxSwift

class HotelDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var refreshControl: UIRefreshControl!
    
    let disposeBag = DisposeBag()
    
    var viewModel: HotelDetailsViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControlConfigure()
        tableViewConfigure()
        bindViews()
    }
}

extension HotelDetailsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.output.hotelDetails.value != nil{
            return 3
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeue(HotelImageViewCell.self, indexPath: indexPath)
            
            let model = HotelImageViewCell.ViewModel(imageUrl: viewModel.output.hotelImageUrl ?? "")
            cell.fill(model)
            return cell
        case 1:
            let cell = tableView.dequeue(HotelDetailsTableViewCell.self, indexPath: indexPath)
            let titleText = viewModel.output.cellTitles[indexPath.row]
            let detailsText = viewModel.output.cellDetails[indexPath.row]
            let model = HotelDetailsTableViewCell.ViewModel(title: titleText, details: detailsText)
            cell.fill(model)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HotelDetailsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 90
        }
        return 120
    }
}

extension HotelDetailsViewController{
    func refreshControlConfigure(){
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
    }
    func tableViewConfigure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.registerNib(HotelImageViewCell.self)
        tableView.registerNib(HotelDetailsTableViewCell.self)
        tableView.showsVerticalScrollIndicator = false
    }
    
    func bindViews(){
        //MARK: -- bind activity indicator
        _ = viewModel.output.isBusy.bind(to: activityIndicator.rx.isAnimating)
        
        //MARK: -- bind Hotel Details
        _ = viewModel.output.hotelDetails.asObservable().subscribe(onNext: { [weak self] (hotelDetails) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        
        //MARK: -- bind refresh control
        _ = refreshControl.rx.controlEvent(.valueChanged).bind(to: viewModel.input.refreshControlAction)
        _ = viewModel.output.isBusy.bind(to: refreshControl.rx.isRefreshing)
    }
}
