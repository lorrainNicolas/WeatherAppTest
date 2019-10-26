//
//  Observable.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation

class Observable<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?  = nil
    private var hasToBeOnMainThread = false
    
    init(_ value: T) {
        self.value = value
    }
    
    var value: T {
        didSet {
            self.callBack()
        }
    }
    
    func bind(_ listener: @escaping Listener) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: @escaping Listener) {
        self.listener = listener
        callBack()
    }
    
    func dispatchOnMainThread() -> Observable{
        hasToBeOnMainThread = true
        return self
    }
}

private extension Observable {
    func callBack() {
        if hasToBeOnMainThread && !Thread.isMainThread  {
            DispatchQueue.main.async { [weak self] in
                self.flatMap { $0.listener?( $0.value) }
            }
        } else {
            listener?(value)
        }
    }
}
