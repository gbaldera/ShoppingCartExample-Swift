//
//  CartItem.swift
//  ShoppingCart
//
//  Created by Jose Gustavo Rodriguez Baldera on 6/10/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

import Foundation

class CartItem
{
    var product: Product?
    var quantity: CInt = 1
    
    init(product: Product?)
    {
        self.product = product
    }
    
    init(product: Product?, quantity: CInt)
    {
        self.product = product
        self.quantity = quantity
    }
}
