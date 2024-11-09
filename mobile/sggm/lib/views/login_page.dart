import 'package:flutter/material.dart';
import 'package:sggm/views/widgets/input_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(children: [
              Text('SGGM', style: TextStyle(color: Colors.white, fontSize: 32, fontFamily: 'Inknut_Antiqua')),
              SizedBox(height: 10),
              Text('IPB Ponta Porã',
                  style: TextStyle(
                      color: Colors.white, fontSize: 14, fontFamily: 'Inknut_Antiqua', fontWeight: FontWeight.normal)),
            ]),
            Image.asset('assets/wave.jpg'),
            Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildTextField(labelText: 'Usuário'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildTextField(
                  labelText: 'Senha',
                  obscureText: true, // Oculta o texto da senha
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
