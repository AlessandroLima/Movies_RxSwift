//
//  DetailViewController.swift
//  Movies
//
//  Created by alessandro on 08/10/19.
//  Copyright © 2019 alessandro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher


class DetailViewController: UIViewController {
    //MARK - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK - Properties
    var movieViewModel:MovieViewModel!
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(true)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
            
            let processor = RoundCornerImageProcessor(cornerRadius: 0)
            movieViewModel.cover_url.subscribe(onNext:{
                cell.movieImage.kf.setImage(with:  URL(string:$0), placeholder:UIImage(named: "placeHolder"), options: [.transition(.fade(0.5)),.processor(processor)] )
            }).disposed(by: disposeBag)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
            
            movieViewModel.title.asDriver(onErrorJustReturn: "")
                .drive(cell.lblTitle.rx.text)
                .disposed(by: disposeBag)
            
            movieViewModel.duration.asDriver(onErrorJustReturn: "")
                .drive(cell.lblDuration.rx.text)
                .disposed(by: disposeBag)
            
            movieViewModel.overview.asDriver(onErrorJustReturn: "")
                .drive(cell.lblOverview.rx.text)
                .disposed(by: disposeBag)
            
            movieViewModel.release_year.asDriver(onErrorJustReturn: "")
                .drive(cell.lblRelease_year.rx.text)
                .disposed(by: disposeBag)
            
            return cell
        }
        
    }
    
}
extension DetailViewController{
    
    private func setupUI(){
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
                
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
}
