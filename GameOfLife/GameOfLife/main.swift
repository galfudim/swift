//
//  main.swift
//  Game-Of-Life
//
//  Created by Gal Fudim on 11/21/2016.
//  Copyright © 2016 Gal Fudim. All rights reserved.
//

import Foundation

struct Cell: CustomStringConvertible, Hashable {
    let xCoor: Int
    let yCoor: Int
    
    var description: String {
        return "(\(xCoor), \(yCoor))"
    }
}

func == (left: Cell, right: Cell) -> Bool {
    return (left.xCoor == right.xCoor) && (left.yCoor == right.yCoor)
}

class Colony: CustomStringConvertible {
    
    var livingCells: Set<Cell> = []
    
    func setCellAlive(xCoor: Int, yCoor: Int) {
        livingCells.insert(Cell(xCoor: xCoor, yCoor: yCoor))
    }
    func setCellDead(xCoor: Int, yCoor: Int) {
        livingCells.remove(Cell(xCoor: xCoor, yCoor: yCoor))
    }
    func resetColony() {
        livingCells.removeAll()
    }
    
    func descripHelper(x: Int, y: Int) -> String {
        if (isCellAlive(xCoor: x, yCoor: y)) {
            return "*";
        } else {
            return ".";
        }
    }
    
    var description: String {
        var result = "Generation \(generation)\n"
        for z in 0...15 {
            let y = 15 - z;
            for x in 1...15 {
                result += descripHelper(x: x, y: y);
            }
            result += "\n"
        }
        return result;
    }
    
    var numberLivingCells: Int {
        return livingCells.count
    }
    
    
    func isCellAlive(xCoor: Int, yCoor: Int) -> Bool {
        return livingCells.contains(Cell(xCoor: xCoor, yCoor: yCoor))
    }
    
    func countAround(xCoor: Int, yCoor: Int) -> Int {
        var around = 0;
        if (xCoor < 20 && xCoor >= 0 && yCoor < 20 && yCoor >= 0) {
            if (livingCells.contains(Cell(xCoor: xCoor, yCoor: yCoor - 1))) {
                around += 1;
            }
            if (livingCells.contains(Cell(xCoor: xCoor, yCoor: yCoor + 1))) {
                around += 1;
            }
            if (livingCells.contains(Cell(xCoor: xCoor - 1, yCoor: yCoor))) {
                around += 1;
            }
            if (livingCells.contains(Cell(xCoor: xCoor + 1, yCoor: yCoor))) {
                around += 1;
            }
            if (livingCells.contains(Cell(xCoor: xCoor - 1, yCoor: yCoor + 1))) {
                around += 1;
            }
            if (livingCells.contains(Cell(xCoor: xCoor + 1, yCoor: yCoor + 1))) {
                around += 1;
            }
            if (livingCells.contains(Cell(xCoor: xCoor - 1, yCoor: yCoor - 1))) {
                around += 1;
            }
            if (livingCells.contains(Cell(xCoor: xCoor + 1, yCoor: yCoor - 1))) {
                around += 1;
            }
        } else {
            setCellDead(xCoor: xCoor, yCoor: yCoor);
        }
        return around;
    }
    
    func neighbors(xCoor: Int, yCoor: Int) -> [Cell] {
        return Array(arrayLiteral:
            Cell(xCoor: xCoor, yCoor: yCoor),
                     Cell(xCoor: xCoor, yCoor: yCoor - 1),
                     Cell(xCoor: xCoor, yCoor: yCoor + 1),
                     Cell(xCoor: xCoor - 1, yCoor: yCoor),
                     Cell(xCoor: xCoor + 1, yCoor: yCoor),
                     Cell(xCoor: xCoor - 1, yCoor: yCoor + 1),
                     Cell(xCoor: xCoor + 1, yCoor: yCoor + 1),
                     Cell(xCoor: xCoor - 1, yCoor: yCoor - 1),
                     Cell(xCoor: xCoor + 1, yCoor: yCoor - 1))
    }
    
    var generation = 0
    
    func decision(xCoor: Int, yCoor: Int, around: Int) -> Bool {
        let aliveCell = isCellAlive(xCoor: xCoor, yCoor: yCoor)
        if aliveCell && around < 2 {
            return false
        }
        if aliveCell && (around == 2 || around == 3) {
            return true
        }
        
        if aliveCell && around > 3 {
            return false
        }
        if !aliveCell && around == 3 {
            return true
        }
        
        return false
    }
    
    func evolve() {
        var cellsToCheck: Set<Cell> = []
        for z in livingCells {
            cellsToCheck = cellsToCheck.union(neighbors(xCoor: z.xCoor, yCoor: z.yCoor))
        }
        var nextGen: Set<Cell> = []
        for z in cellsToCheck {
            let around = countAround(xCoor: z.xCoor, yCoor: z.yCoor)
            if decision(xCoor: z.xCoor, yCoor: z.yCoor, around: around) {
                nextGen.insert(z)
            }
        }
        livingCells = nextGen
        generation += 1;
        
    }
}

var c = Colony()
c.setCellAlive(xCoor: 5, yCoor: 5)
c.setCellAlive(xCoor: 5, yCoor: 6)
c.setCellAlive(xCoor: 5, yCoor: 7)
c.setCellAlive(xCoor: 6, yCoor: 6)
print("Welcome to the Game of Life!")
print(" ")
for _ in 1...10 {
    print(c)
    c.evolve()
}
