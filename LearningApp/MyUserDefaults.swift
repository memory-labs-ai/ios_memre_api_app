
import Foundation

class MyUserDefaults: NSObject {
    
    class func setApiKey(_ apiKey: String) {
        UserDefaults.standard.setValue(apiKey, forKey: "apiKey")
        UserDefaults.standard.synchronize()
    }
    
    class func getApiKey() -> String? {
        return UserDefaults.standard.string(forKey: "apiKey")
    }
    
    class func setUserId(_ userId: String) {
        UserDefaults.standard.setValue(userId, forKey: "userId")
        UserDefaults.standard.synchronize()
    }
    
    class func getUserId() -> String? {
        return UserDefaults.standard.string(forKey: "userId")
    }
    
    class func addStudyItem(_ studyItem: StudyItem) {
        var studyItems = getStudyItems()
        studyItems.append(studyItem)
        saveStudyItems(studyItems)
    }
    
    class func deleteStudyItem(_ studyItem: StudyItem) {
        let studyItems = getStudyItems().filter { currentItem in
            return currentItem.id != studyItem.id
        }
        saveStudyItems(studyItems)
    }
    
    class func saveStudyItems(_ studyItems: [StudyItem]) {
        let convertedItems = studyItems.map { $0.asDictionary()}
        if let data = try? JSONSerialization.data(withJSONObject: convertedItems, options: []) {
            let jsonString = String(data: data, encoding: String.Encoding.utf8)
            UserDefaults.standard.setValue(jsonString, forKey: "studyItems")
            UserDefaults.standard.synchronize()
        } else {
            print("Error serializing study items")
            return
        }
    }
    
    class func getStudyItems() -> [StudyItem] {
        guard let jsonString = UserDefaults.standard.string(forKey: "studyItems") else { return [] }
        var results: [StudyItem] = []
        guard let data = jsonString.data(using: .utf8) else { return [] }
        do {
            if let jsonList = try JSONSerialization.jsonObject(with: data) as? [Any] {
                jsonList.forEach { json in
                    if let dict = json as? [String: Any] {
                        results.append(StudyItem(dictionary: dict))
                    }
                }
            }
        } catch {
            print("Exception in JSON parsing")
        }
        return results
    }
}
