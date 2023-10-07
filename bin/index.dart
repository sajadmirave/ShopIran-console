import 'dart:io';

void main() {
  var shopIran = ShopIran();
  shopIran.showMenu();
  // shopIran.login('sajad', '1234');
}

class Helper {
  // clear console to read better
  void clearConsole() {
    if (Platform.isWindows) {
      // print(Process.runSync('cls', [], runInShell: true).stdout);
      print("\x1B[2J\x1B[0;0H"); //move curoser to 0:0
      return;
    }

    print(Process.runSync('clear', [], runInShell: true).stdout);
    return;
  }

  // check empty input
  bool empty(var value) {
    if (value == null) {
      return true;
    }

    return false;
  }
}

class ShopIran {
  final Map<String, String> _product = {};
  final Map<String, String> _users = {
    'sajad': '1234',
    'mmd': '657',
    'admin': 'admin'
  };
  final Map<String, String> _role = {"admin": "1", "adder": "2"};
  final Map<String, String> _permission = {"sajad": "1"};
  String? _currentUser; // Current user logged in
  String? _currentRole = 'user'; // Current user role
  bool _isLoggedIn = false;

  // helper function
  var helper = Helper();

  /// @param username - Get username
  /// @param password - Get password
  bool login(String username, String password) {
    _users.forEach((user, pass) {
      if (username == user && password == pass) {
        _currentUser = username;
        print("You are logged in successfully.");
        _isLoggedIn = true;
      }
    });

    if (!_isLoggedIn) {
      print("Unauthorized");
    }

    return _isLoggedIn;
  }

  // Check if the user is authenticated
  bool auth() {
    return _isLoggedIn;
  }

  // app menu
  void showMenu() {
    var menu = ["1- login", '2- dashboad'];

    // show menu
    for (var item in menu) {
      print(item);
    }

    // select option
    var selectOption = stdin.readLineSync();

    if (selectOption != null) {
      try {
        switch (int.parse(selectOption)) {
          case 1:
            helper.clearConsole();
            print("Enter Your UserName: ");
            var username = stdin.readLineSync();

            print("Enter Your Password: ");
            var password = stdin.readLineSync();

            if (!helper.empty(username) && !helper.empty(password)) {
              login(username!, password!);
            }
            break;
          case 2:
            helper.clearConsole();
            userDashboard();
            break;
        }
      } catch (e) {
        print('Invalid Option...');
      }
    }
  }

  // User dashboard
  void userDashboard() {
    // check auth
    if (!auth()) {
      print("unAuthorize 401");
      return;
    }

    var menu = ["1- add personal data", "2- buy", "3- logout"];

    print("Hello $_currentUser");
    for (var item in menu) {
      print(item); //show menu
    }

    //select option
    var selectOption = stdin.readLineSync();
    var userDashboard = UserDashboard();
    if (selectOption != null) {
      try {
        switch (int.parse(selectOption)) {
          case 1:
            userDashboard.addPersonalData();
            break;
          case 2:
            print("your selected 2");
            break;
        }
      } catch (e) {
        print("Invalid Option Try Again...");
      }
    }
  }
}

class UserDashboard {
  void addPersonalData() {
    print("add personal data");
  }
}
