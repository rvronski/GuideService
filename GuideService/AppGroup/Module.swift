//
//  Module.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    
    enum ModuleType {
        case guide
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
}

