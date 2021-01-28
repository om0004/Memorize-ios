//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by om on 23/01/21.
//

import Foundation
extension Array where Element:Identifiable
{
    func index(of item:Element)->Int?
    {
        for i in 0..<self.count
        {
            if item.id == self[i].id
            {
                return i
            }
        }
        return nil
    }
}
