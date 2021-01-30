//
//  Grid.swift
//  Memorize
//
//  Created by om on 22/01/21.
//

import SwiftUI
struct Grid<Item:Identifiable,ItemView:View>:View
{
    private var items:[Item]
    private var viewForItem:(Item)->ItemView
    init(_ items:[Item],viewForItem:@escaping(Item)->ItemView)
    {
        self.items=items
        self.viewForItem=viewForItem
    }
    var body: some View
    {
        GeometryReader(content:
        {   geometry in
            let GridLayoutObject=GridLayout(itemCount:self.items.count,in:geometry.size)
            ForEach(items,content:
            {   item in
                viewForItem(item)
                .frame(width:GridLayoutObject.itemSize.width,height:GridLayoutObject.itemSize.height)
                .position(GridLayoutObject.location(ofItemAt:items.index(of:item)!))
            })
        })
    }
}


