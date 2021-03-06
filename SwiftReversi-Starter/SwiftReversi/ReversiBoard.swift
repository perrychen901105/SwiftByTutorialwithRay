//
//  ReversiBoard.swift
//  SwiftReversi
//
//  Created by chenzhipeng on 15/1/27.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

class ReversiBoard: Board {
    private (set) var blackScore = 0, whiteScore = 0
    private (set) var nextMove = BoardCellState.White
    private (set) var gameHasFinished = false
    private let reversiBoardDelegates = DelegateMulticast<ReversiBoardDelegate>()
    
    func addDelegate(delegate: ReversiBoardDelegate) {
        reversiBoardDelegates.addDelegate(delegate)
    }
    
    override init() {
        super.init()
    }
    
    init(board: ReversiBoard) {
        super.init(board: board)
        nextMove = board.nextMove
        blackScore = board.blackScore
        whiteScore = board.whiteScore
    }
    
    func isValidMove(location: BoardLocation) -> Bool {
        return isValidMove(location, toState: nextMove)
    }
    
    private func isValidMove(location: BoardLocation, toState: BoardCellState) -> Bool {
        // check the cell is empty
        if self[location] != BoardCellState.Empty {
            return false
        }
        
        // test whether the move surrounds any of the opponents pieces
        for direction in MoveDirection.directions {
            if moveSurroundsCounters(location, direction: direction, toState: toState) {
                return true
            }
        }
        
        return false
    }
    
    func makeMove(location: BoardLocation) {
        self[location] = nextMove
        for direction in MoveDirection.directions {
            flipOpponentsCounters(location, direction: direction, toState: nextMove)
        }
        switchTurns()
        gameHasFinished = checkIfGameHasFinished()
        whiteScore = countMatches { self[$0] == BoardCellState.White }
        blackScore = countMatches { self[$0] == BoardCellState.Black }
        reversiBoardDelegates.invokeDelegates { $0.boardStateChanged() }
    }
    
    // test whether black or white can make a move.
    private func checkIfGameHasFinished() -> Bool {
        return !canPlayerMakeMove(BoardCellState.Black) && !canPlayerMakeMove(BoardCellState.White)
    }
    
    private func canPlayerMakeMove(toState:BoardCellState) -> Bool {
        return anyCellsMatchCondition { self.isValidMove($0, toState: toState) }
    }
    
    func switchTurns() {
        var intendedNextMove = nextMove.invert()
        
        // only switch turns if the player can make a move
        if canPlayerMakeMove(intendedNextMove) {
            nextMove = intendedNextMove
        }
    }
    
    func setInitialState() {
        clearBoard()
        super[3,3] = .White
        super[4,4] = .White
        super[3,4] = .Black
        super[4,3] = .Black
        
        blackScore = 2
        whiteScore = 2
    }
    
    // determines whether a move to a specific location on the board would surround one or more of the opponent's pieces. Within the while loop, the code checks the required conditions:
    // 1 The neighboring cell must be occupied by a piece of the opposing color, and the following cell is the opposing color, in which case the while loop continues, or the following cell is the player's color, which means a group is surrounded.
    func moveSurroundsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) -> Bool {
        var index = 1
        var currentLocation = direction.move(location)
        
        while isWithinBounds(currentLocation) {
            let currentState = self[currentLocation]
            if index == 1 {
                // IMMEDIATE NEIGHBORS MUST BE the opponent's color
                if currentState != toState.invert() {
                    return false
                }
            } else {
                // if the player's color is reached, the move is valid
                if currentState == toState {
                    return true
                }
                
                // if an empty cell is reached give up!
                if currentState == BoardCellState.Empty {
                    return false
                }
            }
            index++
            
            // move to the next cell
            currentLocation = direction.move(currentLocation)
        }
        return false
    }
    
    private func flipOpponentsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) {
        // is this a valid move?
        if !moveSurroundsCounters(location, direction: direction, toState: toState) {
            return
        }
        
        let opponentsState = toState.invert()
        var currentState = BoardCellState.Empty
        var currentLocation = location
        
        // flip counters until the edge of the board is reached or apiece with the current state is reached
        do {
        currentLocation = direction.move(currentLocation)
        currentState = self[currentLocation]
        self[currentLocation] = toState
        } while (isWithinBounds(currentLocation) && currentState == opponentsState)
    }
    
}

