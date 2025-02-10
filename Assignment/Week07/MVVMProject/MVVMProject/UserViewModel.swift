//
//  UserViewModel.swift
//  MVVMProject
//
//  Created by 조다은 on 2/5/25.
//

import Foundation

class UserViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let loadTapped: Observable<Void> = Observable(())
        let addTapped: Observable<Void> = Observable(())
        let resetTapped: Observable<Void> = Observable(())
    }
    
    struct Output {
        let people: Observable<[Person]> = Observable([])
    }
        
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    private func transform() {
        input.loadTapped.bind { _ in
            self.output.people.value = self.generatePeople()
        }
        input.addTapped.bind { _ in
            self.output.people.value.append(self.generatePerson())
        }
        input.resetTapped.bind { _ in
            self.output.people.value.removeAll()
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
