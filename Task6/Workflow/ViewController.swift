//
//  ViewController.swift
//  Task6
//
//  Created by Jarae on 27/9/23.
//

import UIKit

class ViewController: UIViewController {
    private lazy var productName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 38, weight: .bold)
        view.textAlignment = .center
        view.numberOfLines = 2
        view.text = "Pizza with Mushrooms"
        return view
    }()
    
    private lazy var productImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "pizza")
        return view
    }()
    
    private lazy var chooseSize: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 22, weight: .medium)
        view.textAlignment = .center
        view.text = "Choose the size"
        return view
    }()
    
    private lazy var totalPrice: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 26, weight: .medium)
        view.textColor = .systemGreen
        view.text = "$12"
        return view
    }()
    
    private lazy var addToCart: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Add to cart", for: .normal)
        view.backgroundColor = .orange
        view.tintColor = .white
        view.layer.cornerRadius = 15
        return view
    }()

    var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 8  // Расстояние между элементами
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var minusButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("-", for: .normal)
        view.tintColor = .black
        view.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var plusButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("+", for: .normal)
        view.tintColor = .black
        view.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var countLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "1"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 24, weight: .medium)
        return view
    }()
    
    let sizeOptions: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupStackView()
        setupCollectionView()
        setupNavigation()
    }
    
    @objc func minusButtonTapped() {
        let count = Int(countLabel.text ?? "0")!
        if count != 0 {
            countLabel.text = String(count - 1)
            updatePrice(count - 1)
        }
    }
    
    @objc func plusButtonTapped() {
        let count = Int(countLabel.text ?? "0")!
        countLabel.text = String(count + 1)
        updatePrice(count + 1)
    }
    
    @objc func likeProduct() {
        
    }
    
    func updatePrice(_ count: Int) {
        print(count)
        let price = Int(totalPrice.text ?? "12") ?? 12
        totalPrice.text = "$\(price * count)"
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(plusButton)
        
        stackView.backgroundColor = .systemGray5
        stackView.distribution = .fillEqually
    }
    
    func setupCollectionView() {
        sizeOptions.delegate = self
        sizeOptions.dataSource = self
        
        sizeOptions.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
    }
    
    func setupNavigation() {
        self.title = "Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .done,
            target: self,
            action: #selector(likeProduct)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .done,
            target: self,
            action: #selector(likeProduct)
        )
        
    }
    
    func setup() {
        view.backgroundColor = .white
        view.addSubviews(productName, productImage, chooseSize, sizeOptions, stackView, totalPrice, addToCart)
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            productName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            productName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            productImage.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 20),
            productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 300),
            productImage.heightAnchor.constraint(equalToConstant: 230),
            
            chooseSize.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 30),
            chooseSize.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sizeOptions.topAnchor.constraint(equalTo: chooseSize.bottomAnchor, constant: 20),
            sizeOptions.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sizeOptions.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sizeOptions.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: sizeOptions.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 70),
            stackView.widthAnchor.constraint(equalToConstant: 230),
            
            totalPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            totalPrice.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            
            addToCart.widthAnchor.constraint(equalToConstant: 180),
            addToCart.heightAnchor.constraint(equalToConstant: 61),
            addToCart.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addToCart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell
        cell.configure(with: "\(indexPath.item + 1)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
}


