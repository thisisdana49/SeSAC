//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

class BoxOfficeViewModel {
    
    let inputSelectedDate: Observable<Date> = Observable(Date())
    let inputSearchButtonTapped: Observable<Void?> = Observable(nil)
    
    let outputBoxOffice: Observable<[Movie]> = Observable([])
    let outputSelectDate: Observable<String> = Observable("")
    
    private var query = ""
    
    init() {
        print("BoxOfficeViewModel Init")
        inputSelectedDate.bind { value in
            self.convertDate(value)
        }
        
        inputSearchButtonTapped.lazyBind { _ in
            print(#function, self.query)
            self.callBoxOffice(date: self.query)
        }
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
    
    func callBoxOffice(date: String) {
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Key.apiKey)&targetDt=\(date)"
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success.boxOfficeResult.dailyBoxOfficeList)
                print(#function, "call box office")
                self.outputBoxOffice.value = success.boxOfficeResult.dailyBoxOfficeList
            case .failure(let failure):
                print(failure)
            }
        }
    }
        
    private func convertDate(_ date: Date) {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        let string = format.string(from: date)
        outputSelectDate.value = string
        
        let format2 = DateFormatter()
        format2.dateFormat = "yyyyMMdd"
        query = format2.string(from: date)
    }
    
}
