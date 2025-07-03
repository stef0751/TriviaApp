import UIKit

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
    var questions: [TriviaQuestion] = []
    var currentIndex = 0
    var score = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.isHidden = true
        loadQuestions()
    }

    // MARK: - Load from API
    func loadQuestions() {
        TriviaQuestionService.fetchQuestions { fetchedQuestions in
            self.questions = fetchedQuestions
            self.currentIndex = 0
            self.score = 0
            self.displayCurrentQuestion()
        }
    }

    // MARK: - Display Question
    func displayCurrentQuestion() {
        guard currentIndex < questions.count else {
            showFinalScore()
            return
        }

        let current = questions[currentIndex]
        questionLabel.text = current.question

        var allAnswers = current.incorrectAnswers + [current.correctAnswer]
        allAnswers.shuffle()

        answerButton1.setTitle(allAnswers[0], for: .normal)
        answerButton2.setTitle(allAnswers[1], for: .normal)
        answerButton3.setTitle(allAnswers[2], for: .normal)
        answerButton4.setTitle(allAnswers[3], for: .normal)

        progressLabel.text = "Question \(currentIndex + 1) of \(questions.count)"
        
        // Make sure buttons are visible
        answerButton1.isHidden = false
        answerButton2.isHidden = false
        answerButton3.isHidden = false
        answerButton4.isHidden = false
    }

    // MARK: - Handle Answer Tap
    @IBAction func answerTapped(_ sender: UIButton) {
        guard currentIndex < questions.count else { return }
        let selectedAnswer = sender.title(for: .normal)
        if selectedAnswer == questions[currentIndex].correctAnswer {
            score += 1
        }
        currentIndex += 1
        displayCurrentQuestion()
    }

    // MARK: - Show Final Score
    func showFinalScore() {
        questionLabel.text = "You scored \(score) out of \(questions.count)"
        progressLabel.text = "Quiz Complete"

        answerButton1.isHidden = true
        answerButton2.isHidden = true
        answerButton3.isHidden = true
        answerButton4.isHidden = true

        playAgainButton.isHidden = false
    }

    // MARK: - Restart Quiz
    @IBAction func playAgainTapped(_ sender: UIButton) {
        loadQuestions()
        playAgainButton.isHidden = true
    }
}
