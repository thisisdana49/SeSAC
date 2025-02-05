//
//  PersonViewModel.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/5/25.
//

import Foundation

class PersonViewModel {
    
    // TableView에 보여줄 데이터
    var people: Observable<[Person]> = Observable([])

    
    let inputLoadButtonTapped: Observable<Void> = Observable(())
    let inputResetButtonTapped: Observable<Void> = Observable(())
    
    let navigationTitle = "Person List"
    let resetTitle = "Reset Button"
    let loadTitle = "Load Button"
    
    init() {
        inputLoadButtonTapped.bind { _ in
            self.people.value = self.generateRandomPeople()
        }
        
        inputResetButtonTapped.bind { _ in
            self.people.value.removeAll()
        }
    }
    
    // MARK: - Helpers
    private func generateRandomPeople() -> [Person] {
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
}
