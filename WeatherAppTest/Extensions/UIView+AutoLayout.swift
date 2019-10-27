//
//  UIView+AutoLayout.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import UIKit

// extension use for a private project

extension UIView {

    
    @discardableResult
    func autoSetTopSpace(space: CGFloat, withView view: UIView? = nil) -> NSLayoutConstraint? {
        guard let toView = view ?? self.superview else { return nil }
        let constrainingToSuperview = (toView == self.superview)
        let constraint = spaceConstraint(space: space,
                                         toView: toView,
                                         attribute1: .top,
                                         attribute2: (constrainingToSuperview ? .top : .bottom),
                                         relation: .equal)
        setConstraint(constraint: constraint, toView: toView)
        return constraint
    }
    
    @discardableResult
    func autoSetBottomSpace(space: CGFloat, withView view: UIView? = nil) -> NSLayoutConstraint? {
        guard let toView = view ?? self.superview else { return nil }
               let constrainingToSuperview = (toView == self.superview)
               let constraint = spaceConstraint(space: -space,
                                                toView: toView,
                                                attribute1: .bottom,
                                                attribute2: (constrainingToSuperview ? .bottom : .top),
                                                relation: .equal)
               setConstraint(constraint: constraint, toView: toView)
               return constraint
    }
    
    @discardableResult
    func autoSetLeftSpace(space: CGFloat, withView view: UIView? = nil) -> NSLayoutConstraint? {
        guard let toView = view ?? self.superview else { return nil }
               let constrainingToSuperview = (toView == self.superview)
               let constraint = spaceConstraint(space: space,
                                                toView: toView,
                                                attribute1: .left,
                                                attribute2: (constrainingToSuperview ? .left : .right),
                                                relation: .equal)
               setConstraint(constraint: constraint, toView: toView)
               return constraint
    }
    
    @discardableResult
    func autoSetRightSpace(space: CGFloat, withView view: UIView? = nil) -> NSLayoutConstraint? {
        guard let toView = view ?? self.superview else { return nil }
               let constrainingToSuperview = (toView == self.superview)
               let constraint = spaceConstraint(space: -space,
                                                toView: toView,
                                                attribute1: .right,
                                                attribute2: (constrainingToSuperview ? .right : .left),
                                                relation: .equal)
               setConstraint(constraint: constraint, toView: toView)
               return constraint
    }
    
    @discardableResult
    func autoSetHeight(height: CGFloat) -> NSLayoutConstraint? {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: height)
        setConstraint(constraint: constraint, toView: self)
        return constraint
    }
    
    @discardableResult
    func autoSetWidth(width: CGFloat) -> NSLayoutConstraint? {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: width)
        setConstraint(constraint: constraint, toView: self)
        return constraint
    }
    
}

private extension UIView {
    func spaceConstraint(space: CGFloat,
                         toView: UIView,
                         attribute1: NSLayoutConstraint.Attribute,
                         attribute2: NSLayoutConstraint.Attribute,
                         relation: NSLayoutConstraint.Relation ) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(item: self,
                                  attribute: attribute1,
                                  relatedBy: relation,
                                  toItem: toView,
                                  attribute: attribute2,
                                  multiplier: 1,
                                  constant: space)
    }
    
    func setConstraint(constraint: NSLayoutConstraint, toView view : UIView) {
        constraint.priority =  UILayoutPriority.init(Constants.defaultConstraintPriority)
        constraint.isActive = true;
    }
    
    enum Constants {
        static let defaultConstraintPriority: Float = 999
    }
}
