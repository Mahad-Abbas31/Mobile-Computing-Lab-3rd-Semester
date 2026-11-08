import 'package:flutter/material.dart';

void main() {
  runApp(const ProductApp());
}
/// Simple data model for a product.
class Product {
    final String name;
    final String description;
    final double price;
    final Color color;
    final String imageLabel; // text drawn on the placeholder "image"

    const Product({
      required this.name,
      required this.description,
      required this.price,
      required this.color,
      required this.imageLabel,
  });
}
/// Sample data (6 products).
const List<Product> products = [
  Product(
    name: 'iPhone',
    description:
      'iPhone is the stylish phone ever. It features a stunning display, '
      'a powerful processor and an excellent camera system for everyday
      use.',
    price: 1000,
    color: Color(0xFFD62FD9),
    imageLabel: 'iPhone',
  ),

Product(
name: 'Pixel',
description:
'Pixel is the most featureful phone ever. It offers a clean Android '
'experience, smart AI features and outstanding photo quality.',
price: 800,
color: Color(0xFF3B5BDB),
imageLabel: 'pixel 1',
),
Product(
name: 'Laptop',
description:
'Laptop is the most productive development tool. Fast SSD storage, '
'plenty of RAM and a long-lasting battery make it ideal for coding.',
price: 2000,
color: Color(0xFF2FD43F),
imageLabel: 'laptop',
),
Product(
name: 'Tablet',
description:
'Tablet is the most useful device ever for meetings. Take notes, '
'present slides and join video calls with a lightweight device.',
price: 1500,
color: Color(0xFFD4BC2F),
imageLabel: 'tablet',
),
Product(
name: 'Pendrive',
description:
'Pendrive is a compact and reliable USB storage device. Carry your '
'files anywhere with fast transfer speeds and a durable body.',
price: 100,
color: Color(0xFFC8553D),
imageLabel: 'pen drive',
),
Product(
name: 'Headphones',
description:
'Wireless noise-cancelling headphones with deep bass, clear vocals '
'and up to 30 hours of battery life.',
price: 300,
color: Color(0xFF00897B),
imageLabel: 'headphones',
),
];

class ProductApp extends StatelessWidget {
const ProductApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Product Listing',
debugShowCheckedModeBanner: false,
theme: ThemeData(
useMaterial3: false,
primarySwatch: Colors.blue,
scaffoldBackgroundColor: const Color(0xFFF2F4F7),
),
home: const ProductListScreen(),
);
}
}
/// Reusable colored placeholder that acts as the product image.
class ProductImage extends StatelessWidget {
final Product product;
final double width;
final double height;
final double fontSize;
const ProductImage({
super.key,
required this.product,
required this.width,
required this.height,
required this.fontSize,
});
@override
Widget build(BuildContext context) {
return Hero(
tag: 'product-image-${product.name}',
child: Material(
color: Colors.transparent,
child: Container(
width: width,
height: height,
alignment: Alignment.center,
color: product.color,
child: Text(
product.imageLabel,
style: TextStyle(
color: Colors.white,
fontSize: fontSize,
fontWeight: FontWeight.w300,
),
),
),
),
);
}
}
/// Screen 1: list of products.
class ProductListScreen extends StatelessWidget {
const ProductListScreen({super.key});
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'Product Listing',
style: TextStyle(fontWeight: FontWeight.bold),
),
),
body: ListView.builder(
padding: const EdgeInsets.all(8),
itemCount: products.length,
itemBuilder: (context, index) {
final product = products[index];
return Card(

elevation: 2,
margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(6),
),
clipBehavior: Clip.antiAlias,
child: InkWell(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => ProductDetailScreen(product: product),
),
);
},
child: SizedBox(
height: 120,
child: Row(
children: [
ProductImage(
product: product,
width: 140,
height: 120,
fontSize: 28,
),
Expanded(
child: Padding(
padding: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 8,
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
product.name,
style: const TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 6),
Text(
product.description,
maxLines: 2,
overflow: TextOverflow.ellipsis,
textAlign: TextAlign.center,
style: const TextStyle(fontSize: 13),

),
const SizedBox(height: 8),
Text(
'Price: ${product.price.toStringAsFixed(0)}',
style: const TextStyle(
fontSize: 14,
fontWeight: FontWeight.w500,
),
),
],
),
),
),
],
),
),
),
);
},
),
);
}
}
/// Screen 2: details of one product.
class ProductDetailScreen extends StatelessWidget {
final Product product;
const ProductDetailScreen({super.key, required this.product});
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text(product.name)),
body: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
// Larger product image
ProductImage(
product: product,
width: double.infinity,
height: 280,
fontSize: 56,
),
Padding(
padding: const EdgeInsets.all(20),
child: Column(

crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
product.name,
style: const TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Container(
padding: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 6,
),
decoration: BoxDecoration(
color: Colors.blue.shade50,
borderRadius: BorderRadius.circular(20),
),
child: Text(
'Price: ${product.price.toStringAsFixed(0)}',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.w600,
color: Colors.blue.shade800,
),
),
),
const SizedBox(height: 20),
const Text(
'Description',
style: TextStyle(fontSize: 18, fontWeight:

FontWeight.bold),
),
const SizedBox(height: 8),
Text(
product.description,
style: const TextStyle(fontSize: 16, height: 1.4),
),
const SizedBox(height: 32),
// Back button
SizedBox(
height: 48,
child: ElevatedButton.icon(
onPressed: () => Navigator.pop(context),
icon: const Icon(Icons.arrow_back),
label: const Text(
'Back to Product List',


style: TextStyle(fontSize: 16),
),
),
),
],
),
),
],
),
),
);
}
}