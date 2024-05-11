//
//  BaseView.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 11/05/24.
//


import UIKit

protocol BaseView: UIView {
    func addSubviews()
    func constrainSubviews()
    func additionalConfigurationSettings()
}
