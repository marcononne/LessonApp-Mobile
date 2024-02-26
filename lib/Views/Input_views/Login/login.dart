import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Resources/userApi.dart';
import '../../../Resources/my_strings.dart';
import '../../Home/homepage_controller.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';


class Login extends StatelessWidget {
    const Login({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: My_Strings.loginTitle,
            theme: Theme.of(context),
            home: MyLoginPage(title: My_Strings.loginTitle)
        );
    }
}

class MyLoginPage extends StatefulWidget {
    MyLoginPage({Key? key, required this.title}) : super(key: key);

    final String title;

    @override
    State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
    late bool _myObscure;
    final _formKey = GlobalKey<FormState>();
    final HomePageController controller = Get.find<HomePageController>();
    final TextEditingController user = TextEditingController();
    final TextEditingController pass = TextEditingController();
    Color fieldColor = const Color(0xFFE0E3E2);

    @override
    void initState() {
        super.initState();
        _myObscure = true;
    }

    void _toggle() {
        setState(() {
            _myObscure = !_myObscure;
        });
    }

    void setLabelColor(int val, BuildContext context) {
        setState(() {
            if(val == 0) {  // okay
                fieldColor = Theme.of(context).colorScheme.onBackground;
            } else {        // error
                fieldColor = Theme.of(context).colorScheme.errorContainer;
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea (
            child: Scaffold(
                appBar: CustomAppBar(label: "Login", arrow: true),
                backgroundColor: const Color(0xFF191C1C),
                body: Form(
                    key: _formKey,
                    child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 190.0, horizontal: 20.0),
                        children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: TextFormField(
                                    controller: user,
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                    cursorColor: Theme.of(context).colorScheme.onBackground,
                                    decoration: InputDecoration(
                                        labelText: "Username",
                                        labelStyle: TextStyle(
                                            color: fieldColor
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: fieldColor
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: fieldColor
                                            )
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: fieldColor
                                            )
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: fieldColor
                                            )
                                        ),
                                        errorStyle: TextStyle(
                                            color: Theme.of(context).colorScheme.errorContainer
                                        ),
                                    ),
                                    validator: (value) {
                                        if(value!.isEmpty) {
                                            setLabelColor(1, context);
                                            return "This field cannot be empty";
                                        } else {
                                            return null;
                                        }
                                    },
                                    onChanged: (val) => setLabelColor(0, context),
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: TextFormField(
                                    controller: pass,
                                    obscureText: _myObscure,
                                    cursorColor: Theme.of(context).colorScheme.onBackground,
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                    decoration: InputDecoration(
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                            color: fieldColor
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: fieldColor
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: fieldColor
                                            )
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: fieldColor
                                            )
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: fieldColor
                                            )
                                        ),
                                        errorStyle: TextStyle(
                                            color: Theme.of(context).colorScheme.errorContainer
                                        ),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                                _myObscure
                                                    ? Icons.visibility_off
                                                    : Icons.visibility
                                            ),
                                            onPressed: _toggle,
                                            color: fieldColor
                                        )
                                    ),
                                    validator: (value) {
                                        if(value!.isEmpty) {
                                            setLabelColor(1, context);
                                            return "This field cannot be empty";
                                        } else {
                                            return null;
                                        }
                                    },
                                    onChanged: (val) => setLabelColor(0, context),
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                                    onPressed: () async {
                                        if(_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
                                            String role = await UserApi().login(user.text, pass.text);
                                            if(role == "Admin") {
                                                controller.goToAdminHome(user.text);
                                            } else {
                                                if(role == "Client") {
                                                    controller.goToCustomerHomePage(user.text);
                                                } else {
                                                    setLabelColor(1, context);
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) => Dialog(
                                                            backgroundColor: Theme.of(context).colorScheme.onError,
                                                            child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                children: [
                                                                    Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            "Wrong credentials",
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: Theme.of(context).colorScheme.error,
                                                                                fontStyle: FontStyle.italic,
                                                                                fontWeight: FontWeight.bold
                                                                            )
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            "Please check your username and your password",
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: Theme.of(context).colorScheme.error,
                                                                                fontStyle: FontStyle.italic,
                                                                            ),
                                                                        ),
                                                                    )
                                                                ],
                                                            ),
                                                        )
                                                    );
                                                }
                                            }
                                        }
                                    },
                                    child: Text("Login", style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer))
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
