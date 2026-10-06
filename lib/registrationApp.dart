import 'package:flutter/material.dart';


class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Регистрация",
      home: const RegistrationPage(),
    );
  }
  
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage ({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
  
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
    void dispose() {
      nameController.dispose();
      surnameController.dispose();
      phoneController.dispose();
      emailController.dispose();
      loginController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      super.dispose();
    }

    void showConfirmDialog() {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text("Подтверждение"),
            content: Text(
              "Имя: ${nameController.text}\n"
              "Фамилия: ${surnameController.text}\n"
              "Телефон: ${phoneController.text}\n"
              "Email: ${emailController.text}\n"
              "Логин: ${loginController.text}",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text("Отмена"),
                ),
                ElevatedButton(
  onPressed: () {
    Navigator.pop(dialogContext);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultPage(
          name: nameController.text,
          surname: surnameController.text,
          phone: phoneController.text,
          email: emailController.text,
          login: loginController.text,
        ),
      ),
    );
  },
  child: const Text("ОК"),
                  ),
            ],
          );
        } 
        );
    }

    @override 
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("Форма регистрации"),),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Имя",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введите имя";
                    }
                    if (!RegExp(r'^[a-zA-Zа-яА-Я]+$').hasMatch(value)) {
                      return "Только буквы";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: surnameController,
                  decoration: const InputDecoration(
                    labelText: "Фамилия",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введите фамилию";

                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Телефон",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введите телефон";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Только цифры";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введите email";
                    }
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                      return "Неверный формат email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: loginController,
                  decoration: const InputDecoration(
                    labelText: "Логин",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введите логин";

                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Пароль",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введите пароль";

                    }

                    if (value.length < 6){
                      return "Минимум 6 символов";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Повторите пароль",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Повторите пароль";

                    }
                    if (value != passwordController.text){
                      return "Пароли не совпадают";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showConfirmDialog();
                      }
                    }, 
                    child: const Text("Зарегистрироваться"),
                    ),
                )
            
              ],
            ) 
            ),
        ),
      );
    }
  
}

class ResultPage extends StatelessWidget {
  final String name;
  final String surname;
  final String phone;
  final String email;
  final String login;

  const ResultPage({
    super.key,
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
    required this.login,
  });

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(title: const Text("Данные пользователя")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Имя: $name"),
            Text("Фамилия: $surname"),
            Text("Телефон: $phone"),
            Text("Email: $email"),
            Text("Логин: $login"),
        ],
      ),
      ),
   );
  }

  
}

