//
//  UIVCExt+Nav.swift
//  FirebaseLab
//
//  Created by Amy Alsaydi on 3/3/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
    
    private static func resetWindow(_ rootViewController: UIViewController) {
        // UIApplication is a singleton to get all connected scenes
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window else {
                fatalError("could not reset window rootViewController")
        }
        
        window.rootViewController = rootViewController
        
        
    }
    
    public static func showViewController(storyBoardName: String, viewControllerId: String) {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let newVC = storyboard.instantiateViewController(identifier: viewControllerId)
        
        resetWindow(newVC)
        
    }
}
