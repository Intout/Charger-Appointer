## Abstract 

In this applcation users can create appointments for electric car charging stations at available time and date. Users are able to search by cities and filter information by socket, charger, distance and facility service information.

Applcations features are:

✅ MVVM + Coordinator
✅ Custom Font
✅ Custom Color Pallet
✅ English and Turkish Localization
✅ RestAPI CRUD methods
✅ Regex



## Method 

Data processing and displaying handled by MVVM, routing handled by Coordinator pattern. Applications navigation hiarchy displayed in the image.

![Coordinator diagram for Application.](./images/ChargerAppointerCoordinatorDiagram.png "Coordinator Diagram")

App Coordinator handles routing between Authenticaton and Main Coordinator. Main Coordintor routes core view of the application. Appointment Coordinator routes views that handles appointment creation. Station Search Cooridinator, handles routing of listing view and it's corresponding filter view.

### Authentication View

In this view user e-mail and device ID is posted to backend and fetches token for API calls. E-mail input from user is in regex control and if user enters email in wrong format there is a warning displayed.

<p align="center">
  <img src="./images/AuthScreen.png" alt="Authentication image from iOS app." width="300"/> 
</p>

### Appointed Stations View

Past and Future appointments of user are displayed in this view. Server returns a JSON data that stores station and due of appointment thus appointments catogorzied by there due information. Station information stored on a custom table cell view. Users can tap on a cell and delete there future appointments, before deletion of appointment a warning message is displayed. Users have maximum limit of 3 appointments, appointment limit controlled by number of future appointments. If user haven't made any appointments a messaged displayed on screen. Users can select acount icon on navigation bar then log out or see their information on Account View.

<p align="center">
  <img src="./images/EmptyAppointmentList.png" alt="Authentication image from iOS app." width="300"/> 
   <img src="./images/AppointmentList.png" alt="Authentication image from iOS app." width="300"/> 
  <img src="./images/AppointmentListWarning.png" alt="Authentication image from iOS app." width="300"/> 
</p>

### Cities View

When user taps on Make An Appointment button on Appointed Stations View, they are routed to Cities View. Users can search and select a city to appoint a station in. Search bar has 3 states: Idle, Found, Not Found. If there is a result for the search bar is highlighted with green color other wise with red color.
<p align="center">
  <img src="./images/CitiesViewIdle.png" alt="Authentication image from iOS app." width="300"/> 
   <img src="./images/CitiesViewFound.png" alt="Authentication image from iOS app." width="300"/> 
  <img src="./images/CitiesViewNotFound.png" alt="Authentication image from iOS app." width="300"/> 
</p>
