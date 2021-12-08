import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RememberBox extends StatefulWidget {
  const RememberBox({Key? key}) : super(key: key);

  @override
  _RememberBoxState createState() => _RememberBoxState();
}

class _RememberBoxState extends State<RememberBox> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          },
          checkColor: Colors.black,
          fillColor: MaterialStateProperty.all(Colors.white),
        ),
        const Text(
          'Remember me',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.black,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 60),
              child: Column(
                children: [
                  const Text(
                    'Open Bank',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 30,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'CPF',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const InputField(
                    hintText: 'Enter your CPF',
                    obscureText: false,
                    prefixedIcon: Icon(
                      Icons.perm_identity_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const InputField(
                    hintText: 'Enter your password',
                    obscureText: true,
                    prefixedIcon: Icon(Icons.lock, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  const ForgotPasswordButton(),
                  const RememberBox(),
                  const SizedBox(height: 15),
                  const LoginButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    TextInputType inputType = TextInputType.number,
  })  : _obscureText = obscureText,
        _prefixedIcon = prefixedIcon,
        _hintText = hintText,
        _inputType = inputType,
        super(key: key);

  final bool _obscureText;
  final Widget? _prefixedIcon;
  final String? _hintText;
  final TextInputType _inputType;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      child: TextField(
        keyboardType: _inputType,
        cursorColor: Colors.white,
        cursorWidth: 2,
        obscureText: _obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: _prefixedIcon,
          hintText: _hintText,
          hintStyle: const TextStyle(
            color: Colors.white54,
            // fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
        ),
      ),
    );
  }
}
