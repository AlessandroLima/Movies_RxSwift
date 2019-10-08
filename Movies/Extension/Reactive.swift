//
//  Reactive.swift
//  Movies
//
//  Created by alessandro on 08/10/19.
//  Copyright © 2019 alessandro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
    var isEmpty: Observable<Bool> {
        return observe(UIImage.self, "image").map{ $0 == nil }
    }
}
