//
//  WeatherHomeViewController.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import UIKit

class WeatherHomeViewController: UIViewController {
    private lazy var tableView = createTableView()
    private lazy var indicatorView = createIndicatorView()
    private lazy var informationHeader = createInformationHeaderLabel()
    private lazy var contentView = createContentView()
    
    private let controller: WeatherHomeHandler
    private var viewModel: WeatherHomeViewModel {
        return controller.viewModel
    }
    
    init(_ controller: WeatherHomeHandler = WeatherHomeController()) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewHierarchy()
        setConstraints()
        registerCell()
        bindView()
        
        controller.launch()
    }
}

// MARK: -  UITableViewDataSource
extension WeatherHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHomeCell.reuseIdentifier, for: indexPath) as? WeatherHomeCell else {
            Log.warning("OUPS !!")
            return UITableViewCell()
        }
        
        cell.update(vm: viewModel.cellViewModels.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
}

// MARK: -  UITableViewDataSource
extension WeatherHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellViewModels.value[indexPath.row].cellPressed?()
    }
}

// MARK: -  Build view
private extension WeatherHomeViewController {
    func buildViewHierarchy() {
        
        view.addSubview(contentView)
        contentView.addSubview(informationHeader)
        contentView.addSubview(tableView)
        contentView.addSubview(indicatorView)
    }
    
    func setConstraints() {
        let guide = self.view.safeAreaLayoutGuide
        contentView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  
        informationHeader.autoSetRightSpace(space: 0)
        informationHeader.autoSetLeftSpace(space: 0)
        informationHeader.autoSetTopSpace(space: 0)
        informationHeader.autoSetHeight(height: 50)
        
        tableView.autoSetRightSpace(space: 0)
        tableView.autoSetLeftSpace(space: 0)
        tableView.autoSetTopSpace(space: 0, withView: informationHeader)
        tableView.autoSetBottomSpace(space: 0)
        
        indicatorView.autoSetRightSpace(space: 0)
        indicatorView.autoSetLeftSpace(space: 0)
        indicatorView.autoSetTopSpace(space: 0)
        indicatorView.autoSetBottomSpace(space: 0)
    }
    
    func registerCell() {
        tableView.register(WeatherHomeCell.self, forCellReuseIdentifier: WeatherHomeCell.reuseIdentifier)
    }
    
    func bindView() {
        viewModel.cellViewModels.dispatchOnMainThread().bind { [weak self] _ in
            self?.tableView.reloadData()
        }
           
        viewModel.isLoading.dispatchOnMainThread().bind{ [weak self] in
            $0 ? self?.indicatorView.startAnimating() : self?.indicatorView.stopAnimating()
        }
        
        viewModel.informationHeader.dispatchOnMainThread().bindAndFire{ [weak self] in
            self?.informationHeader.text = $0
        }
    }
}

// MARK: - Create views
private extension WeatherHomeViewController {
    func createContentView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }
    
    func createInformationHeaderLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.borderWidth = 1
        return label
    }
    
    func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    func createIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }
}
