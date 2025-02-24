//
//  ViewModel.swift
//  EveryLotto
//
//  Created by 조다은 on 2/24/25.
//

import Foundation
import RxCocoa
import RxSwift

final class ViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let pickerText: ControlProperty<String?>
        let selectPickerItem: Observable<Int>
        let editingDidEnd: ControlEvent<Void>
        let observableButtonTap: ControlEvent<Void>
        let singleButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let selectedItem: BehaviorSubject<String>
        let roundList: Observable<[Int]>
        let resultLotto: Driver<Lotto>
    }

    private let selectedItem = BehaviorSubject(value: "1154")
    private let roundList: BehaviorSubject<[Int]> = BehaviorSubject(value: Array(1...1154).reversed())
    private let resultLotto = PublishSubject<Lotto>()
    
    func transform(input: Input) -> Output {
        input.pickerText
            .orEmpty
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                print("touch up inside", value)
            }
            .disposed(by: disposeBag)
        
        input.editingDidEnd
            .bind(with: self) { owner, _ in
                print("editing did end")
            }
            .disposed(by: disposeBag)
        
        input.selectPickerItem
            .map { "\($0)" }
            .bind(with: self) { owner, value in
                owner.selectedItem.onNext(value)
            }
            .disposed(by: disposeBag)
        
        input.viewDidLoad
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(self.selectedItem)
            .distinctUntilChanged()
            .flatMap {
                NetworkManager.share.callLottoWithSingle(round: $0)
            }
            .bind(with: self) { owner, value in
                print("single button", value)
                owner.resultLotto.onNext(value)
            }
            .disposed(by: disposeBag)
        
        input.observableButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(self.selectedItem)
            .distinctUntilChanged()
            .flatMap {
                NetworkManager.share.callLotto(round: $0)
            }
            .bind(with: self) { owner, value in
                print("observable button", value)
                owner.resultLotto.onNext(value)
            }
            .disposed(by: disposeBag)
        
        input.singleButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(self.selectedItem)
            .distinctUntilChanged()
            .flatMap {
                NetworkManager.share.callLottoWithSingle(round: $0)
            }
            .bind(with: self) { owner, value in
                print("single button", value)
                owner.resultLotto.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(selectedItem: selectedItem,
                      roundList: roundList,
                      resultLotto: resultLotto.asDriver(onErrorDriveWith: .empty()))
    }
    
}
