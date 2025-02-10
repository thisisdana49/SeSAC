//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

class BoxOfficeViewModel: BaseViewModel { // 인터페이스
    
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
        transform()
//        callBoxOffice2(date: "20230505")
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
    
    internal func transform() {
        input.selectedDate.bind { value in
            self.convertDate(value)
        }
        
        input.searchButtonTapped.lazyBind { _ in
            print(#function, self.query)
            self.callBoxOffice2(date: self.query)
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
    
    private func callBoxOffice2(date: String) {
        print(#function)
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Key.apiKey)&targetDt=\(date)"

        let request = URLRequest(url: URL(string: url)!)
        print("===1:", Thread.isMainThread)
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("===2:", Thread.isMainThread)
            if let _ = error {
                print("오류 발생")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("상태코드 대응")
                return
            }
            
            if let data = data, let movieData = try? JSONDecoder().decode(BoxOfficeResult.self, from: data) {
                dump(movieData)
                self.output.boxOffice.value = movieData.boxOfficeResult.dailyBoxOfficeList
            } else {
                print("data 없음 또는 decoding 실패")
                return
            }
            
        }.resume()
    }
    
    private func callNasaAPI() {
        
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
