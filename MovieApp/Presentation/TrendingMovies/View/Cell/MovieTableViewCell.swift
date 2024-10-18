//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: Identifier
    static let identifier = "MovieTableViewCell"
    
    // MARK: Outlets
    private lazy var blockView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow()
        view.layer.cornerRadius = Consts.Layouts.cornerRadius
        return view
    }()
    
    private lazy var starIconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Consts.String.imageName)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method
    func setContent(title: String, year: String?) {
        titleLabel.text = title
        yearLabel.text = year
    }
}
// MARK: - UI setups
private extension MovieTableViewCell {
    func setupUI() {
        contentView.addSubview(blockView)
        blockView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Consts.Layouts.verticalInsent)
            make.height.equalTo(Consts.Layouts.blockHeight)
            make.leading.trailing.equalToSuperview().inset(Consts.Layouts.horizontalInsent)
        }
        
        blockView.addSubview(starIconView)
        starIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Consts.Layouts.stackInsent)
            make.centerY.equalToSuperview()
            make.size.equalTo(Consts.Layouts.starSize)
        }
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(yearLabel)
        
        blockView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.leading.equalTo(starIconView.snp.trailing).offset(Consts.Layouts.stackInsent)
            make.top.bottom.trailing.equalToSuperview().inset(Consts.Layouts.stackInsent)
        }
    }
}

// MARK: - Consts
private extension MovieTableViewCell {
    enum Consts {
        enum String {
            static let imageName = "star"
        }
        
        enum Layouts {
            static let horizontalInsent: CGFloat = 20
            static let verticalInsent: CGFloat = 10
            static let blockHeight: CGFloat = 70
            static let starSize: CGFloat = 20
            static let cornerRadius: CGFloat = 15
            static let stackInsent: CGFloat = 14
        }
    }
}
