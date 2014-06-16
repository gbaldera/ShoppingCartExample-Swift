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
        
        var results = db.executeQuery("SELECT p.*, c.quantity FROM products p JOIN cart c ON p.id = c.productid", withArgumentsInArray: nil)
        
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
    
    class func exists(product: Product) -> Bool
    {
        return self.getProduct(product.id) != nil
    }
    
    class func isEmpty() -> Bool
    {
        return self.totalProducts() == 0
    }
    
    class func clearCart() -> Bool
    {
        var success: Bool
        
        let db = FMDatabase(path:Db.getDatabasePath())
        
        db.open()
        success = db.executeUpdate("DELETE FROM cart", withArgumentsInArray: nil)
        db.close()
        
        return success
    }
    
    class func getProduct(productId: CInt) -> CartItem?
    {
        var item: CartItem?
        let db = FMDatabase(path:Db.getDatabasePath())
        
        db.open()
        
        var results = db.executeQuery("ELECT p.*, c.quantity FROM products p JOIN cart c ON p.id = c.productid where p.id = \(productId)", withArgumentsInArray: nil)
        
        while results.next()
        {
            var product = Product()
            product.id = results.intForColumn("id")
            product.name = results.stringForColumn("name")
            product.image = results.stringForColumn("image")
            product.price = results.doubleForColumn("price")
            
            item = CartItem(product: product, quantity: results.intForColumn("quantity"))
        }
        
        db.close()
        
        return item
        
    }
    
    class func addProduct(product: Product) -> Bool
    {
        return self.addProduct(product, quantity: 1)
    }
    
    class func addProduct(product: Product, quantity: CInt) -> Bool
    {
        var success: Bool
        
        let db = FMDatabase(path:Db.getDatabasePath())
        
        db.open()
        
        if let cartItem = self.getProduct(product.id)
        {
            success = db.executeUpdate("UPDATE cart set quantity = \(quantity) where productid = \(product.id)", withArgumentsInArray: nil)
        }
        else
        {
            success = db.executeUpdate("INSERT INTO cart (productid,quantity) VALUES (\(product.id),\(quantity))", withArgumentsInArray: nil)
        }
        
        db.close()
        
        return success
    }
}
