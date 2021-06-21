//
//  AppCordinator.swift
//  Cat at App
//
//  Created by Prefect on 20.06.2021.
//  Copyright © 2021 Bohdan Tkachuk. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    private var window: UIWindow
    private var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let viewController = WelcomeVC.instantiate()
            viewController.showRules = self.showRules
            viewController.showCatBreedList = self.showCatBreedList
            
            self.navigationController = UINavigationController(rootViewController: viewController)
            
            self.window.rootViewController = self.navigationController
            self.window.makeKeyAndVisible()
        }
    }
    
    func showCatBreedList() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let viewController = BreedListVC.instantiate()
            viewController.showCatBreedList = { [weak self] id in
                self?.showBreedDetailed(with: id)
            }
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func showBreedDetailed(with id: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let viewController = BreedDetailedVC.instantiate()
            viewController.breed = K.breedsList[id]
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func showRules() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let viewController = RulesVC.instantiate()
            viewController.showQuiz = self.showQuiz
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func showQuiz() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let viewController = QuizVC.instantiate()
            viewController.showFinal = self.showFinal
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func showFinal() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let viewController = FinalScoreVC.instantiate()
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
}
