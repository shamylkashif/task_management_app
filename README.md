Task Management App
Overview
This is a Flutter-based Task Management application that allows users to manage their tasks efficiently. It features creating, updating, and deleting tasks, with options to set specific times and dates for each task. The app's intuitive UI allows users to interact with the task list easily.

Features
Task Creation: Users can add new tasks with a title, subtitle, time, and date.

Task Update: Tasks can be updated by modifying their title and subtitle or changing the scheduled time/date.

Task Deletion: Users can delete tasks from the task list.

Date & Time Picker: Users can select a time and date for each task.

Responsive UI: The app adjusts to different screen sizes and provides a smooth user experience on both small and large devices.

Screens
1. HomeView Screen
   Displays the list of tasks.

Allows navigating to the task creation/editing screen.

2. TaskView Screen
   A detailed screen for creating and updating tasks.

Users can input task titles, subtitles, and select a specific time and date.

Options to delete or save a task.

3. Main Screen
   The initial screen of the app that allows the user to manage tasks.

Dependencies
   flutter: The Flutter framework.

intl: For formatting dates and times.

provider (if you're using it for state management in other parts of the app).

flutter_localizations: For localization support (if you plan on adding multi-language support).

Usage
Create a Task: On the main screen, tap the "Add Task" button to enter the task creation screen. Enter a task title, subtitle, and select a time and date for the task.

Update a Task: If you're editing an existing task, the task details will automatically be filled in. You can modify the title, subtitle, and date/time. Tap "Update Task" to save changes.

Delete a Task: You can delete a task from the task detail screen by tapping the delete button.

Code Structure
TaskView
This screen handles task creation and editing. It uses a TextEditingController for both the title and subtitle of the task, allowing the user to modify these fields. It also provides a DateTimePicker to select a task's date and time.

Main Screen & HomeView
The main screen shows a list of all tasks stored in the app.

The home view is responsible for navigating between screens and displaying tasks.

Task Model
The Task model defines the properties for each task, including:

title

subtitle

createdAtTime

createdAtDate

These tasks are managed through a data store.

Future Enhancements
Authentication: Adding user authentication so users can manage their tasks securely.

Task Priority: Allow users to set priority levels for tasks.

Notifications: Send reminders or notifications for tasks as their scheduled time approaches.

Theme Support: Implement light/dark themes for better user experience.