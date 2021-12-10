//
//  CreerUnUtilisateur.swift
//  Quizz3
//
//  Created by Mickael Pot on 02/12/2021.
//

import UIKit

class CreerUnUtilisateur: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Gradient background
    @IBOutlet weak var backgroundGradientView: UIView!
    //
    
    
    
    @IBOutlet weak var login: UITextField!
    
    @IBOutlet weak var mdp: UITextField!
    @IBOutlet weak var mdpVerif: UITextField!
    
   
        
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.02, green: 0.00, blue: 0.51, alpha: 1.00).cgColor,UIColor(red: 0.40, green: 0.00, blue: 0.42, alpha: 1.00).cgColor]
        gradientLayer.shouldRasterize = true
        backgroundGradientView.layer.addSublayer(gradientLayer)
        //
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    //Gradient background
    override var shouldAutorotate: Bool {
        return false
    }
    //
    
    @IBAction func ajouteUnUtilisateur(){
        let loginUser=login.text
        let passwordUser=mdp.text
        let verifPassword=mdpVerif.text
        if(passwordUser != verifPassword){
            let alert = UIAlertController(title : "erreur mdp", message : "Les deux mots de passe ne correspondent pas. Merci de les resaisir", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            present(alert, animated: true)
        }else{
            //creation de l'utilisateur en BDD
            self.createUtilisateur(login: loginUser!, password: passwordUser!)
            //lance le storyboard precedent
            let afficheUserStoryBoard = UIStoryboard(name: "Utilisateur", bundle: nil)
            let categoryVC = afficheUserStoryBoard.instantiateViewController(withIdentifier: "utilisateurConnexion") as! ConnexionUtilisateur
            self.navigationController?.pushViewController(categoryVC, animated: true)
        }
       
        
        
    }
    
    func createUtilisateur(login:String, password:String){
        let nouvelUtilisateur = Utilisateur(context: context)
        nouvelUtilisateur.login = login
        let dateAujourdhui = Date()
        nouvelUtilisateur.dateInscription = dateAujourdhui
        
        nouvelUtilisateur.password=password
       
        
        do{
            try context.save()
            
        }catch{
            let alert = UIAlertController(title : "erreur creation profil", message : "Veuillez recommencer l'opération. Si cela se reproduit, merci de contacter les services de Quizzero", preferredStyle: .alert)
            present(alert, animated: true)
        }
    }
    
    @IBAction func deconnexion(_ sender: UIButton){
        let afficheUserStoryBoard = UIStoryboard(name: "Utilisateur", bundle: nil)
        let categoryVC = afficheUserStoryBoard.instantiateViewController(withIdentifier: "utilisateurConnexion") as! ConnexionUtilisateur
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
          

    
}

extension UIViewController {

    func hideKeyboardWhenTappedAround() {

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)

    }

    

    @objc func dismissKeyboard() {

        view.endEditing(true)

    }

}




    
