import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'call.dart'; // Import the CallPage
import 'favourite.dart'; // Import the FavouritesPage
import 'recent.dart'; // Import the RecentPage

class ContactsPage extends StatefulWidget {
  final SharedPreferences prefs;

  ContactsPage({Key? key, required this.prefs}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Map<String, String>> contacts = [];
  List<Map<String, String>> filteredContacts = [];
  List<Map<String, String>> favourites = [];
  List<Map<String, String>> recentCalls = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final String? contactsJson = widget.prefs.getString('contacts');
    if (contactsJson != null) {
      final List<dynamic> contactsList = jsonDecode(contactsJson);
      setState(() {
        contacts = contactsList.map((item) => Map<String, String>.from(item)).toList();
        filteredContacts = contacts;
        favourites = contacts.where((contact) => contact['isFavourite'] == 'true').toList();
        recentCalls = contacts.where((contact) => contact['isRecent'] == 'true').toList();
      });
    } else {
      contacts = [];
      filteredContacts = contacts;
      favourites = [];
      recentCalls = [];
      _saveContacts();
    }
  }

  Future<void> _saveContacts() async {
    final String contactsJson = jsonEncode(contacts);
    await widget.prefs.setString('contacts', contactsJson);
  }

  void _filterContacts(String query) {
    setState(() {
      filteredContacts = contacts.where((contact) =>
          contact['name']!.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _toggleFavourite(int index) {
    setState(() {
      contacts[index]['isFavourite'] = contacts[index]['isFavourite'] == 'true' ? 'false' : 'true';
      favourites = contacts.where((contact) => contact['isFavourite'] == 'true').toList();
      _saveContacts();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addRecentCall(String phone, String number) {
    final now = DateTime.now();
    final formattedDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final formattedTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final contact = contacts.firstWhere(
      (contact) => contact['phone'] == phone,
      orElse: () => {},
    );

    final name = contact.isNotEmpty ? contact['name']! : 'Unknown';

    setState(() {
      recentCalls.insert(0, {
        'name': name,
        'phone': number,
        'isRecent': 'true',
        'date': formattedDate,
        'time': formattedTime,
      });
      _saveContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Contacts' : (_selectedIndex == 1 ? 'Favourites' : 'Recent Calls')),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Devanarayanan S B'),
              accountEmail: Text('devan20034014@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.account_circle, size: 50),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          _selectedIndex == 0 
              ? _buildContactsPage()
              : _selectedIndex == 1 
                  ? FavouritesPage(favourites: favourites) 
                  : RecentPage(recentCalls: recentCalls),
          if (_selectedIndex == 0)
            Positioned(
              bottom: 80,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  _showDialPadBottomSheet();
                },
                child: Icon(Icons.dialpad),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Recent',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _showAddContactBottomSheet();
              },
              child: Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildContactsPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search contacts',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onChanged: _filterContacts,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredContacts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredContacts[index]['name']!),
                subtitle: Text(filteredContacts[index]['phone']!),
                trailing: IconButton(
                  icon: Icon(
                    filteredContacts[index]['isFavourite'] == 'true'
                        ? Icons.star
                        : Icons.star_border,
                    color: filteredContacts[index]['isFavourite'] == 'true'
                        ? Colors.yellow
                        : null,
                  ),
                  onPressed: () {
                    _toggleFavourite(index);
                  },
                ),
                onTap: () {
                  _showContactOptionsDialog(index);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAddContactBottomSheet({int? index, String? phoneNumber}) {
    String name = index != null ? contacts[index]['name']! : '';
    phoneNumber = phoneNumber ?? (index != null ? contacts[index]['phone']! : '');

    final nameController = TextEditingController(text: name);
    final phoneController = TextEditingController(text: phoneNumber);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                index == null ? 'Add New Contact' : 'Edit Contact',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  phoneNumber = value;
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (name.isNotEmpty && phoneNumber?.length == 10) {
                        if (index == null) {
                          _addContact(name, phoneNumber!);
                        } else {
                          _editContact(index, name, phoneNumber!);
                        }
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Name cannot be empty and phone number must be 10 digits')),
                        );
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _addContact(String name, String phone) {
    setState(() {
      contacts.add({
        'name': name,
        'phone': phone,
        'isFavourite': 'false',
        'isRecent': 'false',
      });
      filteredContacts = contacts;
      _saveContacts();
    });
  }

  void _editContact(int index, String name, String phone) {
    setState(() {
      contacts[index] = {
        'name': name,
        'phone': phone,
        'isFavourite': contacts[index]['isFavourite']!,
        'isRecent': contacts[index]['isRecent']!,
      };
      filteredContacts = contacts;
      _saveContacts();
    });
  }

  void _showContactOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Contact Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showAddContactBottomSheet(index: index);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.of(context).pop();
                  _deleteContact(index);
                },
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Call'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallPage(
                        phoneNumber: contacts[index]['phone']!,
                        callerName: contacts[index]['name']!,
                        numberHolderName: '',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
      filteredContacts = contacts;
      _saveContacts();
    });
  }

  void _showDialPadBottomSheet() {
    TextEditingController phoneNumberController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dial a Number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Enter phone number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.backspace),
                    onPressed: () {
                      if (phoneNumberController.text.isNotEmpty) {
                        phoneNumberController.text = phoneNumberController.text
                            .substring(0, phoneNumberController.text.length - 1);
                      }
                    },
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 250,
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 30,
                  childAspectRatio: 2.3,
                  children: [
                    for (var key in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#'])
                      ElevatedButton(
                        onPressed: () {
                          phoneNumberController.text += key;
                        },
                        child: Text(
                          key,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (phoneNumberController.text.isNotEmpty && phoneNumberController.text.length == 10) {
                        _addRecentCall('Unknown', phoneNumberController.text);
                        Navigator.of(context).pop(); // Close the bottom sheet
                        _showAddContactBottomSheet(phoneNumber: phoneNumberController.text); // Open Add Contact
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Phone number must be 10 digits')),
                        );
                      }
                    },
                    child: Text('Add Contact'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Background color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (phoneNumberController.text.isNotEmpty && phoneNumberController.text.length == 10) {
                        _addRecentCall('Unknown', phoneNumberController.text);
                        Navigator.of(context).pop(); // Close the bottom sheet
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallPage(
                              phoneNumber: phoneNumberController.text,
                              callerName: 'Unknown', // Default caller name
                              numberHolderName: '',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Phone number must be 10 digits')),
                        );
                      }
                    },
                    child: Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}