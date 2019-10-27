//
//  DailyCell.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {
    
    private lazy var dateLabel = createDateLabel()
    private lazy var temperatureLabel = createTemperatureLabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        buildViewHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update( vm: DailyCellViewModel) {
        dateLabel.text = vm.dateString
        temperatureLabel.text = vm.tempeatureString
    }
}

// MARK: -  Build view
private extension DailyCell {
    func buildViewHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(temperatureLabel)
    }
    
    func setConstraints() {
        dateLabel.autoSetRightSpace(space: 0, withView: temperatureLabel)
        dateLabel.autoSetLeftSpace(space: 10)
        dateLabel.autoSetTopSpace(space: 0)
        dateLabel.autoSetBottomSpace(space: 0)
        
        temperatureLabel.autoSetRightSpace(space: 10)
        temperatureLabel.autoSetTopSpace(space: 0)
        temperatureLabel.autoSetBottomSpace(space: 0)
        temperatureLabel.autoSetWidth(width: 50)
    }
}

// MARK: - Create views
private extension DailyCell {
    func createDateLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func createTemperatureLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
