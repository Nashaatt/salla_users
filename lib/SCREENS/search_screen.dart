// ignore_for_file: unnecessary_const

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/MODELS/product_model.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/WIDGETS/app_name.dart';
import 'package:smart_shop/WIDGETS/product_widget.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

import '../CONSTANTS/app_colors.dart';


class SearchScreen extends StatefulWidget {
  static const routName = "/SearchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<ProductModel> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductModel> productList = passedCategory == null
        ? productsProvider.products
        : productsProvider.findByCategory(categoryName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // touch any place on scaffold and you will disapear the keyboard //
      },
      child: Scaffold(
        body: productList.isEmpty
            ? const Center(
                child: AppNameTextWidget(
                    text: "Unfortunately ,Not Found Products",
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              )
            : StreamBuilder<List<ProductModel>>(
                stream: productsProvider.fetchproductStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      color: AppColors.goldenColor,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SelectableText(
                        snapshot.error.toString(),
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: SelectableText(
                        "No Products Found has Added",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),

                        const AppNameTextWidget(
                          text: "SALLA",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: searchController,
                          style: const TextStyle(
                            decorationThickness: 0,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Search",
                            contentPadding: const EdgeInsets.all(10),
                            filled: true,
                            fillColor: AppColors.goldenColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // onChanged: (value) {
                          //   setState(() {
                          //     productListSearch = productsProvider.searchQuery(
                          //       searchText: searchController.text,
                          //     );
                          //   });
                          // },
                          onSubmitted: (value) {
                            setState(() {
                              productListSearch = productsProvider.searchQuery(
                                searchText: searchController.text,
                              );
                            });
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        ////////

                        if (searchController.text.isNotEmpty &&
                            productListSearch.isEmpty) ...[
                          const Center(
                            child: TitlesTextWidget(
                              label: "Not Products Found.....",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                        Expanded(
                          child: DynamicHeightGridView(
                            physics: const BouncingScrollPhysics(),
                            itemCount: searchController.text.isNotEmpty
                                ? productListSearch.length
                                : productList.length,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            builder: (context, index) {
                              return ProductWidget(
                                productId: searchController.text.isNotEmpty
                                    ? productListSearch[index]
                                        .productID //////////// Start list in search
                                    : productList[index].productID,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}

// productList[index].productID
///productListSearch[index].productID