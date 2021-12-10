//
//  AfficheCategorie.swift
//  Quizz3
//
//  Created by Mickael Pot on 01/12/2021.
//

import UIKit

class AfficheCategorie: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Gradient background
    @IBOutlet weak var backgroundGradientView: UIView!
    //
    
    @IBOutlet weak var categorieSport: UIButton!
    @IBOutlet weak var categorieDivertissement: UIButton!
    @IBOutlet weak var categorieHistoire: UIButton!
    @IBOutlet weak var categorieGeographie: UIButton!
    @IBOutlet weak var categorieArtEtLitterature: UIButton!
    @IBOutlet weak var categorieNatureEtSciences: UIButton!
    @IBOutlet weak var afficheUser: UILabel!
    
    
    @IBAction func deconnexion(_ sender: UIButton){
        let afficheUserStoryBoard = UIStoryboard(name: "Utilisateur", bundle: nil)
        let categoryVC = afficheUserStoryBoard.instantiateViewController(withIdentifier: "utilisateurConnexion") as! ConnexionUtilisateur
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
                       
    var login: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.02, green: 0.00, blue: 0.51, alpha: 1.00).cgColor,UIColor(red: 0.40, green: 0.00, blue: 0.42, alpha: 1.00).cgColor]
        gradientLayer.shouldRasterize = true
        backgroundGradientView.layer.addSublayer(gradientLayer)
        //
        
//        login = UserDefaults.standard.string(forKey: "login")
        afficheUser.text = login
        
    }
    
    //Gradient background
    override var shouldAutorotate: Bool {
        return false
    }
    //
    
    //recuperer le text de l'UIBUTTON selectionné et faire persister la donnée
    
    @IBAction func choisiCategorie(_ sender: UIButton){
        let categorieChoisie = sender.titleLabel?.text
        
        UserDefaults.standard.set(categorieChoisie, forKey: "categorie")
        
        
        
        if categorieChoisie != "" {
            let questionStoryBoard = UIStoryboard(name: "Questions", bundle: nil)
            let categoryVC = questionStoryBoard.instantiateViewController(withIdentifier: "ConstruitUneQuestion") as! ConstruitUneQuestion
            self.navigationController?.pushViewController(categoryVC, animated: true)
        }
    }
}
