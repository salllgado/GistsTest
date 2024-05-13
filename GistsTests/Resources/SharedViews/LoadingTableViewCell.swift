//
//  LoadingTableViewCell.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 13/05/24.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor.gray
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupSubviews() {
        addSubview(indicator)
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 16),
            indicator.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16),
            indicator.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 4),
            indicator.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -4),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        indicator.startAnimating()
    }
    
    override public func prepareForReuse() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
}
