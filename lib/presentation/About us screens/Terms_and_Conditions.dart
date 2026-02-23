import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xffD6D6F5),
        foregroundColor: Colors.black,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Effective Date: [Insert Date]",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            SizedBox(height: 20),
            _SectionText(
              "Welcome to SignLingo. By downloading or using the app, you agree to these Terms. If you do not agree, please do not use the app.",
            ),

            // SizedBox(height: 20),
            _SectionTitle("1. About the App"),
            _SectionText(
              "SignLingo is an educational application designed to help users learn and practice sign language. "
              "It is provided for informational purposes only and does not replace professional, medical, or certified interpretation services.",
            ),

            _SectionTitle("2. Eligibility"),
            _SectionText(
              "You must be at least 13 years old to use the app. Users under 13 must have parental or guardian consent. "
              "By using the app, you confirm that your information is accurate.",
            ),

            _SectionTitle("3. User Responsibilities"),
            _SectionText(
              "If you create an account, you are responsible for maintaining its security and all activities under it. "
              "You agree to use the app lawfully and respectfully in compliance with Egyptian laws. You may not:Hack, copy, or modify the appUpload harmful or inappropriate contentMisuse the app or harm other users",
            ),

            _SectionTitle("4. Camera & Media Access"),
            _SectionText(
              "The app may request camera access for sign language practice and recognition features. "
              "We do not record, store, or share videos or images without your explicit consent. You can manage permissions in your device settings at any time.",
            ),

            _SectionTitle("5. Content Accuracy"),
            _SectionText(
              "Sign language may vary by region. While we aim for accuracy, we do not guarantee 100% accuracy. "
              "SignLingo is a learning aid and not a certified translation service.",
            ),

            _SectionTitle("6. Intellectual Property"),
            _SectionText(
              "All app content is owned by SignLingo and protected under Egyptian intellectual property laws. "
              "Unauthorized copying or distribution is prohibited.",
            ),

            _SectionTitle("7. Privacy & Data Protection"),
            _SectionText(
              "We process personal data in accordance with Egyptian Personal Data Protection Law No. 151 of 2020. "
              "We apply reasonable security measures but cannot guarantee absolute security.",
            ),

            _SectionTitle("8. Limitation of Liability"),
            _SectionText(
              "The app is provided 'as is.' To the extent permitted by Egyptian law, SignLingo is not liable for damages resulting from use of the app. Use of the app is at your own risk",
            ),

            _SectionTitle("9. Termination"),
            _SectionText(
              "We may suspend or terminate access if these Terms are violated.",
            ),

            _SectionTitle("10. Changes to Terms"),
            _SectionText(
              "We may update these Terms at any time. Continued use of the app means you accept the updated Terms.",
            ),

            _SectionTitle("11. Governing Law"),
            _SectionText(
              "These Terms are governed by the laws of the Arab Republic of Egypt. "
              "Any disputes shall be subject to the courts of Cairo, Egypt.",
            ),

            SizedBox(height: 24),

            Text(
              "Accessibility Commitment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "SignLingo is built to support the deaf and mute community through inclusive and accessible design.",
              style: TextStyle(height: 1.6),
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
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;
  const _SectionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(height: 1.6, fontSize: 14, color: Colors.black87),
    );
  }
}
