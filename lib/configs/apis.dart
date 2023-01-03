class Apis {
  static const baseUrl =
      'flutter-http-299a3-default-rtdb.asia-southeast1.firebasedatabase.app';

  static const addProductApi = '/products.json';
  static const getProductsApi = '/products.json';

  static getFiledById(String id) {
    return '/products/$id.';
  }
}
