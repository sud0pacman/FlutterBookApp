import 'package:book_store/data/local/my_pref.dart';
import 'package:book_store/ui/components/components.dart';
import 'package:book_store/ui/theme/constant_keys.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final SharedPreferencesHelper _pref = SharedPreferencesHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF26B6C),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Color(0xFFFFFFFF)),
          onPressed: () {
            Navigator.pop(context);
            // Handle more button press
          },
        ),
        title: const Center(
            child: BoldText(text: "Profile", color: Colors.white,)
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.edit, color: Color(0xFFFFFFFF)),
            onPressed: () {
              // Handle more button press
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color:  Color(0xFFF26B6C),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.black,
                      backgroundImage:  NetworkImage('https://img.freepik.com/premium-photo/young-handsome-man-with-beard-isolated-keeping-arms-crossed-frontal-position_1368-132662.jpg'),
                    ),

                    BoldText(
                      text: "Marea Akter dipi",
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: 4, child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                            fontFamily: 'PaynetB',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF26B6C)),
                      ),
                      Spacer(),
                      Text(
                        'muhammad',
                        style: TextStyle(
                            fontFamily: 'PaynetB',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 2,color: Color(0xffdcd9dc),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontFamily: 'PaynetB',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF26B6C)),
                      ),
                      const Spacer(),
                      Text(
                        '${_pref.getString(ConstantKeys.mail)}',
                        style: const TextStyle(
                            fontFamily: 'PaynetB',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 2,color: Color(0xffdcd9dc),),
                Row(
                  children: [
                    const Text(
                      'Change Password',
                      style: TextStyle(
                          fontFamily: 'PaynetB',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF26B6C)),
                    ),
                    const Spacer(),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.chevron_right_rounded))
                  ],
                ),
                const Divider(height: 2,color: Color(0xffdcd9dc),),
                Row(
                  children: [
                    const Text(
                      'Notification',
                      style: TextStyle(
                          fontFamily: 'PaynetB',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF26B6C)),
                    ),
                    const Spacer(),
                    IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification))
                  ],
                ),
                const Divider(height: 2,color: Color(0xffdcd9dc),),
                Row(
                  children: [
                    const Text(
                      'Enable dark mode',
                      style: TextStyle(
                          fontFamily: 'PaynetB',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF26B6C)),
                    ),
                    const Spacer(),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.dark_mode_outlined))
                  ],
                ),
                const Divider(height: 2,color: Color(0xffdcd9dc),),
                Row(
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                          fontFamily: 'PaynetB',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF26B6C)),
                    ),
                    const Spacer(),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.settings_outlined))
                  ],
                ),
                const Divider(height: 2,color: Color(0xffdcd9dc),),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
