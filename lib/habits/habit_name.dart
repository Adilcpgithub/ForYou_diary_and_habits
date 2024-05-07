import 'package:flutter/material.dart';

class HabbitTile extends StatefulWidget {
  final String habbitName;

  const HabbitTile({
    super.key,
    required this.habbitName,
  });

  @override
  State<HabbitTile> createState() => _HabbitTileState();
}

class _HabbitTileState extends State<HabbitTile> {
  List<DateTime> dateList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Text container
            Padding(
              padding: const EdgeInsets.only(right: 9, top: 3),
              child: GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255), //color
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(.1),
                      bottomRight: Radius.circular(.1),
                      bottomLeft: Radius.circular(4),
                      topLeft: Radius.circular(4),
                    ),
                  ),
                  height: 36,
                  width: 151,
                  child: SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 4),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          widget.habbitName,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 9, 92, 201),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Checkbox container
          ],
        ),
      ],
    );
  }
}
