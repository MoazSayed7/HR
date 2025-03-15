[![Stand With Palestine](https://raw.githubusercontent.com/TheBSD/StandWithPalestine/main/banner-no-action.svg)](https://thebsd.github.io/StandWithPalestine)

# 📱 Flutter HR Application

## Overview

This Flutter project is an HR application designed to simplify attendance tracking for employees. The app features a clean and user-friendly interface with functionalities like user authentication (including fingerprint login), attendance logging with location verification, and a records page to view attendance history. Attendance data is stored locally using `SharedPreferences`.

## Screenshots

### Sign-In Screen
<HTML>
    <body>
        <img src="https://github.com/user-attachments/assets/593e4ec7-af14-47b3-8dca-bfa8cd472b6d" alt="drawing" style="width:250px;"/>
    </body>
</HTML>

### Sign-Up Screen
<HTML>
    <body>
        <img src="https://github.com/user-attachments/assets/05d67163-989b-48d1-99b7-e99ad4839415" alt="drawing" style="width:250px;"/>
    </body>
</HTML>

### Local Auth Screen (Fingerprint)
<HTML>
    <body>
        <img src="https://github.com/user-attachments/assets/d25f5e31-44af-4e33-ac56-dd72a4f86ddc" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/0b9b25a6-aad8-452b-800e-078aecd7d146" alt="drawing" style="width:250px;"/>
    </body>
</HTML>

### Home Screen
<HTML>
    <body>
        <img src="https://github.com/user-attachments/assets/8eba4592-1ad0-482e-8fb6-20ba61af8f3f" alt="drawing" style="width:250px;"/>
    </body>
</HTML>

### Attendance Records Screen
<HTML>
    <body>
        <img src="https://github.com/user-attachments/assets/145f0046-3985-4375-a64c-12287baec022" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/d6043df2-b9ee-40f1-8816-03d7978afef1" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/22464a66-6171-43a2-bd08-296274ba7e04" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/de754d3a-faac-4fc1-b858-764271c39ba9" alt="drawing" style="width:250px;"/>
    </body>
</HTML>


## Features

- **User Authentication:**
  - Email/password registration and login using Firebase Authentication.
  - Fingerprint authentication for secure access after login using `local_auth`.
  - Email verification check before granting full access.

- **Attendance Logging:**
  - Button to log attendance with real-time location verification using `geolocator`.
  - Confirmation message displayed after successful logging.
  - Records stored locally in `SharedPreferences`, tied to the user’s Firebase UID for separation.

- **Attendance Records:**
  - View a list of attendance records with timestamps and locations.
  - Filter records by date range using a modern date picker.
  - Tap a record to open Google Maps with the logged location.

- **Security:**
  - Fingerprint authentication required for signed-in users on app launch.
  - Local data storage ensures records are tied to the user’s UID within the app.

- **UI/UX:**
  - Clean, modern interface with animated cards and responsive design.
  - Adaptive layouts using `flutter_screenutil` for different screen sizes.

## Dependencies

- `firebase_auth`: Manages user authentication with Firebase.
- `firebase_core`: Initializes the Firebase connection.
- `flutter_bloc`: State management for a scalable architecture.
- `flutter_screenutil`: Adapts UI elements to various screen sizes.
- `geolocator`: Retrieves device location for attendance logging.
- `intl`: Formats dates and times for records display.
- `local_auth`: Enables fingerprint authentication for secure access.
- `shared_preferences`: Stores attendance records locally, tied to user UID.
- `maps_launcher`: Opens Google Maps with attendance locations.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/MoazSayed7/hr

2. Navigate to the project directory:
   ```bash
   cd hr
3. Install dependencies:
   ```bash
   flutter pub get

4. Configure Firebase:
   - Create a Firebase project at [https://console.firebase.google.com/](https://console.firebase.google.com/).
   - Enable Firebase Authentication (Email/Password).
   - Set up Firebase for your project by following the [Using Firebase CLI](https://firebase.google.com/docs/flutter/setup).

5. Run the app:
   ```bash
   flutter run
