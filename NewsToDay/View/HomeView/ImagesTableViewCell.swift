//
//  ImagesTableViewCell.swift
//  NewsToDay
//
//  Created by deshollow on 25.03.2024.
//

import UIKit

class ImagesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let stringId = "ImagesCollectionViewCell"
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 256, height: 256)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)

        cv.register(
            SingleImageCollectonViewCell.self,
            forCellWithReuseIdentifier: SingleImageCollectonViewCell.stringId
        )
//        cv.showsHorizontalScrollIndicator = false

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
            make.height.equalTo(256)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SingleImageCollectonViewCell.stringId,
            for: indexPath
        ) as! SingleImageCollectonViewCell
        cell.configure(with: dataSource[indexPath.item])
        return cell
    }
    
    func configure(imgs: [String]) {
        dataSource = imgs
        
        collectionView.reloadData()
    }
    
}

class SingleImageCollectonViewCell: UICollectionViewCell {
    
    static let stringId: String = "SingleImageCollectonViewCell"
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(newsImageView)
        
        newsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    func configure(with name: String) {
        newsImageView.image = UIImage(named: name)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
    }
}

