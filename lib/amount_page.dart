import 'package:flutter/material.dart';

class ScrollableValueSelector extends StatefulWidget {
  @override
  _ScrollableValueSelectorState createState() => _ScrollableValueSelectorState();
}

class _ScrollableValueSelectorState extends State<ScrollableValueSelector> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 1; // Default selected index
  final List<String> _values = ['0.10', '0.50', '1.00', '5']; // Displayed values

  void _moveForward() {
    setState(() {
      if (_selectedIndex < _values.length - 1) {
        _selectedIndex++;
        _scrollToIndex(_selectedIndex);
      }
    });
  }

  void _moveBackward() {
    setState(() {
      if (_selectedIndex > 0) {
        _selectedIndex--;
        _scrollToIndex(_selectedIndex);
      }
    });
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * 100.0, // Adjust the width per item
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20), // Space above the UI
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Backward Arrow Button
            GestureDetector(
              onTap: _moveBackward,
              child: Icon(Icons.arrow_left, size: 40, color: Colors.white),
            ),
            // Scrollable List
            Container(
              width: 200, // Adjust width as per your design
              height: 60, // Adjust height
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: _values.length,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedIndex;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _selectedIndex=index;
                            });
                          },
                          child: Text(
                            _values[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.white70,
                            ),
                          ),
                        ),
                        Text(
                          'DMO',
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Forward Arrow Button
            GestureDetector(
              onTap: _moveForward,
              child: Icon(Icons.arrow_right, size: 40, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
