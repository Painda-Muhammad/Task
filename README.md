# app_desk_task

Flutter Task

## Getting Started

Features
1. Event List:
Displays a list of events showing the event name, date, and a "Check In" button.
2. Local Check-In:
Users can check in to an event. The check-in data (event name, timestamp) is stored locally in a Local database, ensuring offline functionality.
3. Firebase Sync:
If the device is online, the check-in data is also synced with Firebase Firestore.
Unsynced local check-ins are automatically pushed to Firebase when the device goes online again.
4. Fetch Event Details:
Users can fetch additional details like description, Event Images,
tapping the "Fetch Event Details" button.
5. State Management:
   Used Bloc StateMenagement for efficient handling of app states.
6. Error Handling & Notifications:
Displays a ToastMessage after a successful check-in,  when synced with Firebase.
Prevents duplicate check-ins for the same event.
7. Responsive UI:
Created responive UI for Mobile, Tablet and DeskTop

##  Setup Instructions
Clone the repository.
Run flutter pub get to install dependencies.
Build and run the app using the Flutter command:
flutter run


## Can Run only these platforms
Android
IOS
Chrome Web

## Not Praperd Platform
Not DeskTop#   a p p _ d e s k _ t a s k  
 