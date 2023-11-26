//
//  HomeController.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import Foundation

protocol HomeControllerProtocol {
    func initialize()
}

struct HomeController {
    private let input: LoadComponentsUseCaseInput
    
    init(input: LoadComponentsUseCaseInput) {
        self.input = input
    }
}

extension HomeController: HomeControllerProtocol {
    
    func initialize() {
        
    }
}
