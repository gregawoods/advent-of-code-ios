//
//  Day22.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/22/20.
//

import Foundation

struct Day22: DayProtocol {

    func parseDecks(input: [String]) -> ([Int], [Int]) {
        let p2Index = input.firstIndex(of: "Player 2:")!
        let player1 = input[1...p2Index-1].map({ Int($0)! })
        let player2 = input[(p2Index+1)...].map({ Int($0)! })

        return (player1, player2)
    }

    func part1(_ input: [String]) -> Int {
        var (player1, player2) = parseDecks(input: input)
        var iterations = 0

        repeat {
            iterations += 1
            let p1Val = player1.removeFirst()
            let p2Val = player2.removeFirst()

            if p1Val > p2Val {
                player1.append(p1Val)
                player1.append(p2Val)
            } else {
                player2.append(p2Val)
                player2.append(p1Val)
            }
        } while player1.count > 0 && player2.count > 0

        let winner = player1.count > 0 ? player1 : player2
        return calculateScore(hand: winner)
    }

    func calculateScore(hand: [Int]) -> Int {
        var score = 0
        var index = 0

        for card in hand.reversed() {
            index += 1
            score += card * index
        }

        return score
    }

    // swiftlint:disable large_tuple
    func recursiveGame(player1 p1: [Int], player2 p2: [Int]) -> (winner: Int, p1: [Int], p2: [Int]) {
        var player1 = p1
        var player2 = p2
        var history: Set<[[Int]]> = []

        repeat {
            if history.contains([player1, player2]) {
                return (1, player1, player2)
            }
            history.insert([player1, player2])

            let p1Val = player1.removeFirst()
            let p2Val = player2.removeFirst()

            if p1Val <= player1.count && p2Val <= player2.count {
                let p1NewDeck = Array(player1[0...p1Val-1])
                let p2NewDeck = Array(player2[0...p2Val-1])
                let newGame = recursiveGame(player1: p1NewDeck, player2: p2NewDeck)
                if newGame.winner == 1 {
                    player1.append(p1Val)
                    player1.append(p2Val)
                } else {
                    player2.append(p2Val)
                    player2.append(p1Val)
                }
            } else if p1Val > p2Val {
                player1.append(p1Val)
                player1.append(p2Val)
            } else {
                player2.append(p2Val)
                player2.append(p1Val)
            }
        } while player1.count > 0 && player2.count > 0

        let winner = player1.count == 0 ? 2 : 1
        return (winner, player1, player2)
    }

    func part2(_ input: [String]) -> Int {
        let (player1, player2) = parseDecks(input: input)
        let game = recursiveGame(player1: player1, player2: player2)

        return calculateScore(hand: game.winner == 1 ? game.p1 : game.p2)
    }
}
