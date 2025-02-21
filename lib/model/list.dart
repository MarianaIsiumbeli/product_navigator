

// class MyList {
//   final String id;
//   final String listTitle;
//   final String modelName;
//   final String seller;
//   final double price;
//   final int timestamp;
//   final String userId;
//   //final List<String> products;

//   MyList({
//     required this.id,
//     required this.listTitle,
//     required this.modelName,
//     required this.seller,
//     required this.price,
//     required this.timestamp,
//     required this.userId,
//     //required this.products, required String title,
//   });

//   factory MyList.fromMap(Map<String, dynamic> map) {
//     return MyList(
//       id: map['id'] as String,
//       listTitle: map['title'] as String,
//       modelName: map['modelName'] as String,
//       seller: map['seller'] as String,
//       price: (map['price'] as num).toDouble(),
//       timestamp: map['timestamp'] as int,
//       userId: map['userId'] as String,
//       //products: (jsonDecode(map['products']) as List<dynamic>).map((item) => item as String).toList(), title: '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': listTitle,
//       'modelName': modelName,
//       'seller': seller,
//       'price': price,
//       'timestamp': timestamp,
//       'userId': userId,
//       //'products': jsonEncode(products), // Convert list to JSON
//     };
//   }
// }