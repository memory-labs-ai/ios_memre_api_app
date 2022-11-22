
import Foundation

class StudyItem: NSObject {
    var id: String
    var learningEngineId: String
    var question: String
    var answer: String
    var distractors: [String]

    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.learningEngineId = dictionary["learning_engine_id"] as? String ?? ""
        self.question = dictionary["question"] as? String ?? ""
        self.answer = dictionary["answer"] as? String ?? ""
        self.distractors = dictionary["distractors"] as? [String] ?? []
    }
    
    init(id: String,
         learningEngineId: String,
         question: String,
         answer: String,
         distractors: [String]) {
        self.id = id
        self.learningEngineId = learningEngineId
        self.question = question
        self.answer = answer
        self.distractors = distractors
    }
    
    func asDictionary() -> [String: AnyObject] {
         return ["id": id as AnyObject,
                 "learning_engine_id": learningEngineId as AnyObject,
                 "question": question as AnyObject,
                 "answer": answer as AnyObject,
                 "distractors" : distractors as AnyObject]
     }
    
    func getShuffledAnswers() -> [String] {
        var results = distractors.shuffled()
        let answerPosition = Int.random(in: 0..<(distractors.count + 1))
        results.insert(answer, at: answerPosition)
        return results
    }
    
    static func previewStudyItem() -> StudyItem {
        return StudyItem(id: "1",
                         learningEngineId: "1",
                         question: "What's the capital of France?",
                         answer: "Paris",
                         distractors: ["Washington DC", "London", "Berlin"])
    }
}
