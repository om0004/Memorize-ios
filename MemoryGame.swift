//
//  MemoryGame.swift
//  Memorize
//
//  Created by om on 21/01/21.
//
import Foundation
struct MemoryGame<CardContent> where CardContent:Equatable
{
    private(set) var cards:[Card]
    private(set) var score:Int=0
    var indexOfOnlyOneFaceUpCard:Int?
    {
        get
        {
            return cards.indices.filter{(index:Int)->Bool in cards[index].isFaceUp}.only
        }
        set
        {
            for x in cards.indices
            {
                if x==newValue
                {
                    cards[x].isFaceUp=true
                }
                else
                {
                    cards[x].isFaceUp=false
                }
            }
        }
    }
    mutating func choose(card:Card)
    {
        print("Card chosen\(card)")
        if let chosenIndex:Int=cards.index(of:card),!cards[chosenIndex].isFaceUp,!cards[chosenIndex].isMatched
        {
            if let potenialMatch=indexOfOnlyOneFaceUpCard
            {
                if cards[potenialMatch].content==cards[chosenIndex].content
                {
                    cards[potenialMatch].isMatched=true
                    cards[chosenIndex].isMatched=true
                    score=score+8
                }
                else
                {
                    score=score-1
                }
                cards[chosenIndex].isFaceUp=true
            }
            else
            {
                indexOfOnlyOneFaceUpCard=chosenIndex
            }
        }
    }
    init(numberOfPair:Int,score:Int,cardContentFactory:(Int)->CardContent)
    {
        cards=Array<Card>()
        for index in 0..<numberOfPair
        {
            let content=cardContentFactory(index)
            cards.append(Card(content:content,id:index*2))
            cards.append(Card(content:content,id:index*2+1))
        }
        cards.shuffle()
    }
    struct Card:Identifiable
    {
        var isFaceUp:Bool=false
        {
            didSet
            {
                if isFaceUp
                {
                    startUsingBonusTime()
                }
                else
                {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched:Bool=false
        {
            didSet
            {
                stopUsingBonusTime()
            }
        }
        var content:CardContent
        var id:Int
        var bonusTimeLimit:TimeInterval=6
        private var FaceUpTime:TimeInterval
        {
            if let lastFaceUpDate=self.lastFaceUpDate
            {
                return pastFaceUpTime+Date().timeIntervalSince(lastFaceUpDate)
            }
            else
            {
                return pastFaceUpTime
            }
        }
        var lastFaceUpDate:Date?
        var pastFaceUpTime:TimeInterval=0
        var bonusTimeRemaining:TimeInterval
        {
            max(0,bonusTimeLimit-FaceUpTime)
        }
        var bonusRemaining:Double
        {
            return (bonusTimeLimit>0&&bonusTimeRemaining>0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        var hasEarnedBonus:Bool
        {
            isMatched && bonusTimeRemaining>0
        }
        var isConsumingBonusTime:Bool
        {
            isFaceUp && !isMatched && bonusTimeRemaining>0
        }
        private mutating func startUsingBonusTime()
        {
            if isConsumingBonusTime,lastFaceUpDate==nil
            {
                lastFaceUpDate=Date()
            }
        }
        private mutating func stopUsingBonusTime()
        {
            pastFaceUpTime=FaceUpTime
            self.lastFaceUpDate=nil
        }
    }
}
