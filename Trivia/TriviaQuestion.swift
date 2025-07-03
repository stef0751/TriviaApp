//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Steffina Jerald on 7/3/25.
//

import Foundation

struct TriviaResponse: Decodable {
    let results: [TriviaQuestion]
}

struct TriviaQuestion: Decodable {
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
