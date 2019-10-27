//
//  DetailViewController.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private lazy var contentView = createContentView()
    private lazy var tableView = createTableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        buildViewHierarchy()
        setConstraints()
    }
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return  UITableViewCell()
    }
    
    
}

private extension DetailViewController {
    func buildViewHierarchy() {
        view.addSubview(contentView)
        contentView.addSubview(tableView)
    }
    
    func setConstraints() {
        let guide = self.view.safeAreaLayoutGuide
        contentView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
        tableView.autoSetLeftSpace(space: 0)
        tableView.autoSetRightSpace(space: 0)
        tableView.autoSetTopSpace(space: 0)
        tableView.autoSetBottomSpace(space: 0)
    }
    
    func registerCell() {
       // tableView.register(WeatherHomeCell.self, forCellReuseIdentifier: WeatherHomeCell.reuseIdentifier)
    }
    
}


// MARK: - Create views
private extension DetailViewController {
    func createContentView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }

    func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        return tableView
    }
}
