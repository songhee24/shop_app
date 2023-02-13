class Apis {
  static const baseUrl =
      'flutter-http-299a3-default-rtdb.asia-southeast1.firebasedatabase.app';

  static const productsApi = '/products.json';
  static const addOrdersApi = '/orders.json';

  static getFiledById(String id) {
    return '/products/$id.json';
  }
}
