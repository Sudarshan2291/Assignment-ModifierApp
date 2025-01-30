import "dart:convert";
import "dart:developer";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> categories = [];
  List<dynamic> products = [];
  int categoryId = 59;
  int _currentIndexCategories = 0;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    Uri apiUrl = Uri.parse(
        "http://213.210.36.38:8001/pos/allCategory/?vendorId=1&language=English");

    try {
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            categories = data["categories"] ?? [];
          });
        }
      } else {
        log("Failed to load categories: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching categories: $e");
    }
  }

  Future<void> getProducts({required int id}) async {
    Uri apiUrl = Uri.parse(
        "http://213.210.36.38:8001/pos/productByCategory/$id/?vendorId=1&language=English");
    try {
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            products = data["products"][categoryId.toString()] ?? [];
          });
        }
      } else {
        debugPrint("Failed to load categories: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Commerce App"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: categories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected = _currentIndexCategories == index;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndexCategories = index;
                              categoryId = (categories[index]["categoryId"]);
                              getProducts(id: categoryId);
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  categories[index]['image'] ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                maxLines: 2,
                                categories[index]['name'] ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      isSelected ? Colors.brown : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  decoration: isSelected
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  decorationColor: Colors.brown,
                                  decorationThickness: 2.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    child: getCard(productsById: products[index])
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget getCard({required Map<String,dynamic> productsById}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
        ),
      ),
      Center(
        child: Column(children: [Image.network(productsById['imagePath']),Text("")],
        ),
      )
    ],
  );
}
