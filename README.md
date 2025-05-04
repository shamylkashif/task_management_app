**Task Management App**


**Overview**
This is a Flutter-based Task Management application that allows users to manage their tasks efficiently. It features creating, updating, and deleting tasks, with options to set specific times and dates for each task. The app's intuitive UI allows users to interact with the task list easily.

**Features**
1. Task Creation: Users can add new tasks with a title, subtitle, time, and date.

2. Task Update: Tasks can be updated by modifying their title and subtitle or changing the scheduled time/date.

3. Task Deletion: Users can delete tasks from the task list.

4. Date & Time Picker: Users can select a time and date for each task.

5. Responsive UI: The app adjusts to different screen sizes and provides a smooth user experience on both small and large devices.

**Screens**
1. HomeView Screen
Displays the list of tasks.

Allows navigating to the task creation/editing screen.

2. TaskView Screen
A detailed screen for creating and updating tasks.

Users can input task titles, subtitles, and select a specific time and date.

Options to delete or save a task.

3. Main Screen
The initial screen of the app that allows the user to manage tasks.

**Dependencies**
1. hive_flutter:A lightweight and fast key-value database, used for storing tasks locally.

2. uuid:A library for generating unique identifiers (UUIDs) for each task.

3. intl:Provides internationalization and localization utilities, used for formatting dates and times.

4. animate_do:A package for adding animations to the app, improving the UI experience.

5. panara_dialogs:A package to display beautiful dialogs, enhancing user interaction.

6. lottie:A package to render animations exported as JSON, adding animation features.

7. ftoast:Provides custom toast notifications, used for showing quick messages in the app.

8. flutter_slider_drawer:A custom drawer widget for sliding menus in the app, providing a smooth user interface.

9. flutter_datetime_picker:A package for picking dates and times, used in the task creation and editing screens.
   
**Usage**
1. Create a Task: On the main screen, tap the "Add Task" button to enter the task creation screen. Enter a task title, subtitle, and select a time and date for the task.

2. Update a Task: If you're editing an existing task, the task details will automatically be filled in. You can modify the title, subtitle, and date/time. Tap "Update Task" to save changes.

3. Delete a Task: You can delete a task from the task detail screen by tapping the delete button.

**Code Structure**
1. TaskView
This screen handles task creation and editing. It uses a TextEditingController for both the title and subtitle of the task, allowing the user to modify these fields. It also provides a DateTimePicker to select a task's date and time.

2. Main Screen & HomeView
The main screen shows a list of all tasks stored in the app.

The home view is responsible for navigating between screens and displaying tasks.

3. Task Model
The Task model defines the properties for each task, including:

1. title

2. subtitle

3. createdAtTime

4. createdAtDate

These tasks are managed through a data store.

**Future Enhancements**
1. Authentication: Adding user authentication so users can manage their tasks securely.

2. Task Priority: Allow users to set priority levels for tasks.

3. Notifications: Send reminders or notifications for tasks as their scheduled time approaches.

4. Theme Support: Implement light/dark themes for better user experience.
