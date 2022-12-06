# Memre API Learning App

Example iOS app written using SwiftUI. Demonstrates a learning app that uses the Memre Learning Engine API to enhance the learning experience by recommending what to study.

[Memre Learning Engine API Documentation](https://rapidapi.com/memre-memre-default/api/learning-engine/)

Example calls to the Memre Learning Engine api can be found in [MemreLearningEngine.swift](LearningApp/api/MemreLearningEngine.swift).

![Walk Through](images/WalkThrough.gif)

## Learning Engine Integration Guide:

1. Obtain a RapidAPI key: [RapidAPI sign-up](https://rapidapi.com/auth/sign-up?referral=/memre-memre-default/api/learning-engine/pricing)

2. Use the RapidAPI key to make api calls to the Memre Learning Engine

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/MyUserDefaults.swift#L6-L9

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/api/MemreLearningEngine.swift#L201-L216

3. Create a Learning Engine User and store the user id to use with subsequent api calls for the user of the learning app.

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/screens/EnterAPIKeyView.swift#L27-L29

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/api/MemreLearningEngine.swift#L10-L39

4. Create a Learning Engine Item and associate the item id to each study item in the app.

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/api/MemreLearningEngine.swift#L41-L71

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/screens/AddStudyItemView.swift#L72-L82

5. Post a study report whenever the user studies a learning item.

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/screens/StudyQuizView.swift#L64-L73

6. Use the Learning Engine recommendations to suggest which items to study.

![Recommended Study Items](images/RecommendedStudyItems.png)

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/screens/StudyItemsView.swift#L73-L84

https://github.com/memre-ai/ios_memre_api_app/blob/29b70d21466258a7495db80e1dd02af391a38313/LearningApp/view/StudyItemCell.swift#L20-L26
