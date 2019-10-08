//
//  RepositoriesRouter.swift
//  TesteJson
//
//  Created by Alessandro on 06/09/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

protocol RouterProtocol {
    func list()
}


class MoviesRouter: UINavigationController, RouterProtocol {
    
    // MARK: Properties
    
    var window: UIWindow?
    var moviesViewController:MoviesViewController?
    var detailViewController:DetailViewController?
    
    // MARK: Initializers
    
    convenience init(window: UIWindow?) {
        self.init()
        self.window = window
    }
    
    
    // MARK: Functions
    
    func list() {
        
        moviesViewController = MoviesViewController()
        if let vc = moviesViewController {
            vc.navigationItem.title = "Cine Sky"
            vc.title = "Cine Sky"
            viewControllers = [vc]
        }
        
        if let window = window {
            window.rootViewController = self
        }
    }
    
    
}
