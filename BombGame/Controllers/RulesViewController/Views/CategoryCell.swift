//
//  CategoryCollectionViewCell.swift
//  BombGame
//
//  Created by Kirill Taraturin on 09.08.2023.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    private lazy var mainView: UIView = {
        var view = UIView()
        
        view.backgroundColor = .purpleColor
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var circleView: UIView = {
        var view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var checkmarkSymbol: UILabel = {
        var checkmark = UILabel()
        
        checkmark.font = UIFont.systemFont(ofSize: 20)
        checkmark.text = "✓"
        checkmark.textColor = .purpleColor
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        
        return checkmark
    }()
    
    lazy var categoryImageView: UIImageView = {
        var imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    lazy var categoryLabel: UILabel = {
        var category = UILabel()
        
        category.font = UIFont.boldSystemFont(ofSize: 15)
        category.textColor = .yellowLabel
        category.numberOfLines = 0
        category.textAlignment = .center
        category.lineBreakMode = .byWordWrapping
        category.translatesAutoresizingMaskIntoConstraints = false
        
        return category
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(mainView)
        contentView.addSubview(circleView)
        
        circleView.addSubview(checkmarkSymbol)
        
        mainView.addSubview(categoryImageView)
        mainView.addSubview(categoryLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.cornerRadius = 60
        mainView.clipsToBounds = true
    }
    
    // MARK: Private Methods
    private func setupConstraints() {
        
        // setup constraints to mainView
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        // setup constraints to circleView
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 13
            ),
            circleView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 13
            ),
            circleView.heightAnchor.constraint(equalToConstant: 30),
            circleView.widthAnchor.constraint(equalToConstant: 30)
            
        ])
        
        // setup constraints to checkSymbol
        NSLayoutConstraint.activate([
            checkmarkSymbol.centerXAnchor.constraint(
                equalTo: circleView.centerXAnchor
            ),
            checkmarkSymbol.centerYAnchor.constraint(
                equalTo: circleView.centerYAnchor
            )
        ])
        
        // setup constraints to categoryImageView
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(
                equalTo: mainView.topAnchor,
                constant: 30
            ),
            categoryImageView.centerXAnchor.constraint(
                equalTo: mainView.centerXAnchor
            ),
            categoryImageView.widthAnchor.constraint(equalToConstant: 60),
            categoryImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // setup constraints to categorylabel
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(
                equalTo: categoryImageView.bottomAnchor,
                constant: 0
            ),
            categoryLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor, constant: 20
            ),
            categoryLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor, constant: -20
            ),
            categoryLabel.bottomAnchor.constraint(
                equalTo: mainView.bottomAnchor, constant: -5
            )
        ])
    }
    
    // MARK: - Public Methods
    func setupViews(_ category: CategoryRules) {
        categoryImageView.image = UIImage(named: category.image)
        categoryLabel.text = category.name
    }
}
