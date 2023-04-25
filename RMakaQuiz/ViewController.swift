//
//  ViewController.swift
//  RMakaQuiz
//
//  Created by Maksim Zimens on 06.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let characterLoader = CharacterLoader()
    
    private var character = CharacterModel(gender: "", id: 0, image: "", name: "", species: "", status: "")
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var characterGender: UILabel!
    
    @IBOutlet weak var characterSpecie: UILabel!
    
    @IBOutlet weak var characterIndex: UILabel!
    
    @IBOutlet weak var characterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        var imageData = Data()
        guard let imageURL = URL(string: character.image) else {
            print("всё говно")
            return
        }
        do {
            imageData = try Data(contentsOf: imageURL)
        } catch {
            print("Failed to load image")
            return
        }
        characterImage.image = UIImage(data: imageData)
        
    }
    
    private func loadData() {
        characterLoader.loadCharacter { [ weak self ] result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case.success(let character):
                    self.character = character
                case .failure(let error):
                    return
                }
            }
        }
    }

}

/*
 func getImage(url: String) -> UIImage {
    let url = URL(string: url)!
    // Fetch Image Data
    if let data = try? Data(contentsOf: url) {
        // Create Image and Update Image View
        return UIImage(data: data)!
    }
    return UIImage(systemName: "lock")!
}
var character: Character = Character(image: getImage(url: json.image),
                                 index: json.id,
                                 name: json.name,
                                 specie: json.species,
                                 gender: json.gender)

self.characterShown = character
 */
