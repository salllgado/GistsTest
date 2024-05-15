//
//  GistListTableViewCell.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit

final class GistListTableViewCell: UITableViewCell {
    
    private let gist: GistSimplified
    private static let avatarViewHeight: CGFloat = 50.0
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var fileIndicatorView: FileIndicatorView = {
        let view = FileIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        return view
    }()
    
    init(gist: GistSimplified) {
        self.gist = gist
        super.init(style: .default, reuseIdentifier: nil)
        
        addSubviews()
        constrainSubviews()
        configureAdditionalSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(fileIndicatorView)
        contentView.addSubview(separatorView)
    }
    
    private func constrainSubviews() {
        constrainAvatarImageView()
        constrainUserNameLabel()
        constrainFileIndicatorView()
        constrainSeparatorView()
    }
    
    private func configureAdditionalSettings() {
        contentView.backgroundColor = .white
        avatarImageView.layer.cornerRadius = GistListTableViewCell.avatarViewHeight / 2
        
        // setup image view
        avatarImageView.cacheImage(url: gist.userImageURL, defaultImage: nil)
        avatarImageView.hero.id = "avatarImageViewAnimated_\(gist.id)"
        
        userNameLabel.text = gist.userName
        
        fileIndicatorView.clipsToBounds = true
        fileIndicatorView.layer.cornerRadius = 16 / 2
        fileIndicatorView.setup(itensCount: gist.getFileCountText())
    }
    
    // MARK: - Constrains
    private func constrainAvatarImageView() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),
            avatarImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            contentView.bottomAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor,
                constant: 8
            ),
            avatarImageView.widthAnchor.constraint(
                equalToConstant: GistListTableViewCell.avatarViewHeight
            )
        ])
    }
    
    private func constrainUserNameLabel() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),
            userNameLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 16
            ),
            userNameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor,
                constant: -16
            )
        ])
        
    }
    
    private func constrainFileIndicatorView() {
        NSLayoutConstraint.activate([
            fileIndicatorView.topAnchor.constraint(
                equalTo: userNameLabel.bottomAnchor,
                constant: 4
            ),
            fileIndicatorView.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 16
            )
        ])
    }
    
    private func constrainSeparatorView() {
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
