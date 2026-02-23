import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),),
        elevation: 0,
        backgroundColor: Color(0xffD6D6F5),
        foregroundColor: Colors.black,
        title: const Text(
          "Help Center",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text(
              "Welcome to the SignLingo Help Center. Here you can find answers, guidance, and support to help you use the app smoothly and confidently.",
              style: TextStyle(height: 1.6),
            ),

            SizedBox(height: 10),

            Text(
              "If you cannot find what you are looking for, please contact us at:",
              style: TextStyle(height: 1.6),
            ),

            SizedBox(height: 6),

            SelectableText(
              "support@signlingo.com",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),

            // SizedBox(height: 30),

            _SectionTitle("1. Getting Started"),
            _Question("What is SignLingo?"),
            _Answer(
                "SignLingo is a sign language learning and communication application designed to help users learn, practice, and improve their skills in an accessible and interactive way."),

            _Question("How do I create an account?"),
            _Answer(
                "Open the app → Tap 'Create Account' → Enter your name, email, and password → Verify your email if required."),

            _Question("Can I use the app without an account?"),
            _Answer(
                "Some features may be available without signing in, but creating an account allows you to save progress and access personalized features."),

            _SectionTitle("2. Dictionary"),
            _Question("How does the Dictionary work?"),
            _Answer(
                "The Dictionary allows you to browse sign language words alphabetically or search directly for a word."),

            _Question("How do I search for a word?"),
            _Answer(
                "Use the search bar at the top of the Dictionary page and type the word you want to find."),

            _Question("Can I save words?"),
            _Answer(
                "Yes. You can bookmark words to access them later from your Saved section."),

            _SectionTitle("3. Sign Practice & Camera"),
            _Question("Why does the app need camera access?"),
            _Answer(
                "Camera access is used only for sign language practice and recognition features."),

            _Question("Are my recordings stored?"),
            _Answer(
                "No. SignLingo does not record or store videos or images unless you explicitly give permission."),

            _Question("How can I disable camera access?"),
            _Answer(
                "You can manage or revoke camera permissions at any time through your device settings."),

            _SectionTitle("4. Account & Settings"),
            _Question("How do I reset my password?"),
            _Answer(
                "Go to the Login page → Tap 'Forgot Password' → Enter your registered email → Follow the instructions sent to your email."),

            _Question("How do I delete my account?"),
            _Answer(
                "To request account deletion, contact support@signlingo.com. Your data will be handled in accordance with our Privacy Policy."),

            _Question("How do I update my information?"),
            _Answer("Go to Settings → Account → Edit Profile."),

            _SectionTitle("5. Privacy & Security"),
            _Question("How is my data protected?"),
            _Answer(
                "We apply reasonable technical and organizational measures to protect your personal data."),

            _Question("Does SignLingo sell my data?"),
            _Answer(
                "No. We do not sell or share your personal data with third parties except when required by law. For full details, please review our Privacy Policy in the Legal section."),

            _SectionTitle("6. Technical Issues"),
            _Question("The app is not working properly. What should I do?"),
            _Answer(
                "Make sure the app is updated → Restart the app → Restart your device. If the issue continues, contact support with your device type, OS version, and a description of the problem."),

            _Question("The camera feature is not responding."),
            _Answer(
                "Check if camera permissions are enabled and ensure no other app is using the camera."),

            _SectionTitle("7. Contact Support"),

            SizedBox(height: 10),

            Text(
              "Email: support@signlingo.com",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 6),

            Text(
              "Response time: Within 24–48 business hours",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "We are happy to assist you.",
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Question extends StatelessWidget {
  final String text;
  const _Question(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _Answer extends StatelessWidget {
  final String text;
  const _Answer(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: const TextStyle(
          height: 1.6,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }
}
