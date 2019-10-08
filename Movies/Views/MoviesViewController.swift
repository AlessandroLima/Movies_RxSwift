//
//  MoviesViewController.swift
//  Movies
//
//  Created by alessandro on 07/10/19.
//  Copyright © 2019 alessandro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MoviesViewController: UIViewController {
    
    //MARK - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK - Properties
    private let disposeBag = DisposeBag()
    private var moviesListViewModel:MoviesListViewModel!
    
    var label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    //MARK - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    func application(application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        let windows = UIApplication.shared.windows
        
        for window in windows {
            window.removeConstraints(window.constraints)
        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK - TableView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        collectionView.backgroundView = moviesListViewModel == nil ? label : nil
        
        return moviesListViewModel == nil ? 0 : moviesListViewModel.moviesVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MoviesCollectionViewCell
        
        let movieVM = moviesListViewModel.moviesAt(indexPath.row)
        
        let processor = RoundCornerImageProcessor(cornerRadius: 0)
        
        movieVM.cover_url.subscribe(onNext:{
            cell.imgMovie.kf.setImage(with:  URL(string:$0), placeholder:UIImage(named: "placeHolder"), options: [.transition(.fade(0.5)),.processor(processor)] )
        }).disposed(by: disposeBag)
        
        movieVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.lblMovie.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieVM = moviesListViewModel.moviesAt(indexPath.row)
        let vc = DetailViewController()
        vc.movieViewModel = movieVM
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MoviesViewController{
    
    //MARK - Functions
    
    private func setupUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor(named: "main")
        
        
        let spacing:CGFloat = 6.0
        let cellSize = CGSize(width:(self.view.frame.size.width / 2) - spacing * 2  , height:320)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
        self.label.text = "Carregando filmes..."
        
    }
    
    private func populateMovies() {
        
        URLRequest.load(resource: Movies.all).subscribe(onNext:{[weak self] listMovies in
            
            guard let listMovies = listMovies else{
                return
            }
            self?.moviesListViewModel = MoviesListViewModel(listMovies.movies)
            
            DispatchQueue.main.async {
                
                self?.collectionView.reloadData()
            }
            
        }).disposed(by: disposeBag)
        
    }
}
