//
//  WeatherHomeCell.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import UIKit

class WeatherHomeCell: UITableViewCell {
    
    private lazy var label = createLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .green
        buildViewHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update( vm: WeatherHomeCellViewModel) {
        label.text = vm.title
    }
}

// MARK: -  Build view
private extension WeatherHomeCell {
    func buildViewHierarchy() {
        contentView.addSubview(label)
    }
    
    func setConstraints() {
        label.autoSetRightSpace(space: 0)
        label.autoSetLeftSpace(space: 0)
        label.autoSetTopSpace(space: 0)
        label.autoSetBottomSpace(space: 0)
       
        label.autoSetHeight(height: Constants.heightCell)
    }
}

// MARK: - Create views
private extension WeatherHomeCell {
    func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

private extension WeatherHomeCell {
    enum Constants {
        static let heightCell: CGFloat = 50
    }
}
