import 'package:flutter/material.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecoveryScreen extends StatefulWidget {
  @override
  _RecoveryScreenState createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  List<dynamic> episodes = [];
  List<String> characterImages = []; // Lista para almacenar las imágenes de los personajes
  int currentIndex = 0;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    try {
      final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/episode'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          episodes = data['results'] ?? [];
          isLoading = false;
          isError = false;
        });
        // Obtener imágenes de los personajes relacionados con los episodios
        await fetchCharacterImages();
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      print('Error: $e');
    }
  }

  Future<void> fetchCharacterImages() async {
    List<String> images = [];
    for (var characterUrl in episodes[currentIndex]['characters']) {
      try {
        final response = await http.get(Uri.parse(characterUrl));
        if (response.statusCode == 200) {
          final characterData = jsonDecode(response.body);
          images.add(characterData['image'] ?? '');
        } else {
          images.add('');
        }
      } catch (e) {
        images.add('');
      }
    }
    setState(() {
      characterImages = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),  // Fondo blanco
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 42, 97),  // Color de la appBar
        title: const Text(
          'Episodios de Rick and Morty', 
          style: TextStyle(
            fontSize: 28, 
            fontWeight: FontWeight.bold, 
            color: Colors.white // Color blanco para el texto
          ),
        ),  
        leading: IconButton(  // Agregué el ícono de regresar
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Regresa a la pantalla anterior
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isError
              ? Center(child: Text('No se pudieron cargar los episodios. Intenta nuevamente.', style: TextStyle(color: const Color.fromARGB(255, 179, 43, 34), fontSize: 22)))  // Aumenté el tamaño de la fuente
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: characterImages.isNotEmpty
                            ? Image.network(
                                characterImages[currentIndex],
                                height: 250,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.image, size: 250, color: const Color.fromARGB(255, 0, 0, 0));
                                },
                              )
                            : Icon(Icons.image, size: 250, color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Episodio: ${episodes[currentIndex]['name'] ?? 'Desconocido'}',  // Aumenté el tamaño de la fuente
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),  // Aumenté el tamaño de la fuente
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Fecha de emisión: ${episodes[currentIndex]['air_date'] ?? 'Desconocida'}',  // Aumenté el tamaño de la fuente
                        style: TextStyle(fontSize: 22, color: Colors.black),  // Aumenté el tamaño de la fuente
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: currentIndex > 0
                                ? () {
                                    setState(() {
                                      currentIndex--;
                                    });
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 32, 48, 102), // Fondo del botón
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Atrás',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),  // Aumenté el tamaño de la fuente
                            ),
                          ),
                          ElevatedButton(
                            onPressed: currentIndex < episodes.length - 1
                                ? () {
                                    setState(() {
                                      currentIndex++;
                                    });
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 32, 48, 102), // Fondo del botón
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Siguiente',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),  // Aumenté el tamaño de la fuente
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}
