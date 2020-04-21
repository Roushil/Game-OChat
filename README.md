# GameO'Chat

![Screen Shot 2020-04-21 at 2 47 04 PM](https://user-images.githubusercontent.com/25398924/79848717-13b81c00-83df-11ea-8f49-12843381c045.png)


A realtime Chatting App that uses Firebase for its authentication and storage.
- ***Functionalities:***
  - Registrating new User
  - Logging in
  - Messages History
  - Chatting Scene
  - Sending Text and Images To Chat Partner

- ***Used ios 9 constraints as well as use of storyboard for UI Design***
- ***Handling Alerts for Error and Success***
- ***Cache Images***
- ***Animating TableView Cells***
- ***Template for SignUp Page*** 


# Firebase
This is a chatting app in swift that uses firebase for folowing: 
1. Authentication 
2. Storage
3. Realtime Database

# Architecture
This app follows the **Clean Swift(VIP)** Pattern which consist: 
1. Entity       
> Data Model
2. Worker       
> API and Database Logic
3. Interactor   
> Business Logic
4. Presenter   
> ViewData Logic
5. View 
> View Controller
6. Router       
>Transferring Data To VC

# Pods
1. pod 'Firebase/Auth'           
> Authenticating Users 
2. pod 'Firebase/Storage'        
> Storing Multimedia
3. pod 'Firebase/Database'       
> Realtime Database
4. pod 'IQKeyboardManagerSwift'  
> Managing Keyboard in Messaging


