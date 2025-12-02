import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CatApiScreen extends StatefulWidget {
  @override
  _CatApiScreenState createState() => _CatApiScreenState();
}

class _CatApiScreenState extends State<CatApiScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _catBreeds = [];
  List<Map<String, dynamic>> _allBreeds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllBreeds();
  }

  Future<void> loadAllBreeds() async {
    setState(() => _isLoading = true);

    final url = Uri.parse('https://api.thecatapi.com/v1/breeds');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);

        List<Map<String, dynamic>> tempBreeds = [];

        for (var breed in data) {
          String? imageUrl;

          if (breed['reference_image_id'] != null) {
            imageUrl = "https://cdn2.thecatapi.com/images/${breed['reference_image_id']}.jpg";
          } else if (breed['image'] != null && breed['image']['url'] != null) {
            imageUrl = breed['image']['url'];
          }

          tempBreeds.add({
            'name': breed['name'] ?? 'Sin nombre',
            'origin': breed['origin'] ?? 'Desconocido',
            'temperament': breed['temperament'] ?? 'No especificado',
            'description': breed['description'] ?? 'Sin descripción',
            'life_span': breed['life_span'] ?? 'No especificado',
            'image': imageUrl,

            // NUEVO: TODAS LAS ESTADÍSTICAS
            'intelligence': breed['intelligence'] ?? 0,
            'adaptability': breed['adaptability'] ?? 0,
            'affection': breed['affection_level'] ?? 0,
            'child_friendly': breed['child_friendly'] ?? 0,
            'dog_friendly': breed['dog_friendly'] ?? 0,
            'energy': breed['energy_level'] ?? 0,
            'grooming': breed['grooming'] ?? 0,
            'health': breed['health_issues'] ?? 0,
            'social_needs': breed['social_needs'] ?? 0,
            'stranger_friendly': breed['stranger_friendly'] ?? 0,
          });
        }

        setState(() {
          _allBreeds = tempBreeds;
          _catBreeds = List.from(_allBreeds);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar razas: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de red: $e')),
      );
    }
  }

  void searchCats(String query) {
    query = query.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _catBreeds = List.from(_allBreeds);
      } else {
        _catBreeds = _allBreeds.where((breed) {
          return breed['name'].toLowerCase().contains(query) ||
              breed['origin'].toLowerCase().contains(query) ||
              breed['temperament'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Razas de Gatos'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: searchCats,
              decoration: InputDecoration(
                hintText: "Buscar una raza...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          if (_isLoading)
            const Center(child: CircularProgressIndicator()),

          if (!_isLoading)
            Expanded(
              child: _catBreeds.isEmpty
                  ? Center(child: Text("No se encontraron razas"))
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.78,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: _catBreeds.length,
                      itemBuilder: (context, index) {
                        final breed = _catBreeds[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CatBreedDetailScreen(breed: breed),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: breed['image'] != null
                                      ? Image.network(
                                          breed['image'],
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            height: 120,
                                            color: Colors.grey,
                                            child: Icon(Icons.pets, size: 50),
                                          ),
                                        )
                                      : Container(
                                          height: 120,
                                          color: Colors.grey,
                                          child: Icon(Icons.pets, size: 50),
                                        ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  breed['name'],
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  breed['origin'],
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }
}

class CatBreedDetailScreen extends StatelessWidget {
  final Map<String, dynamic> breed;

  const CatBreedDetailScreen({required this.breed});

  Widget _statBar(String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title: $value/5",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value / 5,
              minHeight: 12,
              backgroundColor: Colors.grey.shade300,
              color: Colors.orange,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 15)),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final image = breed['image'];

    return Scaffold(
      appBar: AppBar(
        title: Text(breed['name']),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  image,
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            SizedBox(height: 24),

            _infoTile("Origen", breed["origin"]),
            _infoTile("Esperanza de vida", breed["life_span"]),
            _infoTile("Temperamento", breed["temperament"]),
            _infoTile("Descripción", breed["description"]),

            // TODAS LAS BARRAS
            _statBar("Inteligencia", breed["intelligence"]),
            _statBar("Adaptabilidad", breed["adaptability"]),
            _statBar("Afecto", breed["affection"]),
            _statBar("Niños amigable", breed["child_friendly"]),
            _statBar("Perros amigable", breed["dog_friendly"]),
            _statBar("Energía", breed["energy"]),
            _statBar("Aseo", breed["grooming"]),
            _statBar("Problemas de salud", breed["health"]),
            _statBar("Necesidades sociales", breed["social_needs"]),
            _statBar("Amigable con extraños", breed["stranger_friendly"]),
          ],
        ),
      ),
    );
  }
}
