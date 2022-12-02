import 'package:maid/maid.dart';

void main() async {
  // General [Maids.singleton] usage, create a singleton of [HttpClient].
  Maids.singleton(HttpClient('example.com', 'foo'));

  var result = await codeAtSomewhereElse();
  print(result);
}

Future<String> codeAtSomewhereElse() async {
  // Use type parameter to get the singleton of [HttpClient].
  return Maids.singleton<HttpClient>().serve().get('/bar');
}

// A simulated HTTP client as example
class HttpClient {
  final String host;
  final String auth;
  HttpClient(this.host, this.auth);

  Future<String> get(String path) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'http://$host$path with auth: $auth \n> Hello, World!';
  }
}
