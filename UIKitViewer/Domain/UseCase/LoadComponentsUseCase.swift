//
//  LoadComponents.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import Foundation

protocol LoadComponentsUseCaseInput {
    func load()
}

protocol LoadComponentsUseCaseOutput {
    func present(components: [Component])
}

struct LoadComponentsUseCase {
    
    private let output: LoadComponentsUseCaseOutput
    private let generator = ComponentGenerator()
}


// MARK: - LoadComponentsUseCaseInput

extension LoadComponentsUseCase: LoadComponentsUseCaseInput {
        
    func load() {
        let objects = UIKitObject.allCases
        let components = objects.map(generator.generate(for:))
        output.present(components: components)
    }
}
