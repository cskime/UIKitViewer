//
//  LoadComponents.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import Foundation

class LoadComponentsUseCase {
    
    // MARK: - Interface
    
    var output: LoadComponentsUseCaseOutput?
    
    
    // MARK: - Property
    
    private let generator = ComponentGenerator()
}


// MARK: - LoadComponentsUseCaseInput

extension LoadComponentsUseCase: LoadComponentsUseCaseInput {
        
    func load() {
        let objects = UIKitObject.allCases
        let components = objects.map(generator.generate(for:))
        let response = Response(components: components.map(\.name))
        output?.present(response: response)
    }
}
