//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

class BoxOfficeViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let selectedDate: Observable<Date> = Observable(Date())
        let searchButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let boxOffice: Observable<[Movie]> = Observable([])
        let selectDate: Observable<String> = Observable("")
    }
    
    private var query = ""
    
    init() {
        print("BoxOfficeViewModel Init")
        input = Input()
        output = Output()
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
    
    private func transform() {
        input.selectedDate.bind { value in
            self.convertDate(value)
        }
        
        input.searchButtonTapped.lazyBind { _ in
            print(#function, self.query)
            self.callBoxOffice(date: self.query)
        }
    }
    
    func callBoxOffice(date: String) {
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Key.apiKey)&targetDt=\(date)"
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success.boxOfficeResult.dailyBoxOfficeList)
                print(#function, "call box office")
                self.output.boxOffice.value = success.boxOfficeResult.dailyBoxOfficeList
            case .failure(let failure):
                print(failure)
            }
        }
    }
        
    private func convertDate(_ date: Date) {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        let string = format.string(from: date)
        output.selectDate.value = string
        
        let format2 = DateFormatter()
        format2.dateFormat = "yyyyMMdd"
        query = format2.string(from: date)
    }
    
}
