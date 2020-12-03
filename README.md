# MyAnimeList

 
  - User can scroll through it horizontally to view upto 50 Anime items
  - User can select any and see the details which includes Synopsis, Picture, Rating, Score

User can also:
  - Load the app Offline
  - View the App in all devices(iPhones,iPads,iPods) in any orientation

### Compatibility 

* Deployment Target - 13.0
* The application supports iOS 13+
* MyAnimeList is an Universal App compatible for all iPhones and iPads

### Concepts Used

* Coredata to save data locally
* Used UICollectionView to show the items
* Used Async request for NSURLConnection
* Time taking process like JSON parsing and Loading image data are done in seperate thread
* Exception handled while parsing JSON
* Collection images lazy loaded in different thread to avoid performace issue

### Design

* Used Constraints to create Auto layout
* Constraints added for UIObjects
* Used Stackview as the application supports from iOS 8
* Rockwell font is used all over the project
* Font color Black is maintained all over the Project

#### Testing

* UI Testing done in All devices in All Orientations
    * iPhone SE
    * iPhone 5, 5S
    * iPhone 6, 6+
    * iPhone 6S, 6S+
    * iPhone 7, 7+
    * iPad Air, Air 2 , Pro
* App tested for multiple anime selection and navigation between views
* Leak test done with Instruments
* CPU and Memory utilization verified

#### Issues

* First launch is taking time

### Cleanup

* All Print and All Breakpoints Removed
* Files structured into respective Folders (Based on MVVM Architecture)
* Project built with 0 errors and Warnings
* Comments added
* Naming conventions as per Apple Guideleines

### Areas to improve
This app can be further improved

* By implementing Unit Testing
* By Using Size classes and differentiate iPad and iPhone design more
* By adding more rich design
* By Adding more test cases with low and no internet connection
* Coredata can be improved
