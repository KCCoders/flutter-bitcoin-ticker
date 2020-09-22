const kCoinIoApiKey = 'B3933098-0BC8-4299-A5EE-FCEC6CCA301F';
const kCoinIoBaseUrl = 'https://rest.coinapi.io/v1/exchangerate';

void log(Object o) {
  assert(() {
    print(o);
    return true;
  }());
}
