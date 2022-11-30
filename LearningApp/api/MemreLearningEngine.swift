
import Foundation
import SwiftUI
import Combine

class MemreLearningEngine {
    static let host : String = "learning-engine.p.rapidapi.com"
    static let baseUrl : String = "https://learning-engine.p.rapidapi.com/memre_api/v1/"
    
    static func createUser(_ apiKey: String,
                           onCompletion: @escaping () -> Void,
                           onError: @escaping (String) -> Void) {
        guard let request = makeApiRequest(apiKey: apiKey, apiPath: "users", httpMethod: "POST") else {
            onError("Unepected failure creating request")
            return
        }

        let task = URLSession.shared.dataTask(with: request,
                                              completionHandler: {
            data, response, error -> Void in
            if let json = parseApiResponse(data: data,
                                           response: response,
                                           error: error,
                                           onError: onError) {
                guard let userJson = json["data"] as? [String: Any] else {
                    onError("Unexpected missing data")
                    return
                }
                guard let userId = userJson["id"] as? String else {
                    onError("Unexpected missing id")
                    return
                }
                MyUserDefaults.setApiKey(apiKey)
                MyUserDefaults.setUserId(userId)
                onCompletion()
            }
        })
        task.resume()
    }
    
    static func createLearningItem(onCompletion: @escaping (String) -> Void,
                                   onError: @escaping (String) -> Void) {
        guard let apiKey = MyUserDefaults.getApiKey() else {
            onError("Unepected missing api key")
            return
        }
        guard let request = makeApiRequest(apiKey: apiKey, apiPath: "items", httpMethod: "POST") else {
            onError("Unepected failure creating request")
            return
        }

        let task = URLSession.shared.dataTask(with: request,
                                              completionHandler: {
            data, response, error -> Void in
            if let json = parseApiResponse(data: data,
                                           response: response,
                                           error: error,
                                           onError: onError) {
                guard let itemJson = json["data"] as? [String: Any] else {
                    onError("Unexpected missing data")
                    return
                }
                guard let itemId = itemJson["id"] as? String else {
                    onError("Unexpected missing id")
                    return
                }
                onCompletion(itemId)
            }
        })
        task.resume()
    }
    
    static func postStudyReport(itemId: String,
                                quizResult: QuizResult,
                                studyTimeMillis: Double,
                                onCompletion: @escaping () -> Void,
                                onError: @escaping (String) -> Void) {
        guard let apiKey = MyUserDefaults.getApiKey(), let userId = MyUserDefaults.getUserId() else {
            onError("Unepected missing api key")
            return
        }
        guard var request = makeApiRequest(apiKey: apiKey, apiPath: "study", httpMethod: "POST") else {
            onError("Unepected failure creating request")
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let studyTimeMillisFinal = (studyTimeMillis.toInt() ?? 0)
        let paramsJson : [String: Any] = ["user_id": userId,
                                          "item_id": itemId,
                                          "quiz_result": quizResult.rawValue,
                                          "study_time_millis": studyTimeMillisFinal]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paramsJson)
        } catch {
            onError("Unepected failure creating request")
            return
        }

        let task = URLSession.shared.dataTask(with: request,
                                              completionHandler: {
            data, response, error -> Void in
            if parseApiResponse(data: data,
                                response: response,
                                error: error,
                                onError: onError) != nil {
                onCompletion()
            }
        })
        task.resume()
    }
    
    static func getRecommendedStudyItems(onCompletion: @escaping (_ studyItemIds: [String]) -> Void,
                                         onError: @escaping (String) -> Void) {
        guard let apiKey = MyUserDefaults.getApiKey(), let userId = MyUserDefaults.getUserId() else {
            onError("Unepected missing api key")
            return
        }
        guard let request = makeApiRequest(apiKey: apiKey,
                                           apiPath: "study",
                                           httpMethod: "GET",
                                           parameters: ["user_id": userId]) else {
            onError("Unepected failure creating request")
            return
        }
        let task = URLSession.shared.dataTask(with: request,
                                              completionHandler: {
            data, response, error -> Void in
            if let json = parseApiResponse(data: data,
                                           response: response,
                                           error: error,
                                           onError: onError) {
                guard let dataJson = json["data"] as? [Any] else {
                    onError("Unexpected response data")
                    return
                }
                var results: [String] = []
                dataJson.forEach { item in
                    if let itemJson = item as? [String: Any],
                       let id = itemJson["id"] as? String {
                        results.append(id)
                    }
                }
                onCompletion(results)
            }
        })
        task.resume()
    }
    
    static func getLearningStats(onCompletion: @escaping (_ learningStats: [LearningStat]) -> Void,
                                 onError: @escaping (String) -> Void) {
        guard let apiKey = MyUserDefaults.getApiKey(), let userId = MyUserDefaults.getUserId() else {
            onError("Unepected missing api key")
            return
        }
        let apiPath = String(format: "users/%@/learning_stats", userId)
        guard let request = makeApiRequest(apiKey: apiKey, apiPath: apiPath, httpMethod: "GET") else {
            onError("Unepected failure creating request")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request,
                                              completionHandler: {
            data, response, error -> Void in
            if let json = parseApiResponse(data: data,
                                           response: response,
                                           error: error,
                                           onError: onError) {
                guard let responseData = json["data"] as? [String: Any],
                      let learningStats = responseData["predicted_efficiency_by_hour"] as? [String: Double] else {
                    onError("Unexpected response data")
                    return
                }
                var results: [LearningStat] = []
                learningStats.forEach { (key: String, value: Double) in
                    results.append(LearningStat(hoursFromNow: Int(key) ?? 0,
                                                effeciency: value))
                }
                onCompletion(results)
            }
        })
        task.resume()
    }
    
    private static func makeApiRequest(apiKey: String,
                                       apiPath: String,
                                       httpMethod: String,
                                       parameters: [String:String]? = [:]) -> URLRequest? {
        guard var urlCompontents = URLComponents(string: baseUrl + apiPath) else { return nil }
        if let params = parameters {
            var queryItems: [URLQueryItem] = []
            params.forEach { (key: String, value: String) in
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlCompontents.queryItems = queryItems
        }
        guard let url = urlCompontents.url else { return nil }
        return makeUrlRequest(url: url, httpMethod: httpMethod, apiKey: apiKey)
    }
    
    private static func makeApiRequest(apiPath: String,
                                       httpMethod: String) -> URLRequest? {
        guard let url = URL(string: baseUrl + apiPath) else { return nil }
        guard let apiKey = MyUserDefaults.getApiKey() else { return nil }
        return makeUrlRequest(url: url, httpMethod: httpMethod, apiKey: apiKey)
    }
    
    private static func makeUrlRequest(url: URL,
                                       httpMethod: String,
                                       apiKey: String) -> URLRequest {
        var result = URLRequest(url: url)
        result.httpMethod = httpMethod
        result.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        result.addValue(host, forHTTPHeaderField: "X-RapidAPI-Host")
        return result
    }
    
    private static func parseApiResponse(data: Data?,
                                         response: URLResponse?,
                                         error: Error?,
                                         onError: @escaping (String) -> Void) -> [String:Any]? {
        if let error = error {
            onError(error.localizedDescription)
            return nil
        }
        guard let response = response as? HTTPURLResponse else {
            onError("Unexpected response")
            return nil
        }
        guard let data = data else {
            onError("Unexpected missing data")
            return nil
        }
        do {
            if data.count == 0 {
                if (response.statusCode == 200 || response.statusCode == 204) {
                    return [:]
                } else {
                    onError("Unexpected missing error message")
                    return nil
                }
            } else if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                if (response.statusCode == 200) {
                    return json
                } else {
                    if let message = json["message"] as? String {
                        onError(message)
                    } else if let meta = json["meta"] as? [String:Any],
                                let message = meta["message"] as? String {
                        onError(message)
                    } else {
                        onError("Unexpected missing error message")
                    }
                    return nil
                }
            } else if let json = try JSONSerialization.jsonObject(with: data) as? [Any] {
                if (response.statusCode == 200) {
                    return ["data": json]
                } else {
                    onError("Unexpected missing error message")
                    return nil
                }
            } else if let message = try JSONSerialization.jsonObject(with: data) as? String {
                onError(message)
                return nil
            } else {
                onError("Unexpected JSON in response")
                return nil
            }
        } catch {
            onError("Exception in JSON parsing")
            return nil
        }
    }
}
