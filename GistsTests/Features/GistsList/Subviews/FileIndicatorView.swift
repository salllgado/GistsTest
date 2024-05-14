//
//  FileIndicatorView.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 13/05/24.
//

import UIKit

final class FileIndicatorView: UIView {
    
    private lazy var fileCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        constrainSubviews()
        configureAdditionalSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    private func addSubviews() {
        addSubview(fileCountLabel)
    }
    
    private func constrainSubviews() {
        NSLayoutConstraint.activate([
            fileCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            fileCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fileCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            fileCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            fileCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func configureAdditionalSettings() {
        backgroundColor = .lightGray
    }
    
    func setup(itensCount: String) {
        fileCountLabel.text = itensCount
    }
}
