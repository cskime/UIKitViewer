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

class HomeController {
    var input: LoadComponentsUseCaseInput?
}


// MARK: - HomeControllerProtocol

extension HomeController: HomeControllerProtocol {
    
    func initialize() {
        input?.load()
    }
}
