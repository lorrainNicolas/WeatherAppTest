//
//  DetailCell.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    private lazy var stackView = createStackView()
    private lazy var dateLabel = createDateLabel()
    private lazy var rainLabel = createRainLabel()
    private lazy var windLabel = createWindLabel()
    private lazy var temperatureLabel = createTemperatureLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.layer.borderWidth = 1
        buildViewHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(vm: DetailCellViewModel) {
        dateLabel.text = vm.dateString
        temperatureLabel.text = vm.tempeatureString
        rainLabel.text = vm.rainString
        windLabel.text = vm.windString
    }
}

// MARK: -  Build view
private extension DetailCell {
    func buildViewHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(rainLabel)
        stackView.addArrangedSubview(windLabel)
    }
    
    func setConstraints() {
        stackView.autoSetBottomSpace(space: 10)
        stackView.autoSetTopSpace(space: 10)
        stackView.autoSetLeftSpace(space: 10)
        stackView.autoSetRightSpace(space: 10)
        
        temperatureLabel.autoSetLeftSpace(space: 10)
        rainLabel.autoSetLeftSpace(space: 10)
        windLabel.autoSetLeftSpace(space: 10)
    }
}

private extension DetailCell {
    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func createDateLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
       
    func createTemperatureLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }
    
    func createRainLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }
    
    func createWindLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }
}
