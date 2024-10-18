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
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Search..."
        field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing
        field.returnKeyType = .search
        field.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        field.font = UIFont.systemFont(ofSize: 16)
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.systemGray.cgColor
        return field
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
        addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Consts.horizontalInsent)
            make.top.bottom.equalToSuperview()
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
        static let horizontalInsent = 10
    }
}
