//
//  Array+Only.swift
//  Memorize
//
//  Created by om on 23/01/21.
//

import Foundation
extension Array
{
    var only:Element?
    {
        return count == 1 ? first : nil
    }
}
