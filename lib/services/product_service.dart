import 'package:dio/dio.dart';
import 'package:product_list_app/model/product_model.dart';
import 'package:product_list_app/utils/erros/exception_handler.dart';
import '../utils/erros/main_exception.dart';

class ProductService {
  final Dio _dio = Dio();

  /// Fetches a list of products from the API.
  ///
  /// Returns a [Future] containing a list of [Product] objects.
  /// Throws [MainException] if an unexpected error occurs while processing.
  /// Throws a [DioException] if a network error occurs.
  Future<List<Product>> fetchProducts() async {
    try {
      // Use the correct endpoint to fetch products
      final response = await _dio.get('https://dummyjson.com/products');
      // Checking if the response status code is 200 (successful)
      if (response.statusCode == 200) {
        // Parsing the response data
        final List<dynamic> productListData = response.data['products'];

        // Mapping the product data to a list of Product objects
        List<Product> products = productListData.map((productData) {
          return Product.fromJson(productData); // Creating Product instance from JSON
        }).toList();
        return products; // Returning the list of products
      } else {
        // Handle non-200 response codes with a custom error handler
        throw ExceptionHandlers.handleBadResponse(response);
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions using the custom error handler
      throw ExceptionHandlers.handleDioExceptions(e);
    } catch (e) {
      // Catching any unexpected exceptions and throw a MainException
      throw MainException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
