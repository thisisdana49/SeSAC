//
//  BaseViewModel.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 2/25/25.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}


class BaseViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    func transform(input: Void) -> Void {
        fatalError("")
    }
}
