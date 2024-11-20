import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Asegúrate de importar esto

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Fondo blanco
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 42, 97),  // Color de la appBar
        title: const Text(
          'Recuperación Corte 1',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animación para la imagen del logo
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: Center(
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: 300,  // Logo más grande
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Animación para los textos con fuente más grande
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: const Text(
                'Consumo de Api Fake',
                style: TextStyle(
                  fontSize: 32,  // Fuente más grande
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Carrera: Desarrollo de Software',
              style: TextStyle(fontSize: 24),  // Fuente más grande
            ),
            const Text(
              'Materia: Programación de Móviles 2',
              style: TextStyle(fontSize: 24),  // Fuente más grande
            ),
            const Text(
              'Grupo: 9B',
              style: TextStyle(fontSize: 24),  // Fuente más grande
            ),
            const Text(
              'Nombre: Andrés Guizar',
              style: TextStyle(fontSize: 24),  // Fuente más grande
            ),
            const Text(
              'Matrícula: 213360',
              style: TextStyle(fontSize: 24),  // Fuente más grande
            ),
            const SizedBox(height: 20),
            // Reemplazar enlace con imagen del repositorio
            GestureDetector(
              onTap: () async {
                const url = 'https://github.com/GzarGmez/Consumo-de-API-Fake.git';
                final Uri uri = Uri.parse(url); // Asegurarse de que el URL esté bien formado
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri); // Abre el repositorio en el navegador
                } else {
                  throw 'No se pudo abrir el enlace';
                }
              },
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/Github.png', // Imagen del repositorio
                      width: 150, // Tamaño de la imagen
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Texto debajo de la imagen
                  const Text(
                    'Github',
                    style: TextStyle(
                      fontSize: 20, // Tamaño de la fuente
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Botón más grande y estilizado
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/recovery');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 32, 48, 102), // Fondo del botón
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), // Botón más grande
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Bordes redondeados
                    ),
                    elevation: 5, // Sombra
                  ),
                  child: const Text(
                    'Rick And Morty',
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0), // Cambia el color del texto a negro
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
