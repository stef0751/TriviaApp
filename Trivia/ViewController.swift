import UIKit

// MARK: - Question Data Model
struct Question {
    let prompt: String
    let answers: [String]
    let correctAnswerIndex: Int
}

class ViewController: UIViewController {

    // MARK: - IBOutlets


    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    

    
    // MARK: - Quiz State
    let questions: [Question] = [
        Question(prompt: "What element has the atomic number 74?", answers: ["Tin", "Tungsten", "Tantalum", "Titanium"], correctAnswerIndex: 1),
        Question(prompt: "Who was the first woman to win a Nobel Prize?", answers: ["Rosalind Franklin", "Dorothy Hodgkin", "Marie Curie", "Lise Meitner"], correctAnswerIndex: 2),
        Question(prompt: "What year did the Berlin Wall Fall?", answers: ["1985", "1989", "1991", "1993"], correctAnswerIndex: 1),
        Question(prompt: "Which planet has the shortest day in the solar system?", answers: ["Saturn", "Mars", "Mercury", "Jupiter"], correctAnswerIndex: 3),
        Question(prompt: "What language is most closely related to English?", answers: ["Dutch", "French", "Latin", "Italian"], correctAnswerIndex: 0),
        Question(prompt: "What is the term for a word or phrase that reads the same backward as forward?", answers: ["Anagram", "Palindrome", "Antipalindrome", "Homophone"], correctAnswerIndex: 1),
        Question(prompt: "Which philosopher wrote Critique of Pure Reason?", answers: ["René Descartes", "David Hume", "Immanuel Kant", "Friedrich Nietzsche"], correctAnswerIndex: 2),
        Question(prompt: "What country was formerly known as Abyssinia?", answers: ["Armenia", "Ethiopia", "Libya", "Sudan"], correctAnswerIndex: 1),
        Question(prompt: "In music theory, how many sharps are in the key of B major?", answers: ["5", "6", "7", "8"], correctAnswerIndex: 2),
        Question(prompt: "What is the only mammal capable of true flight?", answers: ["Flying Squirrel", "Sugar Glider", "Colugo", "Bat"], correctAnswerIndex: 3),
        
    ]
    
    var currentQuestionIndex = 0
    var score = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.isHidden = true
        showQuestion()
    }

    // MARK: - Display Question
    func showQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        questionLabel.text = currentQuestion.prompt
        answerButton1.setTitle(currentQuestion.answers[0], for: .normal)
        answerButton2.setTitle(currentQuestion.answers[1], for: .normal)
        answerButton3.setTitle(currentQuestion.answers[2], for: .normal)
        answerButton4.setTitle(currentQuestion.answers[3], for: .normal)
        progressLabel.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
        
        answerButton1.isHidden = false
        answerButton2.isHidden = false
        answerButton3.isHidden = false
        answerButton4.isHidden = false
    }

    // MARK: - Handle Answer Taps
    @IBAction func answerTapped(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
        
        if let selectedIndex = buttons.firstIndex(of: sender) {
            if selectedIndex == currentQuestion.correctAnswerIndex {
                score += 1
            }
        }
        
        currentQuestionIndex += 1
        
        if currentQuestionIndex < questions.count {
            showQuestion()
        } else {
            showFinalScore()
        }
    }

    // MARK: - End of Quiz
    func showFinalScore() {
        questionLabel.text = "You got \(score) out of \(questions.count) correct!"
        progressLabel.text = "Quiz Complete"
        
        answerButton1.isHidden = true
        answerButton2.isHidden = true
        answerButton3.isHidden = true
        answerButton4.isHidden = true
        
        playAgainButton.isHidden = false
    }

    func enableAnswerButtons(_ enable: Bool) {
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
        for button in buttons {
            button?.isEnabled = enable
        }
    }

    // MARK: - Restart Quiz
    @IBAction func playAgainTapped(_ sender: UIButton) {
        currentQuestionIndex = 0
        score = 0
        playAgainButton.isHidden = true
        enableAnswerButtons(true)
        showQuestion()
    }
}
