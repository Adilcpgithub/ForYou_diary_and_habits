import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Welcome to  For You App !\n\n'
              'By using our app, you agree to abide by the following terms and conditions:\n\n'
              '1. Privacy: We respect your privacy and are committed to protecting your personal information. Please review our Privacy Policy to understand how we collect, use, and disclose your data.\n\n'
              '2. Account: You may need to create an account to use certain features of the app. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.\n\n'
              '3. Content: Any content you create, including diary entries and habit logs, is your responsibility. We reserve the right to remove any content that violates our community guidelines or is deemed inappropriate.\n\n'
              '4. Data Usage: By using our app, you consent to the collection and use of your data as outlined in our Privacy Policy. We may use your data to improve our services and personalize your experience.\n\n'
              '5. Prohibited Activities: You agree not to engage in any unlawful or prohibited activities while using our app. This includes but is not limited to spamming, hacking, or distributing malware.\n\n'
              '6. Changes to Terms: We reserve the right to update or modify these terms and conditions at any time. Any changes will be effective immediately upon posting on the app. Your continued use of the app after the changes constitutes acceptance of the revised terms.\n\n'
              '7. Contact Us: If you have any questions or concerns about these terms and conditions, please contact us at [Your Contact Information].\n\n'
              'By using our app, you acknowledge that you have read, understood, and agreed to these terms and conditions.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
