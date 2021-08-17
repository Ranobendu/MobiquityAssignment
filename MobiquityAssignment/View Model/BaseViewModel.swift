//
//  BaseViewModel.swift
//  MobiquityAssignment
//
//  Created by Akash Pal on 16/08/21.
//

import Foundation

protocol ViewModelDelegate: class {
    func viewModelDidUpdate(sender: BaseViewModel)
    func viewModelUpdateFailed(error: Error)
}


class BaseViewModel {
    weak var delegate: ViewModelDelegate?
}
