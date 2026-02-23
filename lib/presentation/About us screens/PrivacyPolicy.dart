import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          "Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text(
              "Effective Date: [Insert Date]",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            SizedBox(height: 16),

            Text(
              "SignLingo respects your privacy and is committed to protecting your personal data in accordance with Egyptian Personal Data Protection Law No. 151 of 2020.",
              style: TextStyle(height: 1.6),
            ),

            SizedBox(height: 8),

            Text(
              "By using the SignLingo app, you agree to this Privacy Policy.",
              style: TextStyle(height: 1.6),
            ),

            // SizedBox(height: 16),

            _SectionTitle("1. Information We Collect"),
            _SectionText(
                "We may collect basic account information (name, email), app usage data (features used, interactions), and camera access for sign language practice. "
                "We do not store recordings unless you give permission and do not collect unnecessary personal data."),

            _SectionTitle("2. How We Use Your Information"),
            _SectionText(
                "We use your data to provide and improve the app, personalize your learning experience, ensure app security and functionality, "
                "and respond to support requests. We do not sell your personal data."),

            _SectionTitle("3. Camera & Media Access"),
            _SectionText(
                "Camera access is used only for sign language practice and recognition features. "
                "We do not record, store, or share videos or images without your explicit consent. "
                "You can manage permissions in your device settings at any time."),

            _SectionTitle("4. Data Protection"),
            _SectionText(
                "We apply reasonable technical and organizational measures to protect your data. "
                "However, no system can guarantee absolute security."),

            _SectionTitle("5. Data Sharing"),
            _SectionText(
                "We do not share your personal data with third parties except when required by law, "
                "to comply with legal obligations in Egypt, or to protect the rights and safety of users."),

            _SectionTitle("6. Your Rights (Under Egyptian Law)"),
            _SectionText(
                "Under Law No. 151 of 2020, you have the right to access your personal data, request correction or deletion, "
                "and withdraw consent where applicable."),

            SizedBox(height: 12),

            Text(
              "To exercise these rights, contact us at:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 6),

            SelectableText(
              "support@signlingo.com",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 8),

            _SectionTitle("7. Changes to This Policy"),
            _SectionText(
                "We may update this Privacy Policy from time to time. "
                "Continued use of the app means you accept the updated policy."),

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
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
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
      style: const TextStyle(
        height: 1.6,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }
}
