import 'package:flutter/material.dart';

class Product {
  Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
      : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.grey[400] : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
        color: Colors.white, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopping List'),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0 ,30),
            height: 600,
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(30, (index) =>  Text('$index')),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text('A'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset('images/re.png'),
                  )
                ],
              ),
            ),
          ),
        )
        // body: Container(
        //   padding: EdgeInsets.all(15),
        //   child: ListView(
        //     padding: EdgeInsets.symmetric(vertical: 8.0),
        //     children: [
        //       ...widget.products.map((Product product) {
        //         return ShoppingListItem(
        //           product: product,
        //           inCart: _shoppingCart.contains(product),
        //           onCartChanged: _handleCartChanged,
        //         );
        //       }).toList(),
        //       ListTile(
        //         leading: CircleAvatar(
        //           backgroundImage: NetworkImage('images/re.png'),
        //         ),
        //         title: Text('RE'),
        //       )
        //     ],
        //   ),
        // )
      );
  }
}
