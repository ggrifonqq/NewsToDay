//
//  HomeViewController.swift
//  NewsToDay
//
//  Created by deshollow on 20.03.2024.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - Properties
    
    private let topTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Browse"
        view.textColor = .black
        view.font = .systemFont(ofSize: 24, weight: .bold)
        view.numberOfLines = 0
        return view
    }()
    
    private let underTopTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Discover things of this world"
        view.textColor = .gray
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.numberOfLines = 0
        return view
    }()
    
    private var searchBar: UISearchBar!
    private var filterForSearchBar = [String]()
    
    private var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 200.0
        tv.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.stringId)
        tv.register(ImagesTableViewCell.self, forCellReuseIdentifier: ImagesTableViewCell.stringId)
        
        return tv
    }()
    
    //MARK: - Fake models
    
    private let centralImages = ["HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256", "HV_256x256"]
    private let newsCategories = ["Random", "Sports", "Gaming", "Politics", "Life", "Nature", "Animals", "Food", "Art", "Fashion", "History", "Covid-19", "Middle East"]
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupTopTitleLabel()
        setupUnderTopTitleLabel()
        setupTableView()
//        setupCategoriesButtons()
//        setupCentralImages()
        setupConstraints()
        
        self.searchBar?.delegate = self
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        centralImageCollectionView?.frame = CGRect(x: 0, y: 256, width: view.frame.size.width, height: 256).integral
//    }
    
    //MARK: - Public Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.stringId) as! CategoriesTableViewCell
            cell.configure(categories: newsCategories)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImagesTableViewCell.stringId) as! ImagesTableViewCell
            cell.configure(imgs: centralImages)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        if collectionView == self.centralImageCollectionView {
//            return centralImages.count
//        }
//        return newsCategories.count
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        if collectionView == self.centralImageCollectionView {
//            let centerImageCell = centralImageCollectionView?.dequeueReusableCell(withReuseIdentifier: SquareImageCollectionViewCell.identifier, for: indexPath) as! SquareImageCollectionViewCell
//            return centerImageCell
//        } else {
//            let categorieButtonCell = categorieButtonCollectionView?.dequeueReusableCell(withReuseIdentifier: CategorieButtonCollectionViewCell.identifier, for: indexPath) as! CategorieButtonCollectionViewCell
//            return categorieButtonCell
//        }
        
        //как сделать кнопку внутри?
//        centerImageCell.bookmarkButton.tag = indexPath.row
//        centerImageCell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonPressed), for: .touchUpInside)
//
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterForSearchBar.removeAll()
        guard searchText != "" || searchText != "" else {
            print("empty search")
            return
        }
        
        for item in newsCategories {
            let text = searchText.lowercased()
            let isArrayContain = item.lowercased().range(of: text)
            
            if isArrayContain != nil {
                print("Search complete")
                filterForSearchBar.append(item)
            }
        }
        print(filterForSearchBar)
    }
    
    //MARK: - Private Methods
    
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func setupTopTitleLabel() {
        view.addSubview(topTitleLabel)
    }
    
    private func setupUnderTopTitleLabel() {
        view.addSubview(underTopTitleLabel)
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(underTopTitleLabel.snp_bottomMargin).offset(0)
        }
    }
//
//    private func setupCategoriesButtons() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 50, height: 50)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        categorieButtonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        categorieButtonCollectionView?.register(CategorieButtonCollectionViewCell.self, forCellWithReuseIdentifier: CategorieButtonCollectionViewCell.identifier)
//
//        categorieButtonCollectionView?.showsHorizontalScrollIndicator = false
//        categorieButtonCollectionView?.delegate = self
//        categorieButtonCollectionView?.dataSource = self
//        guard let categorieButton = categorieButtonCollectionView else {
//            return
//        }
//        view.addSubview(categorieButton)
//    }
//
//    private func setupCentralImages() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 256, height: 256)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        centralImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        centralImageCollectionView?.register(SquareImageCollectionViewCell.self, forCellWithReuseIdentifier: SquareImageCollectionViewCell.identifier)
//
//        centralImageCollectionView?.showsHorizontalScrollIndicator = false
//        centralImageCollectionView?.delegate = self
//        centralImageCollectionView?.dataSource = self
//        guard let centralImage = centralImageCollectionView else {
//            return
//        }
//        view.addSubview(centralImage)
//    }
}

//MARK: - Extensions

extension HomeViewController {
    private func setupConstraints() {
        topTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(87)
            make.height.equalTo(32)
        }
        underTopTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(68)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(216)
            make.height.equalTo(24)
        }
//        searchBar.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
//        }
    }
}
