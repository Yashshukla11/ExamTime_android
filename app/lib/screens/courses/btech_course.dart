import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:flutter/material.dart';

class BtexhCourse extends StatelessWidget {
  const BtexhCourse({super.key});

  @override
  Widget build(BuildContext context) {
    const imageLinks = [
      'assets/img/cse.png',
      'assets/img/ece.png',
      'assets/img/ee.png',
      'assets/img/civil.png',
      // 'assets/img/phar.png',
    ];
    const stremas = ['CSE', 'ECE', 'EE', 'CIVIL'];
    return Scaffold(
      appBar: const CommonNavBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: GridView.builder(
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>))
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    //  color: Colors.amber,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 0.5,
                              color: Color.fromARGB(255, 172, 172, 172))
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset(
                              imageLinks[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            stremas[index],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: Divider(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod",
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
