//
//  BirthDayViewModel.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/19/25.
//

import Foundation
import RxCocoa
import RxSwift

final class BirthDayViewModel {
    
    // ViewModel에서도 DisposeBag을 선언하고 사용할 수 있음.
    // VC는 VC꺼, VM은 VM
    let disposeBag = DisposeBag()
    
    struct Input {
        let birthday: ControlProperty<Date>
        let nextTap: ControlEvent<Void>
    }
    
    struct Output {
        let nextTap: ControlEvent<Void>
        let year: BehaviorRelay<Int>
        let month: BehaviorRelay<Int>
        let day: BehaviorRelay<Int>
    }
    
    func transform(input: Input) -> Output {
        
//        let year = BehaviorSubject(value: 2025)
//        let month = BehaviorSubject(value: 2)
//        let day = BehaviorSubject(value: 4)
        let year = BehaviorRelay(value: 2025)
        let month = BehaviorRelay(value: 2)
        let day = BehaviorRelay(value: 4)
        
        input.birthday
            .bind(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                year.accept(component.year!)
                month.accept(component.month!)
                day.accept(component.day!)
            }
            .disposed(by: disposeBag)
        
        return Output(nextTap: input.nextTap,
                      year: year,
                      month: month,
                      day: day)
    }
    
}
