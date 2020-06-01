//
//  main.swift
//  StacksQueues
//
//  Created by Gal Fudim on 8/4/18.
//  Copyright © 2018 Gal Fudim. All rights reserved.
//

import Foundation

struct Stack <T>: CustomStringConvertible {
    private var data: [T]
    private var head: Int
    private let initialValue: T
    init(size: Int, initial: T) {
        data = [T](repeating: initial, count: size)
        initialValue = initial
        head = -1
    }
    
    init(data: [T]){
        self.data = data;
        initialValue = data[0]
        head = data.count - 1;
    }
    
    func isEmpty()-> Bool {
        return head == -1
    }
    
    func isFull() -> Bool {
        return head == data.count - 1
    }
    
    mutating func push(element: T) {
        if isFull() {
            return
        } else {
            head += 1
            data[head] = element
        }
    }
    
    mutating func pop() -> T? {
        if !isEmpty(){
            let temp = data[head];
            data[head] = initialValue
            head -= 1;
            return temp
        }
        return nil
    }
    
    func map<U>(f: (T) -> U) -> Stack<U> {
        var mappedItems = [U]()
        for item in data {
            mappedItems.append(f(item))
        }
        return Stack<U>(data: mappedItems)
    }
    
    var description: String {
        if head == -1 {
            return "Empty Stack"
        }
        var result = ""
        for i in 0...head {
            result = result + "\(data[i])" + " "
        }
        result += "H"
        return result
    }
    
}

struct Queue<T>: CustomStringConvertible {
    private var data: [T]
    private var head: Int
    private var tail: Int
    init(size: Int, initial: T) {
        self.data = [T](repeating: initial, count: size)
        self.head = 0
        self.tail = 0
    }
    
    init(data: [T], head: Int, tail: Int){
        self.data = data
        self.head = head
        self.tail = tail
    }
    
    func isEmpty()-> Bool {
        return head == tail
    }
    
    func isFull() -> Bool {
        return head == tail + data.count
    }
    
    mutating func enqueue(element: T) {
        if !isFull(){
            data[head%data.count] = element
            head += 1
        }
        
    }
    
    mutating func dequeue() -> T? {
        if isEmpty(){
            return nil;
        }
        
        let temp = data[tail%data.count]
        tail += 1;
        return temp
    }
    
    func map<U>(f: (T) -> U) -> Queue<U> {
        var mappedItems = [U](repeating: f(data[0]), count: data.count)
        for i in 0..<data.count {
            mappedItems.append(f(data[i]))
        }
        return Queue<U>(data: mappedItems, head: head, tail: tail)
    }
    
    var description: String {
        if head == -1 {
            return "Empty Queue"
        }
        var result = ""
        for i in tail..<head {
            result = result + "\(data[i])" + " "
        }
        result += "H"
        return result
    }
}
