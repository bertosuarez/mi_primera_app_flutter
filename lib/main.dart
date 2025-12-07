import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi primera app Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorText;

  void _login() {
    final user = _userController.text.trim();
    final pass = _passwordController.text.trim();

    // Login súper simple, solo comprueba que no estén vacíos
    if (user.isEmpty || pass.isEmpty) {
      setState(() {
        _errorText = 'Por favor, rellena usuario y contraseña.';
      });
      return;
    }

    setState(() {
      _errorText = null;
    });

    // Navega a la pantalla de las fotos
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const GalleryScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 72,
              ),
              const SizedBox(height: 16),
              const Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              if (_errorText != null)
                Text(
                  _errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // Lista de URLs de ejemplo (fotos random de picsum)
  List<String> _getImageUrls() {
    return List.generate(
      20,
      (index) => 'https://picsum.photos/seed/foto$index/300/300',
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = _getImageUrls();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,        // 3 columnas tipo Instagram
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
