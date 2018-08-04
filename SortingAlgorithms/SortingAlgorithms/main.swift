//
//  main.swift
//  SortingAlgorithms
//
//  Created by Gal Fudim on 8/3/18.
//  Copyright © 2018 Gal Fudim. All rights reserved.
//

import Foundation

func binarySearch(elements: [Int], target: Int) -> Int? {
    var leftIndex = 0
    var rightIndex = elements.count - 1
    while (leftIndex <= rightIndex) {
        let midIndex = (leftIndex + rightIndex) / 2
        if (target < elements[midIndex]) {
            rightIndex = midIndex - 1
        }
        else if (target > elements[midIndex]) {
            leftIndex = midIndex + 1
        }
        else {
            return midIndex
        }
    }
    return nil
}

func sequentialSearch(elements: [Int], target: Int) -> Int? {
    for index in 0..<elements.count {
        if (elements[index] == target) {
            return index
        }
    }
    return nil
}

func insertionSort(elements: [Int]) -> [Int] {
    var copy = elements
    for index in 0..<copy.count{
        var possibleIndex = index
        let temporary = copy[index]
        while (possibleIndex > 0 && temporary < copy[possibleIndex - 1]) {
            copy[possibleIndex] = copy[possibleIndex - 1]
            possibleIndex  -= 1
        }
        copy[possibleIndex] = temporary
    }
    return copy
}

func selectionSort(elements: [Int]) -> [Int] {
    var copy = elements
    for leftIndex in 0..<(copy.count - 1) {
        var minIndex = leftIndex
        for k in (leftIndex + 1)..<copy.count {
            if (copy[k] < copy[minIndex]) {
                minIndex = k
            }
            let temp = copy[leftIndex]
            copy[leftIndex] = copy[minIndex]
            copy[minIndex] = temp
        }
    }
    return copy
}
