//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Steffina Jerald on 7/3/25.
//

import Foundation

class TriviaQuestionService {
    static func fetchQuestions(completion: @escaping ([TriviaQuestion]) -> Void) {
        let urlString = "https://opentdb.com/api.php?amount=5&type=multiple"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching questions: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                let decodedResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse.results)
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}

