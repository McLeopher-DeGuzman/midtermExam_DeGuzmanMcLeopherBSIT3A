import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String course;
  final String imageUrl;

  Person(this.name, this.address, this.course, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Gal Gadot', '30 April 1985', 'Actress, Model, Produce',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/278492222_538770280935897_2064189562439332777_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=Kk_9HYVdNdUAX89L1nY&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfDg6GugyyCu9hBeIyodhg_pn2ySOBInGQa-uAnMVHDP7Q&oe=6450710E'),
    Person('Vin Diesel', 'July 18, 1967', 'Actor, producer, writer, director',
    'https://scontent.fcrk2-1.fna.fbcdn.net/v/t31.18172-8/18422531_10155404566568313_1640291550542757129_o.jpg?_nc_cat=102&ccb=1-7&_nc_sid=19026a&_nc_ohc=Mf5Ohr1JxfkAX8oxo7_&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfBFsZnrZz5UA5CvZ-kPEaNCU8xWlCqqnGZX6WHcEioeIA&oe=6472E8DB'),
    Person('Paul Walker', 'September 12, 1973', 'Actor',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t1.6435-9/128885425_251531402992705_558593375994093418_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=ldZnBmPAf7EAX8G6YdS&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfCxuiIywxfEnW4SDVB1xKSJqZVZmD2PqocoxaUqsv_GpQ&oe=6472FD81'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIDTERM EXAM',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('User Profile'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/prof.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                   radius: 40,
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Born:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Occupation',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.course,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.white,
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
