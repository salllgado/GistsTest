//
//  GistDetailView.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 20/05/24.
//

import UIKit
import Hero

final class GistDetailView: UIView {
    
    private let gist: GistSimplified
    private static let avatarImageViewHeight: CGFloat = 88
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var fileIndicatorView: FileIndicatorView = {
        let view = FileIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(gist: GistSimplified) {
        self.gist = gist
        super.init(frame: .zero)
        
        addSubviews()
        constrainSubviews()
        additionalConfigurationSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    func addSubviews() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        addSubview(fileIndicatorView)
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            avatarImageView.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            avatarImageView.heightAnchor.constraint(
                equalToConstant: GistDetailView.avatarImageViewHeight
            ),
            avatarImageView.widthAnchor.constraint(
                equalToConstant: GistDetailView.avatarImageViewHeight
            )
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor,
                constant: 8
            ),
            userNameLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            userNameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            )
        ])
        
        NSLayoutConstraint.activate([
            fileIndicatorView.topAnchor.constraint(
                equalTo: userNameLabel.bottomAnchor,
                constant: 8
            ),
            fileIndicatorView.centerXAnchor.constraint(
                equalTo: centerXAnchor
            )
        ])
    }
    
    func additionalConfigurationSettings() {
        backgroundColor = .systemBackground
        
        isHeroEnabled = true
        isHeroEnabledForSubviews = true
        hero.modifiers = [.fade]
        
        avatarImageView.cacheImage(url: gist.userImageURL, defaultImage: nil)
        avatarImageView.layer.cornerRadius = GistDetailView.avatarImageViewHeight / 2
        userNameLabel.text = gist.userName
        
        avatarImageView.hero.id = "avatarImageViewAnimated_\(gist.id)"
        
        fileIndicatorView.clipsToBounds = true
        fileIndicatorView.layer.cornerRadius = 16 / 2
        fileIndicatorView.setup(itensCount: gist.getFileCountText())
    }
}
