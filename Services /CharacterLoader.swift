//
//  CharacterLoader.swift
//  RMakaQuiz
//
//  Created by Maksim Zimens on 25.04.2023.
//

import Foundation

struct CharacterLoader {
    
    private var characterModel = CharacterModel(gender: "", id: 0, image: "", name: "", species: "", status: "")
    
    private var characterURL: URL {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/1") else {
            preconditionFailure("Unable to construct mostPopularMoviesURL")
        }
        return url
    }
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            guard let data = data else {return}
            handler(.success(data))
        }
        
        task.resume()
    }
    
    func loadCharacter(handler: @escaping (Result<CharacterModel, Error>) -> Void) {
        fetch(url: characterURL) { result in
            switch result {
            case .success(let data):
                do {
                    let character = try JSONDecoder().decode(CharacterModel.self, from: data)
                    handler(.success(character))
                } catch {
                    handler(.failure(error))
                }
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
