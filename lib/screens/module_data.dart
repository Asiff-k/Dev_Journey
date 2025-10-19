// module_data.dart

class Module {
  final String title;
  final String duration;
  final String level;
  final String content;

  Module({
    required this.title,
    required this.duration,
    required this.level,
    required this.content,
  });
}

// --- Web Development Modules ---

final List<Module> webDevModules = [
  Module(
    title: "HTML Basics & Semantic Web",
    duration: "2 Weeks",
    level: "Beginner",
    content: '''
# HTML Basics & Semantic Web

## Introduction to HTML
HTML (HyperText Markup Language) is the standard markup language for documents designed to be displayed in a web browser. It defines the meaning and structure of web content.

### Example: Basic HTML Document
This example shows a simple HTML document structure.

```html
<!DOCTYPE html>
<html>
<head>
  <title>My First Web Page</title>
</head>
<body>

  <h1>Welcome to My Website</h1>
  <p>This is my first paragraph.</p>

</body>
</html>
```

## Semantic HTML
Semantic HTML elements are those that clearly describe their meaning in a human- and machine-readable way.

Elements like `<header>`, `<footer>`, `<article>`, and `<section>` are considered semantic because they accurately describe the purpose of the element and the type of content that is inside them.
''',
  ),
  Module(
    title: "CSS Fundamentals",
    duration: "3 Weeks",
    level: "Beginner",
    content: '''
# CSS Fundamentals

## Introduction to CSS
CSS (Cascading Style Sheets) is a style sheet language used for describing the presentation of a document written in a markup language such as HTML.

### Example: Basic CSS Styling
Here's how you can style a paragraph element to have blue text and a larger font size.

```css
p {
  color: blue;
  font-size: 18px;
  line-height: 1.6;
}
```

## The Box Model
In CSS, every element is a rectangular box. The CSS box model describes how the space of an element is calculated, including its margin, border, padding, and the content itself.
''',
  ),
  Module(
    title: "JavaScript Essentials",
    duration: "4 Weeks",
    level: "Beginner",
    content: '''
# JavaScript Essentials

## Introduction to JavaScript
JavaScript is a programming language that enables you to create dynamically updating content, control multimedia, animate images, and much more.

### Example: A Simple Script
This script finds an HTML element with the id "demo" and changes its content.

```javascript
function myFunction() {
  document.getElementById("demo").innerHTML = "Hello JavaScript!";
}
```

## Variables and Data Types
In JavaScript, variables are containers for storing data values. You can declare variables using `var`, `let`, and `const`. Common data types include strings, numbers, booleans, and objects.
''',
  ),
];


final List<Module> mobileDevModules = [
  Module(
    title: "Dart Fundamentals",
    duration: "3 Weeks",
    level: "Beginner",
    content: '''
# Dart Fundamentals

## Introduction to Dart
Dart is the programming language used to build Flutter apps. It's an object-oriented, class-based, garbage-collected language with C-style syntax.

### Example: Hello World in Dart
A simple "Hello, World!" program is a great starting point.

```dart
void main() {
  print('Hello, World!');
}
```

## Key Concepts
- **Variables & Data Types**: `int`, `double`, `String`, `bool`, `List`, `Map`.
- **Functions**: How to define and call functions.
- **Control Flow**: `if`, `else`, `for` loops, `while` loops.
- **Classes & Objects**: The basics of object-oriented programming.
''',
  ),
  Module(
    title: "Flutter Basics & UI",
    duration: "4 Weeks",
    level: "Beginner",
    content: '''
# Flutter Basics & UI

## Introduction to Flutter
Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.

## Widgets
In Flutter, everything is a widget! Widgets are the basic building blocks of a UI.

### Example: A Simple Flutter App
This code creates a simple screen with centered text.

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My First App'),
        ),
        body: const Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
```
## Common Widgets
- **Layout Widgets**: `Container`, `Row`, `Column`, `Stack`.
- **UI Widgets**: `Text`, `Image`, `Icon`, `ElevatedButton`.
''',
  ),
  Module(
    title: "State Management",
    duration: "3 Weeks",
    level: "Intermediate",
    content: '''
# State Management

## What is State?
In Flutter, "state" is whatever data you need in order to rebuild your UI at any moment in time.

## StatefulWidget
A `StatefulWidget` is a widget that has mutable state.

### Example: A Simple Counter
```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ElevatedButton(onPressed: _increment, child: const Text('Increment')),
        Text('Count: \$_count'),
      ],
    );
  }
}
```
## Advanced State Management
For larger apps, consider solutions like Provider, BLoC, or Riverpod.
''',
  ),
  Module(
    title: "Networking & APIs",
    duration: "3 Weeks",
    level: "Intermediate",
    content: '''
# Networking & APIs

## Fetching Data from the Internet
Most apps need to fetch data from a server. The `http` package is a popular way to do this in Flutter.

### Example: Fetching a Post
This example shows how to fetch a sample post from the JSONPlaceholder API.

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Post> fetchPost() async {
  final response = await http.get(Uri.parse('[https://jsonplaceholder.typicode.com/posts/1](https://jsonplaceholder.typicode.com/posts/1)'));

  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
```
''',
  ),
  Module(
    title: "Firebase Integration",
    duration: "4 Weeks",
    level: "Advanced",
    content: '''
# Firebase Integration

## What is Firebase?
Firebase is a platform developed by Google for creating mobile and web applications. It provides a suite of tools for building, improving, and growing your app.

## Services
- **Authentication**: Sign in users with email, social providers, and more.
- **Firestore**: A flexible, scalable NoSQL cloud database.
- **Cloud Storage**: Store and manage user-generated content like photos and videos.
- **Cloud Functions**: Run backend code without managing servers.

### Example: Adding a Document to Firestore
```dart
FirebaseFirestore.instance.collection('users').add({
  'fullName': 'John Doe',
  'email': 'john.doe@example.com',
  'age': 25,
});
```
''',
  ),
];

final List<Module> AIDevModules = [
  Module(
    title: "Python for Data Science",
    duration: "4 Weeks",
    level: "Beginner",
    content: '''
# Python for Data Science Foundations

## Introduction
Python is the leading language for AI and Machine Learning. This module covers the essential libraries that form the bedrock of data science projects.

## Key Libraries
- **NumPy**: For numerical operations, especially with arrays and matrices.
- **Pandas**: For data manipulation and analysis using DataFrames.
- **Matplotlib & Seaborn**: For data visualization.

### Example: Loading and Plotting Data
This snippet shows how to use Pandas to read a CSV file and Matplotlib to create a simple plot.

```python
import pandas as pd
import matplotlib.pyplot as plt

# Read data from a CSV file
data = pd.read_csv('sample_data.csv')

# Display the first 5 rows
print(data.head())

# Create a simple plot
data['some_column'].plot(kind='hist', title='Distribution of Some Column')
plt.show()
```
''',
  ),
  Module(
    title: "Intro to Machine Learning",
    duration: "3 Weeks",
    level: "Intermediate",
    content: '''
# Introduction to Machine Learning

## Core Concepts
Machine learning gives computers the ability to learn without being explicitly programmed. This module introduces the fundamental concepts and terminology.

## Types of Machine Learning
- **Supervised Learning**: Learning from labeled data (e.g., spam detection).
- **Unsupervised Learning**: Finding patterns in unlabeled data (e.g., customer segmentation).
- **Reinforcement Learning**: An agent learns to make decisions by taking actions in an environment to maximize a reward (e.g., training a bot to play a game).

## The ML Workflow
1.  **Data Collection**: Gathering the data.
2.  **Data Preprocessing**: Cleaning and preparing the data.
3.  **Model Training**: Choosing an algorithm and training it on the data.
4.  **Model Evaluation**: Assessing the model's performance.
5.  **Deployment**: Making the model available for use.
''',
  ),
  Module(
    title: "Supervised Learning Algorithms",
    duration: "5 Weeks",
    level: "Intermediate",
    content: '''
# Supervised Learning Algorithms

## Regression
Regression models predict a continuous value (e.g., predicting a house price).
- **Linear Regression**: A simple model that finds a linear relationship between input and output variables.

## Classification
Classification models predict a discrete category (e.g., classifying an email as 'spam' or 'not spam').
- **Logistic Regression**: Used for binary classification.
- **Decision Trees**: A flowchart-like structure where each internal node represents a "test" on an attribute.
- **Support Vector Machines (SVMs)**: Effective in high-dimensional spaces.

### Example: Training a Classifier with Scikit-learn
```python
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score

# X contains features, y contains labels
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Initialize and train the model
clf = DecisionTreeClassifier()
clf.fit(X_train, y_train)

# Make predictions
y_pred = clf.predict(X_test)

# Evaluate accuracy
print('Accuracy:', accuracy_score(y_test, y_pred))
```
''',
  ),
];

final List<Module> softwareDevModules = [
  Module(
    title: "Software Engineering Fundamentals",
    duration: "5 Weeks",
    level: "Beginner",
    content: '''
# Software Engineering Fundamentals

## Overview
This module introduces the basics of software engineering, including Software Development Life Cycle (SDLC) models, Agile methodology, and requirement analysis.

### Topics Covered
- SDLC Models: Waterfall, Agile, Iterative
- Requirement Analysis and Documentation
- Software Process Models
- Basics of Software Design and Quality
''',
  ),
  Module(
    title: "Object-Oriented Programming (OOP)",
    duration: "4 Weeks",
    level: "Intermediate",
    content: '''
# Object-Oriented Programming (OOP)

## Overview
Learn how to design and implement software systems using OOP principles such as encapsulation, inheritance, and polymorphism.

### Topics Covered
- Classes and Objects
- Inheritance and Polymorphism
- Encapsulation and Abstraction
- UML Class Diagrams

### Example (in Java)
```java
class Vehicle {
  void start() {
    System.out.println("Vehicle started");
  }
}

class Car extends Vehicle {
  void start() {
    System.out.println("Car started");
  }
}

public class Main {
  public static void main(String[] args) {
    Vehicle v = new Car();
    v.start();
  }
}
```
''',
  ),
  Module(
    title: "Software Design Patterns",
    duration: "3 Weeks",
    level: "Advanced",
    content: '''
# Software Design Patterns

## Overview
This module introduces reusable design solutions for common software architecture problems.

### Key Patterns
- **Singleton Pattern**: Ensures a class has only one instance.
- **Factory Pattern**: Creates objects without specifying the exact class.
- **Observer Pattern**: Enables event-driven communication.

### Example (Singleton in Python)
```python
class Singleton:
    _instance = None
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

obj1 = Singleton()
obj2 = Singleton()
print(obj1 is obj2)  # True
```
''',
  ),
  Module(
    title: "Software Testing and Quality Assurance",
    duration: "4 Weeks",
    level: "Intermediate",
    content: '''
# Software Testing and Quality Assurance

## Overview
This module focuses on testing methodologies, QA processes, and automation tools.

### Topics Covered
- Unit, Integration, and System Testing
- Test-Driven Development (TDD)
- Manual vs Automated Testing
- Common QA Tools: JUnit, Selenium, Postman

### Example (JUnit Test)
```java
import org.junit.Test;
import static org.junit.Assert.*;

public class CalculatorTest {
  @Test
  public void testAdd() {
    Calculator calc = new Calculator();
    assertEquals(5, calc.add(2, 3));
  }
}
```
''',
  ),
];

