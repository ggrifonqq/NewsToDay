//
//  CategoriesTableViewCell.swift
//  NewsToDay
//
//  Created by deshollow on 25.03.2024.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let stringId = "CategoriesCollectionViewCell"
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(
            SingleCategoryCollectonViewCell.self,
            forCellWithReuseIdentifier: SingleCategoryCollectonViewCell.stringId
        )
        cv.showsHorizontalScrollIndicator = false

        return cv
    }()
    private var dataSource: [String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.height.equalTo(50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SingleCategoryCollectonViewCell.stringId,
            for: indexPath
        ) as! SingleCategoryCollectonViewCell
        cell.configure(with: dataSource[indexPath.item])
        return cell
    }
    
    func configure(categories: [String]) {
        dataSource = categories
        collectionView.reloadData()
    }
}

class SingleCategoryCollectonViewCell: UICollectionViewCell {
    
    static let stringId: String = "SingleCategoryCollectonViewCell"
    
    private var back: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    private var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(back)
        addSubview(title)
        
        back.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    func configure(with str: String) {
        title.text = str
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
    }
}
