//
//  ConstruitUneQuestion.swift
//  Quizz3
//
//  Created by Mickael Pot on 01/12/2021.
//

import UIKit

class ConstruitUneQuestion: UIViewController {
    
    //Gradient background
    @IBOutlet weak var backgroundGradientView: UIView!
    //
    
    let emplacementFichierJSON="questions_final"
    
    var scoreUser=0
    
    var bonneReponse=""
    
    var NombreDeQuestions = 0
    let nombreTotalDeQuestions = 10
  
    var compteurDeQuestions = 10

    private var questions = [Question]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //let fichierJSON='qu
    
    var categorie: String? = nil
    var tableauDeQuestion: CategorieQuestion?
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var categorieLabel: UILabel!
    @IBOutlet weak var afficheNumeroQuestion: UILabel!
    @IBOutlet weak var reponseA: UIButton!
    @IBOutlet weak var reponseB: UIButton!
    @IBOutlet weak var reponseC: UIButton!
    @IBOutlet weak var reponseD: UIButton!
    
    //en cliquant sur une case réponse, l'utilisateur déclanche le comparateur de bonne réponses et va, ou non incrementer son score
    @IBAction func verifieReponse(_ sender: UIButton){
        let reponseUser=sender.titleLabel?.text
        if(reponseUser==bonneReponse){
            alertLabel.text = "Bonne réponse"
            self.alertLabel.alpha = 0.0
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.alertLabel.alpha = 1.0
            }, completion: {
                finished in
        
                if finished {
                    // Fade in
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
                        self.alertLabel.alpha = 0.0
                    }, completion: nil)
                }
            })
            //on incremente le score de l'utilisateur
            scoreUser=scoreUser+1
        }else{
            alertLabel.text = "Faux. Bonne réponse : \""+bonneReponse+"\""
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.alertLabel.alpha = 1.0
            }, completion: {
                finished in
                
                if finished {
                    // Fade in
                    UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseIn, animations: {
                        self.alertLabel.alpha = 0.0
                    }, completion: nil)
                }
            })
        }
        
        if compteurDeQuestions>1 {
            afficheUneQuestion(categorie!, tableau: tableauDeQuestion!)
            
            compteurDeQuestions=compteurDeQuestions-1
        }else{
            
            let affichage=String(scoreUser)
            let monAffichage="Ton score pour cette session est : "+affichage+". \n Merci d'avoir joué !"
            
            
            let alertScore = UIAlertController(title : "Score", message : monAffichage, preferredStyle: .alert)
            alertScore.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { [weak self] _ in
                let categorieStoryBoard = UIStoryboard(name: "Categorie", bundle: nil)
                            let categoryVC = categorieStoryBoard.instantiateViewController(withIdentifier: "CategorieID") as! AfficheCategorie
                            self?.navigationController?.pushViewController(categoryVC, animated: true)
            }))

            self.present(alertScore, animated: true)
            
            
        }
    }

    func randomQuestion(tableau: CategorieQuestion) ->Int{
        let tailleTableau = tableau.values.count
        let monNombreRandom =  Int.random(in: 0..<tailleTableau)
        return monNombreRandom
    }
    
    //construit une question
    func afficheUneQuestion(_ categorie: String, tableau: CategorieQuestion){
       let tabDeQuestions = tableau.values
        let questionRandom = randomQuestion(tableau: tableau)
        
       // tableau.values.forEach({ question in
        //   print(question.maQuestion)
          //  print(question.maReponse)
        //})
        
        NombreDeQuestions=NombreDeQuestions+1
        let affichageDeNbQuestions=String(NombreDeQuestions)+"/"+String(nombreTotalDeQuestions)
        
        DispatchQueue.main.async{
            
            self.afficheNumeroQuestion.text = affichageDeNbQuestions
        }
           
        
        //faire un random sur les variables de reponses
        var tableauAMelanger = [String]()
        
        tableauAMelanger.append(tabDeQuestions[questionRandom].reponseA)
        tableauAMelanger.append(tabDeQuestions[questionRandom].reponseB)
        tableauAMelanger.append(tabDeQuestions[questionRandom].reponseC)
        tableauAMelanger.append(tabDeQuestions[questionRandom].reponseD)
        tableauAMelanger.shuffle()
        
        //recupere les valeur de la question du JSON et les stocke dans des variables
        let maQuestion=tabDeQuestions[questionRandom].maQuestion
        let reponseUserA=tableauAMelanger[0]
        let reponseUserB=tableauAMelanger[1]
        let reponseUserC=tableauAMelanger[2]
        let reponseUserD=tableauAMelanger[3]
        bonneReponse=tabDeQuestions[questionRandom].maReponse
        
        DispatchQueue.main.async{
            
            self.questionLabel.text = maQuestion
        }
        
        //change les boutons
        DispatchQueue.main.async{
        self.reponseA.setTitle(reponseUserA, for: .normal)
           
        }
        DispatchQueue.main.async{
            self.reponseB.setTitle(reponseUserB, for: .normal)
        }
        DispatchQueue.main.async{
            self.reponseC.setTitle(reponseUserC, for: .normal)
        }
        DispatchQueue.main.async{
            self.reponseD.setTitle(reponseUserD, for: .normal)
        }
        
        
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
        
        categorie = UserDefaults.standard.string(forKey: "categorie")
        categorieLabel?.text = categorie
        
        //parse le JSON
        tableauDeQuestion = loadJsonCategorie(categorie!, filename: emplacementFichierJSON)
        afficheUneQuestion(categorie!, tableau: tableauDeQuestion!)
    }
    
    //Gradient background
    override var shouldAutorotate: Bool {
        return false
    }
    //
    
    
    
    func loadJsonCategorie(_ categorie: String, filename fileName: String) -> CategorieQuestion?
    {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json")
    {
          let data = try! Data(contentsOf: url)
              do {
                
                let questionsJson = try! JSONDecoder().decode(Questions.self, from: data)
                
                let MaCategories = questionsJson.categorie
                let selectionCategorie = MaCategories?.first(where: { categorieQuestion in
                    return categorieQuestion.name == categorie
                })
                print(selectionCategorie)
                return selectionCategorie
//                selectionCategorie?.values.forEach({ question in
//                    print(question.maQuestion)
//                    print(question.maReponse)
//                })
//                        let object = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
//                        if let dictionary = object as? [String: AnyObject] {
//                            return dictionary
//                        }
                    } catch {
                        print("Impossible de parser le JSON  \(fileName).json")
                    }
                }
                print("Impossible de lire le fichier JSON \(fileName).json")
//            }
            return nil
    }
    
    func loadJsonWithoutCategorie(filename fileName: String) -> [String: AnyObject]?
    {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json")
    {
          let data = try! Data(contentsOf: url)
              do {
                
                let questionsJson = try! JSONDecoder().decode(Questions.self, from: data)
                
                        let object = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                        if let dictionary = object as? [String: AnyObject] {
                            return dictionary
                        }
                    } catch {
                        print("Impossible de parser le JSON  \(fileName).json")
                    }
                }
                print("Impossible de lire le fichier JSON \(fileName).json")
//            }
            return nil
    }
}

class Questions: NSObject, Codable {
    var categorie: [CategorieQuestion]!
}

class CategorieQuestion: NSObject, Codable {
    var name: String!
    var values: [QuestionJSON]
}

class QuestionJSON: NSObject, Codable {
    var maQuestion: String!
    var reponseA: String!
    var reponseB: String!
    var reponseC: String!
    var reponseD: String!
    var maReponse: String!
}

