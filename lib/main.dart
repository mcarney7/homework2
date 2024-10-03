import 'package:flutter/material.dart';

// The entry point of the app, launching the CalculatorApp widget.
void main() {
  runApp(CalculatorApp());
}

// CalculatorApp serves as the root widget for the entire app.
// It sets up the theme and the home screen.
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner in the top right corner.
      title: 'Calculator App', // Title of the app.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the theme color of the app.
      ),
      home: CalculatorHome(), // Sets the home screen to be the CalculatorHome widget.
    );
  }
}

// CalculatorHome is a stateful widget that holds the main functionality of the calculator.
class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

// State class for CalculatorHome that handles the UI and the logic for the calculator.
class _CalculatorHomeState extends State<CalculatorHome> {
  // Variables to manage the output and internal state of the calculator.
  String output = "0"; // The displayed output on the calculator screen.
  String _output = "0"; // Internal temporary output for calculation purposes.
  double num1 = 0.0; // First operand for calculations.
  double num2 = 0.0; // Second operand for calculations.
  String operand = ""; // Operator that the user selects (e.g., +, -, *, /).

  // Function to handle what happens when a button is pressed.
  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      // If "CLEAR" button is pressed, reset everything to default values.
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } 
    else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      // If an operator is pressed, store the first number (num1) and the operator, then reset the output.
      num1 = double.parse(output); // Convert the current displayed output to a number.
      operand = buttonText; // Store the selected operator.
      _output = "0"; // Reset output for the next number input (num2).
    } 
    else if (buttonText == ".") {
      // Handle decimal points, ensuring no multiple decimals are allowed in the same number.
      if (_output.contains(".")) {
        // If there's already a decimal point, do nothing.
        return;
      } else {
        _output = _output + buttonText; // Append the decimal point to the number.
      }
    } 
    else if (buttonText == "=") {
      // Handle the calculation when "=" is pressed.
      num2 = double.parse(output); // Convert the current displayed output (num2) to a number.

      // Perform the appropriate calculation based on the operator stored in operand.
      if (operand == "+") {
        _output = (num1 + num2).toString(); // Addition.
      } else if (operand == "-") {
        _output = (num1 - num2).toString(); // Subtraction.
      } else if (operand == "*") {
        _output = (num1 * num2).toString(); // Multiplication.
      } else if (operand == "/") {
        // Handle division, checking for division by zero.
        if (num2 != 0) {
          _output = (num1 / num2).toString(); // Division.
        } else {
          _output = "Error"; // Set output to "Error" if dividing by zero.
        }
      }

      // Reset the values of num1, num2, and operand after calculation.
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } 
    else {
      // Handle number inputs. Concatenate new numbers to the existing output.
      _output = _output + buttonText;
    }

    // Update the displayed output to reflect the most recent calculation or input.
    setState(() {
      output = double.parse(_output).toStringAsFixed(2); // Convert to a number with 2 decimal places.
    });
  }

  // Helper method to build each button on the calculator UI.
  Widget buildButton(String buttonText) {
    return Expanded(
      // TextButton is used for creating the interactive calculator buttons.
      child: TextButton(
        // Style the buttons with padding, text color, and background color.
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(24.0), // Padding inside the button for spacing.
          foregroundColor: Colors.black, // Text color of the button.
          backgroundColor: Colors.grey[200], // Background color of the button.
        ),
        // When the button is pressed, it triggers the buttonPressed function.
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText, // The displayed text on the button (e.g., 1, 2, +, -, etc.).
          style: TextStyle(
            fontSize: 20.0, // Font size of the button text.
            fontWeight: FontWeight.bold, // Bold text for readability.
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'), // Title of the app in the app bar.
      ),
      // Main body of the calculator, structured using Column and Rows.
      body: Column(
        children: <Widget>[
          // Display area for the calculator's current output.
          Container(
            alignment: Alignment.centerRight, // Align the output text to the right.
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0), // Padding for spacing.
            child: Text(
              output, // Display the current output.
              style: TextStyle(
                fontSize: 48.0, // Large font size for the display.
                fontWeight: FontWeight.bold, // Bold text for emphasis.
              ),
            ),
          ),
          Expanded(
            child: Divider(), // Divider for separating the display from the buttons.
          ),
          // Rows of calculator buttons organized in a grid-like structure.
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"), // Division button.
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"), // Multiplication button.
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"), // Subtraction button.
                ],
              ),
              Row(
                children: [
                  buildButton("."), // Decimal point button.
                  buildButton("0"),
                  buildButton("00"), // Double zero button.
                  buildButton("+"), // Addition button.
                ],
              ),
              Row(
                children: [
                  buildButton("CLEAR"), // Button to clear the calculator.
                  buildButton("="), // Button to calculate the result.
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
