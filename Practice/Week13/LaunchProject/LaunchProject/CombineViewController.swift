//
//  CombineViewController.swift
//  LaunchProject
//
//  Created by 조다은 on 3/24/25.
//

/*
 RxSwift VS Combine
 
 Observable         - Publisher
 Observer           - Subscriber
 Subscribe          - Sink
 Disposable         - AnyCancellable / Cancellable
 dispose            - store
 PublishSubject     - PassThroughSubject
 BehaviorSubject    - CurrentValueSubject
 
 에러 생각X, next만 O => UI, 즉 RxCocoa
 bind, drive, relay
 Combine에는 UI 전용, RxCocoa와 같은 역할이 없음.
 */

import UIKit
import Combine

class CombineViewModel {
    
    // RxSwift DisposeBag
    var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let viewDidLoadTrigger = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        let list = CurrentValueSubject<[String], Never>([])
    }
    
    init() {
        let input = Input()
        input.viewDidLoadTrigger
            .sink { [weak self] _ in
//                <#code#>
            }
            .store(in: &cancellables)
    }
    
    func callRequest() {
        
    }
}


class CombineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
