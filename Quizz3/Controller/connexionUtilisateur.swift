//
//  connexionUtilisateur.swift
//  Quizz3
//
//  Created by Mickael Pot on 01/12/2021.
//

import UIKit

class ConnexionUtilisateur: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Gradient background
    @IBOutlet weak var backgroundGradientView: UIView!
    //
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var boutonCommencer: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var utilisateurs = [Utilisateur]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gradient background 
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.02, green: 0.00, blue: 0.51, alpha: 1.00).cgColor,UIColor(red: 0.40, green: 0.00, blue: 0.42, alpha: 1.00).cgColor]
        gradientLayer.shouldRasterize = true
        backgroundGradientView.layer.addSublayer(gradientLayer)
        //
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        getAllUtilisateurs()
        if (utilisateurs.count != 0){
            /*view.addSubview(tableView)
             tableView.delegate = self
             tableView.dataSource = self
             tableView.frame = view.bounds
             
             tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")*/
        }
    }
    
    //Gradient background
    override var shouldAutorotate: Bool {
        return false
    }
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //compter le nombre d'utilisateurs dans la BDD
        return utilisateurs.count
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let utilisateur = utilisateurs[indexPath.row]
        //On stocke notre utilisateur dans une cellule
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //On place notre cellule dans un textLabel
        cell.textLabel?.text = utilisateur.login
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let utilisateur = utilisateurs[indexPath.row]
        print(utilisateur.password)
        
        let alert = UIAlertController(title : "mot de passe", message : "Saisissez votre mot de passe", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)

        alert.addAction(UIAlertAction(title: "Comparer", style: .cancel, handler: { [weak self] _ in
            guard let champ = alert.textFields?.first, let texte = champ.text, !texte.isEmpty else{
                return
            }

            if utilisateur.password == texte {
                let creerUserStoryBoard = UIStoryboard(name: "Categorie", bundle: nil)
                let categoryVC = creerUserStoryBoard.instantiateViewController(withIdentifier: "CategorieID") as! AfficheCategorie
                categoryVC.login = utilisateur.login
                //self?.navigationController?.
                self?.navigationController?.pushViewController(categoryVC, animated: true)
                //passer une variable a l autre page

            }else{
                let alertErreur = UIAlertController(title : "erreur de mot de passe", message : "le mot de passe renseigné ne correspond pas", preferredStyle: .alert)
                alertErreur.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self?.present(alertErreur, animated: true)
            }
        }))
        
        present(alert, animated: true)
        
    }
    
    //A CHANGER
    @IBAction func lanceVueCreationUtilisateur(_ sender: UIButton){
        let creerUserStoryBoard = UIStoryboard(name: "CreationUtilisateur", bundle: nil)
        let categoryVC = creerUserStoryBoard.instantiateViewController(withIdentifier: "CreerUtilisateur") as! CreerUnUtilisateur
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    //Les fonctions coreData
    func getAllUtilisateurs(){
        do{
            utilisateurs = try context.fetch(Utilisateur.fetchRequest())
            DispatchQueue.main.async {
                //Construire un tableau de données en asynchrone
                self.tableView.reloadData()
            }
            
        }catch{
            //erreur
        }
        
        
    }
    
    
}
