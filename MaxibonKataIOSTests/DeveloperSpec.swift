//
//  DeveloperSpec.swift
//  MaxibonKataIOS
//
//  Created by Jose Manuel Márquez Pavón on 1/7/17.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class DeveloperSpec: XCTestCase {
    
    func testAll() {
        
        property("The number of maxibon than developer get always is positive") <- forAll { (i : Int) in
            
            let developer = Developer(name: "Juan", numberOfMaxibonsToGet: i)
            print("Developer: \(developer.numberOfMaxibonsToGet)")
            return developer.numberOfMaxibonsToGet >= 0
            
        }
    }
    
}
