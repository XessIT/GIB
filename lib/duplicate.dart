import 'package:flutter/material.dart';



// Create the state for the RadioListTile example
class RadioListTileExample extends StatefulWidget {
  @override
  _RadioListTileExampleState createState() => _RadioListTileExampleState();
}

class _RadioListTileExampleState extends State<RadioListTileExample> {
// Create a variable to store the selected value
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RadioListTile Example'), // Set the title of the app bar
      ),
      body: ListView(
        children: <Widget>[
          // Create a RadioListTile for option 1
          RadioListTile(
            title: Text('Option 1'), // Display the title for option 1
            subtitle: Text(
                'Subtitle for Option 1'), // Display a subtitle for option 1
            value: 1, // Assign a value of 1 to this option
            groupValue:
            _selectedValue, // Use _selectedValue to track the selected option
            onChanged: (value) {
              setState(() {
                _selectedValue =
                value!; // Update _selectedValue when option 1 is selected
              });
            },
          ),

          // Create a RadioListTile for option 2
          RadioListTile(
            title: Text('Option 2'), // Display the title for option 2
            subtitle: Text(
                'Subtitle for Option 2'), // Display a subtitle for option 2
            value: 2, // Assign a value of 2 to this option
            groupValue:
            _selectedValue, // Use _selectedValue to track the selected option
            onChanged: (value) {
              setState(() {
                _selectedValue =
                value!; // Update _selectedValue when option 2 is selected
              });
            },
          ),

          // Create a RadioListTile for option 3
          RadioListTile(
            title: Text('Option 3'), // Display the title for option 3
            subtitle: Text(
                'Subtitle for Option 3'), // Display a subtitle for option 3
            value: 3, // Assign a value of 3 to this option
            groupValue:
            _selectedValue, // Use _selectedValue to track the selected option
            onChanged: (value) {
              setState(() {
                _selectedValue =
                value!; // Update _selectedValue when option 3 is selected
              });
            },
          ),
        ],
      ),
    );
  }
}
