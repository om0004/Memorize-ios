//
//  Cardify.swift
//  Memorize
//
//  Created by om on 24/01/21.
//

import SwiftUI
struct Cardify:AnimatableModifier
{
    var rotation:Double
    init(isFaceUp:Bool)
    {
        rotation=isFaceUp ? 0 : 180
    }
    var isFaceUp:Bool
    {
        return rotation<90
    }
    var animatableData: Double
    {
        get {return rotation}
        set { rotation=newValue}
    }
    func body(content: Content) -> some View {
        ZStack(content:
        {
            Group
            {
                RoundedRectangle(cornerRadius:10.0).fill(Color.white)
                RoundedRectangle(cornerRadius:10.0).stroke(lineWidth:3.0)
                content
            }.opacity(isFaceUp ? 1 : 0)
           
                RoundedRectangle(cornerRadius:10.0).fill()
                    .opacity(isFaceUp ? 0 : 1)
            })
            .rotation3DEffect(Angle.degrees(rotation),axis:(0,1,0))
    }
    
}
extension View
{
    func cardify(isFaceUp:Bool)->some View
    {
        return self.modifier(Cardify(isFaceUp:isFaceUp))
    }
}
