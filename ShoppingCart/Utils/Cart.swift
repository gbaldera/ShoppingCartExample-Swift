//
//  Cart.swift
//  ShoppingCart
//
//  Created by Jose Gustavo Rodriguez Baldera on 6/10/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

import Foundation

class Cart
{
    class func totalAmount() -> Double
    {
        var total: Double = 0
        let contents = self.contents()
        
        for item: CartItem in contents
        {
            total += (item.product!.price * Double(item.quantity))
        }
        
        return total
    }
    
    class func totalProducts() -> Int
    {
        var total: Int = 0
        let contents = self.contents()
        
        for item: CartItem in contents
        {
            total += Int(item.quantity)
        }
        
        return total
    }
    
    class func contents() -> CartItem[]
    {
        var contents = CartItem[]()
        
        let db = FMDatabase(path:Db.getDatabasePath())
        
        db.open()
        
        var results = db.executeQuery("SELECT p.*, c.quantity FROM products p JOIN cart c ON p.id = c.productid", withArgumentsInArray: [])
        
        while results.next()
        {
            var product = Product()
            product.id = results.intForColumn("id")
            product.name = results.stringForColumn("name")
            product.image = results.stringForColumn("image")
            product.price = results.doubleForColumn("price")
            
            contents.append(CartItem(product: product, quantity: results.intForColumn("quantity")))
        }
        
        db.close()
        
        return contents
    }
}
