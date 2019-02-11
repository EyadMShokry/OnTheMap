# OnTheMap
The On The Map app allows users to share their location and a URL with their fellow students. To visualize this data, On The Map uses a map with pins for location and pin annotations for student names and URLs, allowing students to place themselves “on the map,” so to speak.

# Application Scenario
First, the user logs in to the app using their Udacity username and password. After login, the app downloads locations and links previously posted by other students. These links can point to any URL that a student chooses.

After viewing the information posted by other students, a user can post their own location and link. The locations are specified with a string and forward geocoded. They can be as specific as a full street address or as generic as “Costa Rica” or “Seattle, WA.”

# Application Scenes:
- Login View: Allows the user to log in using their Udacity credentials.
- Map and Table Tabbed View: Allows users to see the locations of other students in two formats.
- Information Posting View: Allows the users specify their own locations and links.

These three scenes are described in detail below.

## Login View
The login view accepts the email address and password that students use to login to the Udacity site. User credentials are not required to be saved upon successful login.


When the user taps the Login button, the app will attempt to authenticate with Udacity’s servers.


Clicking on the Sign Up link will open Safari to the Udacity sign-up page.


If the connection is made and the email and password are good, the app will segue to the Map and Table Tabbed View.
<img src="https://lh5.googleusercontent.com/UtYdVs086wOJ3wbumC9dgl9gt1NuUfWMn2X3fBceHC0c7wXGzgd2OdVoMkChLqVCCX25ovTQkOvUfDBFcz2vcfK7xXmfmjDPElhbc1Lxgwhefk6mn7qEzf8wkOcn4jCXu2Rdr0E1" width="200" height="360" />

