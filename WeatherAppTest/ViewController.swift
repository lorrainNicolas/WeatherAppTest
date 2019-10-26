//
//  ViewController.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherAPI.getWeather() {
            print($0)
        }
        // Do any additional setup after loading the view.
    }


}

