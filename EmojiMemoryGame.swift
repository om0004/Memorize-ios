//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by om on 21/01/21.
//

import SwiftUI
class EmojiMemoryGame:ObservableObject
{
    @Published private var model:MemoryGame<String>=EmojiMemoryGame.createMemoryGame()
    // MARK: - Access to model
    private static func createMemoryGame()->MemoryGame<String>
    {
        let emojis:[String]=["👻","🎃","🕷","😈","👽","👺"]
        return MemoryGame<String>(numberOfPair:emojis.count,score:0){pair in
            return emojis[pair]}
    }
    var cards:[MemoryGame<String>.Card]
    {
        return model.cards
    }
    // MARK: - Intent
    func choose(card:MemoryGame<String>.Card)
    {
        model.choose(card:card)
    }
    func resetGame()
    {
        model=EmojiMemoryGame.createMemoryGame()
    }
    var score:Int
    {
        return model.score
    }
    
}
