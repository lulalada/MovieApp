//
//  SearchTextField.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import UIKit

// MARK: - SearchTextField
final class SearchTextField: UIView {
    
    // MARK: Outlets
    private lazy var blockView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow()
        view.layer.cornerRadius = Consts.Layouts.cornerRadius
        return view
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = Consts.Strings.placeholder
        field.clearButtonMode = .whileEditing
        field.returnKeyType = .search
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 16)
        return field
    }()
    
    private lazy var searchIconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Consts.Strings.imageName)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [searchIconView, textField])
        stackView.axis = .horizontal
        stackView.spacing = Consts.Layouts.spacing
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    var onSearch: ((String) -> Void)?
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: Setup View
    private func setupView() {
        backgroundColor = .white
        addSubview(blockView)
        
        blockView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blockView.addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Consts.Layouts.horizontalInsent)
        }
        
        searchIconView.snp.makeConstraints { make in
            make.size.equalTo(Consts.Layouts.starSize)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SearchTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onSearch?(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Consts
private extension SearchTextField {
    enum Consts {
        enum Strings {
            static let placeholder = "Search..."
            static let imageName = "search"
        }
        
        enum Layouts {
            static let horizontalInsent: CGFloat = 10
            static let starSize: CGFloat = 20
            static let spacing: CGFloat = 10
            static let cornerRadius: CGFloat = 15
        }
    }
}
