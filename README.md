# Game-OChat

A realtime Chatting App that uses Firebase for its authentication and storage.
- It consists of:
  - Registrating new User
  - Logging in
  - Messages History
  - Chatting Scene
  - Sending Text and Images To Chat Partner


- ***Used ios 9 constraints as well as use of storyboard for UI Design***
- ***Handling Alerts in Error and Success***
- ***Cache Images***

# Firebase
This is a chatting app in swift that uses firebase for folowing: 
1. Authentication 
2. Storage
3. Realtime Database

# Architecture
This app follows the Clean Swift Pattern which consist: 
1. Entity        // Data Model
2. Worker       // API and Database Logic
3. Interactor   // Business Logic
4. Presenter   // Viewlogic
5. ViewModel    // Viewing Data
6. Router       // Transferring Data To VC

# Pods
1. pod 'Firebase/Auth'           // Authenticating Users 
2. pod 'Firebase/Storage'        // Storing Multimedia
3. pod 'Firebase/Database'       // Realtime Database
4. pod 'IQKeyboardManagerSwift'  // Managing Keyboard in Messaging


