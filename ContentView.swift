//
//  ContentView.swift
//  Memorize
//
//  Created by om on 20/01/21.
//

import SwiftUI
struct ContentView: View
{
    @ObservedObject var viewModel:EmojiMemoryGame=EmojiMemoryGame()
    var body: some View
    {
        return VStack(content:
        {
            Text("Score: \(viewModel.score)").font(Font.largeTitle)
            Grid(viewModel.cards)
            {
                card in
                SeeCard(card:card).onTapGesture(perform:
                {
                    withAnimation(.linear(duration:0.75))
                    {
                        viewModel.choose(card:card)
                    }
                })
                    .padding(5)
            }
            .foregroundColor(Color.orange)
            .padding()
            Button(action:{withAnimation(.easeInOut){viewModel.resetGame()}}, label: {Text("NewGame").font(Font.largeTitle)})
        })
    }
    }
struct SeeCard:View
{
    var card:MemoryGame<String>.Card
    @State private var animatedBonusRemaining:Double=0
    private func startBonusTimeAnimation()
    {
        animatedBonusRemaining=card.bonusRemaining
        withAnimation(.linear(duration:card.bonusTimeRemaining))
        {
            animatedBonusRemaining=0
        }
    }
    var body:some View
    {
        return GeometryReader(content:
        { geometry in
            if card.isFaceUp || !card.isMatched
            {
            ZStack(content:
            //to stack one over another
            {
                if card.isConsumingBonusTime
                {
                //to have a rectangle with rounded corners
                Pie(startAngle:Angle.degrees(0-90), endAngle:Angle.degrees(-animatedBonusRemaining*360-90)).padding(5).opacity(0.4)
                    .onAppear()
                    {
                        self.startBonusTimeAnimation()
                    }
                }
                else
                {
                    Pie(startAngle:Angle.degrees(0-90), endAngle:Angle.degrees(-card.bonusRemaining*360-90)).padding(5).opacity(0.4)
                }
                Text(card.content)//to print text
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(card.isMatched ? Animation.linear(duration:1.0).repeatForever(autoreverses:false):.default)
                .font(Font.system(size:equalSize(size:geometry.size)))
            })
            //.modifier(Cardify(isFaceUp:card.isFaceUp))
            .cardify(isFaceUp:card.isFaceUp)
            .transition(AnyTransition.scale)
            }
        })
        
    }
    private func equalSize(size:CGSize)->CGFloat
    {
        return min(size.height,size.width)*0.7
    }
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel:EmojiMemoryGame())
    }
}
