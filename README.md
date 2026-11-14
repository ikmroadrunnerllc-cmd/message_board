# Message Board Vault (CSC 4360 - Homework 02)

**Student:** Mario Leonel Gutierrez Espinal  
**Course:** CSC 4360 – Mobile App Development  
**Assignment:** Homework 02 – The Message Board Vault Hunt  
**Platform:** Android (Flutter)

---

## What This App Does
- Opens with a styled splash screen while Firebase initializes.
- Handles user sign-in and registration with email and password.
- Stores a 5-field user profile in Cloud Firestore (`uid`, `firstName`, `lastName`, `role`, `registrationDateTime`).
- Displays messages live in real time using a Firestore snapshot stream.
- Allows users to post messages with server timestamps.
- Lets authors edit and delete only their own posts.
- Protects data with Firestore security rules so other users cannot alter documents.

---

## Project Structure
- `lib/main.dart`: App start and theme.
- `lib/models/`: Models for user record and messages.
- `lib/services/`: Authentication, user record, and board CRUD services.
- `lib/screens/`: Splash screen, login, registration, profile gate, and message board screen.
- `firestore.rules`: Security rules for users and messages collections.

---

## How to Run
1. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
2. Run static analysis:
   ```bash
   flutter analyze
   ```
3. Run tests:
   ```bash
   flutter test
   ```
4. Run on a connected Android phone or emulator:
   ```bash
   flutter run
   ```
5. Build release APK:
   ```bash
   flutter build apk --release
   ```
