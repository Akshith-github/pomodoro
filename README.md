# Pomodoro

Flutter project (learning purpose) 

Replicating Pomodoro app UI and functionality from https://www.youtube.com/watch?v=I2PSCjAR1RY 

## Getting Started

Figma designs - https://www.figma.com/design/iekE3NAbVsjHPr0hFkXxGV/Untitled?node-id=0-1&t=1nc0QJr6dCsIbUU5-1 

Below image shows the three pages of application developed in this project

![Pomodoro App Screenshots](./assets/images/pages_design.png)

Three main pages of the application are as follows:

1. Home Page - Displays the timer and start/pause button.
2. Add Task Page - Allows users to add new tasks.
3. Task Timer Page - Displays the task name and timer.


## Dependencies

Note: In VS Code, use Pubspec Assist extension to easily add/remove dependencies in pubspec.yaml file.
The project uses the following dependencies (pub.dev packages):

- flex_color_scheme

## Commands 

To create a new Flutter project:

```bash
flutter create pomodoro --platforms=android,ios
```

To run the application:

```bash
flutter run
```

Manage dependencies:

add packages to pubspec.yaml and run the following command to get packages
```bash
flutter pub get
```

flutter doctor command to check for any issues
```bash
flutter doctor
```


## Tips

- Use Physical Device for testing the application for better performance.


## Learn More

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
