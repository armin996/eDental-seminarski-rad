import 'package:flutter/material.dart';

class AboutTile extends StatelessWidget {
  const AboutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'About us',
        ),
      ),
      body: ListView(
        children: [
          // Company Overview Section
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: new AssetImage('images/overview.png'),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Company overview',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'eDental is a modern and innovative dental clinic that is committed to providing the highest quality dental care to our patients. Our team of experienced and skilled dentists, hygienists, and support staff are dedicated to creating a comfortable and welcoming environment for all of our patients.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[850],
                  ),
                ),
              ],
            ),
          ),

          // Our Mission Section
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: new AssetImage('images/ourmission.png'),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Our Mission',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Our mission is to help our patients achieve optimal oral health through personalized and comprehensive dental care. We strive to make every patient feel comfortable and well-cared for, and to build long-term relationships based on trust, respect, and quality care.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[850],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: new AssetImage('images/mission.png'),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Meet our team',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Our team of dentists, hygienists, and support staff is made up of highly skilled and compassionate professionals who are dedicated to providing exceptional care to our patients. We are committed to staying up-to-date with the latest advances in dental technology and techniques, and to providing a comfortable and welcoming environment for everyone who visits our clinic.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[850],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
