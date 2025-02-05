//
//  UserViewModel.swift
//  MVVMProject
//
//  Created by 조다은 on 2/5/25.
//

import Foundation

class UserViewModel {
    
    let people: Observable<[Person]> = Observable([])
 
    let inputLoadButtonTapped: Observable<Void> = Observable(())
    let inputAddButtonTapped: Observable<Void> = Observable(())
    let inputResetButtonTapped: Observable<Void> = Observable(())
    
    init() {
        inputLoadButtonTapped.bind { _ in
            self.people.value = self.generatePeople()
        }
        inputAddButtonTapped.bind { _ in
            self.people.value.append(self.generatePerson())
        }
        inputResetButtonTapped.bind { _ in
            self.people.value.removeAll()
        }
    }
    
    private func generatePeople() -> [Person] {
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func generatePerson() -> Person {
        let names = ["James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda", "William", "Elizabeth", "David", "Barbara", "Richard", "Susan", "Joseph", "Jessica", "Thomas", "Sarah", "Charles", "Karen"]
        return Person(name: names.randomElement()!, age: Int.random(in: 20...70))
    }
}
