//
//  File.swift
//  Quizz3
//
//  Created by Mickael Pot on 09/12/2021.
//

import UIKit

class Home: UIViewController {
    
    //Gradient background
    @IBOutlet weak var backgroundGradientView: UIView!
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.02, green: 0.00, blue: 0.51, alpha: 1.00).cgColor,UIColor(red: 0.40, green: 0.00, blue: 0.42, alpha: 1.00).cgColor]
        gradientLayer.shouldRasterize = true
        backgroundGradientView.layer.addSublayer(gradientLayer)
        //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //Gradient background
    override var shouldAutorotate: Bool {
        return false
    }
    //
    
}
