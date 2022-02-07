import 'package:flutter/material.dart';
import 'package:openbank/utils/constants/lib/api.dart';

class PreHomeView extends StatelessWidget {
  const PreHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Carregando...\nPor favor aguarde',
          style: TextConstants.defaultTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: screenSize.width * 0.5,
            height: screenSize.height * 0.50,
            child: const CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: Colors.white,
              strokeWidth: 10,
            ),
          ),
        ),
      ],
    );
  }
}
