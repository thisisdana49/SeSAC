//
//  Movie.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import Foundation

struct Movie {
    let ranking: String
    let title: String
    let date: String
}

let mockMovieLists: [Movie] = [
    Movie(ranking: "1", title: "파묘", date: "2024-02-22"),
    Movie(ranking: "2", title: "범죄도시4", date: "2024-04-24"),
    Movie(ranking: "3", title: "인사이드 아웃 2", date: "2024-06-12"),
    Movie(ranking: "4", title: "베테랑2", date: "2024-09-13"),
    Movie(ranking: "5", title: "파일럿", date: "2024-07-31"),
    Movie(ranking: "6", title: "웡카", date: "2024-01-31"),
    Movie(ranking: "7", title: "모아나 2", date: "2024-11-27"),
    Movie(ranking: "8", title: "소방관", date: "2024-12-04"),
    Movie(ranking: "9", title: "탈주", date: "2024-07-03"),
    Movie(ranking: "10", title: "핸섬가이즈", date: "2024-06-26")
]
