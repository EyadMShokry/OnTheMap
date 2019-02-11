# OnTheMap
The On The Map app allows users to share their location and a URL with their fellow students. To visualize this data, On The Map uses a map with pins for location and pin annotations for student names and URLs, allowing students to place themselves “on the map,” so to speak.

# Application Scenario
First, the user logs in to the app using their Udacity username and password. After login, the app downloads locations and links previously posted by other students. These links can point to any URL that a student chooses.

After viewing the information posted by other students, a user can post their own location and link. The locations are specified with a string and forward geocoded. They can be as specific as a full street address or as generic as “Costa Rica” or “Seattle, WA.”

# Application Scenes:
- **Login View**: Allows the user to log in using their Udacity credentials.
- **Map and Table Tabbed View**: Allows users to see the locations of other students in two formats.
- **Information Posting View**: Allows the users specify their own locations and links.

These three scenes are described in detail below.

## Login View
- The login view accepts the email address and password that students use to login to the Udacity site. User credentials are not required to be saved upon successful login.
- When the user taps the Login button, the app will attempt to authenticate with Udacity’s servers.
- Clicking on the Sign Up link will open Safari to the Udacity sign-up page.
- If the connection is made and the email and password are good, the app will segue to The **Map and Table Tabbed View**.
- If the login does not succeed, the user will be presented with an alert view specifying whether it was a failed network connection, or an incorrect email and password.

<img src="https://lh5.googleusercontent.com/UtYdVs086wOJ3wbumC9dgl9gt1NuUfWMn2X3fBceHC0c7wXGzgd2OdVoMkChLqVCCX25ovTQkOvUfDBFcz2vcfK7xXmfmjDPElhbc1Lxgwhefk6mn7qEzf8wkOcn4jCXu2Rdr0E1" width="200" height="360" />

## Map And Table Tabbed View
- This view has two tabs at the bottom: one specifying a map, and the other a table.
- When the **map tab** is selected, the view displays a map with pins specifying the last 100 locations posted by students.
- The user is able to zoom and scroll the map to any location using standard pinch and drag gestures.
- When the user taps a pin, it displays the pin annotation popup, with the student’s name (pulled from their Udacity profile) and the link associated with the student’s pin.
- Tapping anywhere within the annotation will launch Safari and direct it to the link associated with the pin.
- Tapping outside of the annotation will dismiss/hide it.
<img src="https://lh6.googleusercontent.com/kp0aiO9i4hBdfOyOcA5Ik6m95LxX2TUOZBanYCVxszywkuGGS8_McBMkLMPFb72VBH-UOqBnSu80hbrbO4doY2ZzWcU2GN46_fM5fOIx6GYZnwqySdzol51oQ_zWVWfgiZazJquX" width="200" height="360" />


<img src="https://lh3.googleusercontent.com/T-nmBfI9Ox8ygC_-zkVI18d7ET1wNjZD7s1GO6sX4CerH44IR789jNdT9QRLGH_TeL08sFXnDaWG5IfWPtaprUk6RjK2_S3Hnj-fGTVj4QEWePJduaPAMYGp5m4dnaZ8O9kODbYK" width="200" height="360" />


- When the **table tab** is selected, the most recent 100 locations posted by students are displayed in a table. Each row displays the name from the student’s Udacity profile. Tapping on the row launches Safari and opens the link associated with the student.
- Both the map tab and the table tab share the same top navigation bar.
- The rightmost bar button will be a refresh button. Clicking on the button will refresh the entire data set by downloading and displaying the most recent 100 posts made by students.
- The bar button directly to its left will be a pin button. Clicking on the pin button will modally present the **Information Posting View**.

## Information Posting View
- The Information Posting View allows users to input their own data.
- When the **Information Posting View** is modally presented, the user sees two text fields: one asks for a location and the other asks for a link.
- When the user clicks on the “Find Location” button, the app will forward geocode the string. If the forward geocode fails, the app will display an alert view notifying the user. Likewise, an alert will be displayed if the link is empty.
- If the forward geocode succeeds then text fields will be hidden, and a map showing the entered location will be displayed. Tapping the “Finish” button will post the location and link to the server.
- If the submission fails to post the data to the server, then the user should see an alert with an error message describing the failure.
- If at any point the user clicks on the “Cancel” button, then the Information Posting View should be dismissed, returning the app to the Map and Table Tabbed View.
- Likewise, if the submission succeeds, then the Information Posting View should be dismissed, returning the app to the Map and Table Tabbed View.






