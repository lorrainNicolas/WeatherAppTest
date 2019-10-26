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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewHierarchy()
        setConstraints()
        registerCell()
        WeatherAPI.getWeather() {
            print($0)
        }
        // Do any additional setup after loading the view.
    }
}

// MARK: -  UITableViewDataSource
extension WeatherHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHomeCell.reuseIdentifier, for: indexPath) as? WeatherHomeCell else {
            Log.warning("OUPS !!")
            return WeatherHomeCell()
        }
        
        cell.update(vm: WeatherHomeCellViewModel(title: "truc"))
        return cell
    }
}

// MARK: -  Build view
private extension WeatherHomeViewController {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableView.autoSetRightSpace(space: 0)
        tableView.autoSetLeftSpace(space: 0)
        tableView.autoSetTopSpace(space: 0)
        tableView.autoSetBottomSpace(space: 0)
    }
    
    func registerCell() {
        tableView.register(WeatherHomeCell.self, forCellReuseIdentifier: WeatherHomeCell.reuseIdentifier)
    }
}

// MARK: - Create views
private extension WeatherHomeViewController {

    func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }
}
