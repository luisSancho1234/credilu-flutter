import 'package:credilu/services/login_service.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  final title = 'Login';

  LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController usernameControl = TextEditingController();
  final TextEditingController passwordControl = TextEditingController();

  String usernameText = '';
  String passwordText = '';
  bool isLoading = false; // Para indicar o carregamento

  LoginService loginService = LoginService(); // Instanciando o serviço de login

  void login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await loginService.login(
        usernameControl.text,
        passwordControl.text,
      );
      // Aqui você pode tratar a resposta do login
      if (response.isNotEmpty) {
        // Login bem-sucedido
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login realizado com sucesso!')),
        );
        // Navegar para outra página ou outra lógica
      } else {
        // Falha no login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário ou senha incorretos')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TextFormField(
                controller: usernameControl,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordControl,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true, // Para esconder a senha
              ),
              const SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator() // Exibe um indicador de carregamento enquanto a requisição é feita
                  : Row(
                    children: [
                      GestureDetector(
                        child: const Text('Cadastre-se'),
                        onTap: () {
                          debugPrint('oi');
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: login,
                        child: const Text('Entrar'),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameControl.dispose();
    passwordControl.dispose();
    super.dispose();
  }
}
