//
//  StartScreenVC.swift
//  RPECalculator
//
//  Created by michele Miller on 11/07/17.
//
//

import UIKit

class StartScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.register(defaults: ["rounding":1.0])
        UserDefaults.standard.register(defaults: ["roundingDirection": "CLOSEST"])
        UserDefaults.standard.register(defaults: ["identifier": "kg"])

        // Do any additional setup after loading the view.
    }
 
}

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}
