//
//  KarumiHQsSpec.swift
//  MaxibonKataIOS
//
//  Created by Jose Manuel Márquez Pavón on 1/7/17.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class KarumeHQsSpec: XCTestCase {
    
    func testAll() {
        
        property("The number of maxibons left can not be lower than two") <- forAll { (developer: Developer) in
         
            let karumiHQs = KarumiHQs()
            karumiHQs.openFridge(developer)
            return karumiHQs.maxibonsLeft > 2
        }
        
        property("When maxibon number <= 2 buy 10 maxibon more") <- forAll(Developer.arbitraryHungry) { (developer: Developer) in
            
            let karumiHQs = KarumiHQs()
            print("Developer eat: \(developer.numberOfMaxibonsToGet)")
            print("Before: \(karumiHQs.maxibonsLeft)")
            karumiHQs.openFridge(developer)
            print("After: \(karumiHQs.maxibonsLeft)\n")
            return karumiHQs.maxibonsLeft >= 10
        }
        
        property("If there are two or less maxibons pending after opening the fridge Karumi automatically buys 10 more")
            <- forAll(Developer.arbitraryHungry) { (developer: Developer) in
                let karumiHQs = KarumiHQs()
                let initialMaxibons = karumiHQs.maxibonsLeft
                let numOfMaxibons = developer.numberOfMaxibonsToGet
                let expectedMaxibons = self.maxibonsAfterOpeningTheFridgeAndBuy(initialMaxibons, numOfMaxibons)
                karumiHQs.openFridge(developer)
                return karumiHQs.maxibonsLeft == expectedMaxibons
        }
        
        property("If some developers get maxibons the maxibos left are greater 2")
            <- forAll() { (developers: ArrayOf<Developer>) in
                
                let karumiHQs = KarumiHQs()
                karumiHQs.openFridge(developers.getArray)
                return karumiHQs.maxibonsLeft >= 2
        }
        
        property("If some developers get maxibons the maxibos left are greater 2")
            <- forAll() { (developers: ArrayOf<Developer>) in
                
                let karumiHQs = KarumiHQs()
                karumiHQs.openFridge(developers.getArray)
                return karumiHQs.maxibonsLeft >= 2
        }
        
        property("If some developers get maxibons the maxibos left are espected")
            <- forAll() { (developers: ArrayOf<Developer>) in
                
                let karumiHQs = KarumiHQs()
                let initialMaxibons = karumiHQs.maxibonsLeft
                let expectedMaxibons = self.maxibonsAfterOpeningTheFridge(initialMaxibons, developers.getArray)
                karumiHQs.openFridge(developers.getArray)
                return karumiHQs.maxibonsLeft == expectedMaxibons
        }
    }
    
    fileprivate func maxibonsAfterOpeningTheFridge(_ initialMaxibons: Int, _ developers: [Developer])  -> Int {
        
        var maxibonLeft = initialMaxibons
        
        developers.forEach { developer in
            
            maxibonLeft -= developer.numberOfMaxibonsToGet
            
            if maxibonLeft < 0 {
                maxibonLeft = 0
            }
            
            if maxibonLeft <= 2 {
                maxibonLeft += 10
            }
        }
        
        return maxibonLeft
    }
    
    fileprivate func maxibonsAfterOpeningTheFridgeAndBuy(_ initialMaxibons: Int, _ maxibonsToGet: Int) -> Int {
        var expectedMaxibons = initialMaxibons - maxibonsToGet
        if expectedMaxibons < 0 {
            expectedMaxibons = 0
        }
        expectedMaxibons += 10
        return expectedMaxibons
    }
}
