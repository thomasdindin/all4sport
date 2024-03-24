import 'package:all4sport/Services/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:all4sport/Services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String message = '';
  bool stayLoggedIn = false; // Ajout de la variable pour rester connecté

  bool isLoading = false;

  Future<bool> loadSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    bool? stayLoggedIn = prefs.getBool('stayLoggedIn');

    if (email != null && password != null && stayLoggedIn != null) {
      this.email = email;
      this.password = password;
      this.stayLoggedIn = stayLoggedIn;
    }

    return true;
  }

  Future<void> handleLogin() async {
    var userProvider = UserProvider.getInstance();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final apiService = ApiService();
        bool success = await apiService.postUser(email, password);

        if (success) {
          if (stayLoggedIn) {
            // Sauvegarder les informations de connexion dans les SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', email);
            prefs.setString('password', password);
            prefs.setBool('stayLoggedIn', stayLoggedIn);

            userProvider.setEmail(email);
            userProvider.setIsConnected(true);
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          setState(() {
            message = 'Connexion échouée. Vérifiez vos identifiants.';
          });
        }
      } catch (e) {
        print('Error during login: $e');
        setState(() {
          message = 'Erreur lors de la connexion. Réessayez plus tard.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadSP(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Text('Connectez vous.',
                              style: Theme.of(context).textTheme.headline4!),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Text(message),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Saisissez votre email.';
                            }
                            return null;
                          },
                          initialValue: email,
                          onSaved: (value) {
                            email = value!;
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'Mot de passe'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Saisissez votre mot de passe.';
                            }
                            return null;
                          },
                          initialValue: password,
                          onSaved: (value) {
                            password = value!;
                          },
                        ),
                        CheckboxListTile(
                          title: Text("Rester connecté"),
                          value: stayLoggedIn,
                          onChanged: (bool? newValue) {
                            setState(() {
                              stayLoggedIn = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, // Position de la case à cocher
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isLoading
                            ? const CircularProgressIndicator()
                            : Column(children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      handleLogin().then((_) =>
                                          setState(() => isLoading = false));
                                    },
                                    child: const Text('Connexion'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Continuer sans s\'authentifier',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14),
                                  ),
                                ),
                              ]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
                child: Text('Erreur lors du chargement des données.'));
          }
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
