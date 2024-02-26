import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class CustomTextFormField extends StatefulWidget {
    CustomTextFormField({Key? key, required this.pswKey,
      required this.type, required this.obscure}) : super(key: key);

    GlobalKey<FormFieldState> pswKey;
    String type;
    bool obscure;

    @override
    State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

    late bool _myObscure;

    String validatePwd(String pwd) {
        if(pwd.isEmpty) {
            return "Campo obbligatorio";
        } else if(!RegExp(
            r"^(?=.*?[A-Z])"      // Almeno una maiuscola
            r"(?=.*?[a-z])"       // Almeno una minuscola
            r"(?=.*?[0-9])"       // Almeno un numero
            r"(?=.*?[!@#\$&*~]).{8,}$"  // Almeno un carattere speciale e lunga almeno 8 char
        ).hasMatch(pwd)) {
            return "Password non valida,\ndeve essere lunga almeno 8 caratteri"
                "\ne deve contenere almeno:"
                "\n- una maiuscola"
                "\n- una minuscola"
                "\n- un numero"
                "\n- un simbolo a scelta tra questi [!@#\$&*~]";
        }
        return " ";
    }

    @override
    void initState() {
        super.initState();
        widget.obscure ? _myObscure = true : _myObscure = false;
    }

    void _toggle() {
        setState(() {
            _myObscure = !_myObscure;
        });
    }

    @override
    Widget build(BuildContext context) {
        switch(widget.type) {
            case "Usr-Email": /// SignUp
                return TextFormField(
                    decoration: const InputDecoration(labelText: "Email"),
                    onSaved: (value) => {}, //widget.usr.mail = value!,
                    validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email"
                );
            case "Cust-Pwd": /// Login
                return TextFormField(
                    key: widget.pswKey,
                    //controller: pass,
                    obscureText: _myObscure,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                            icon: Icon(
                                _myObscure
                                ? Icons.visibility_off
                                : Icons.visibility
                            ),
                            onPressed: _toggle,
                        )
                    ),
                    onSaved: (value) {
                        setState(() {
                            //widget.cust.pwd = value!;
                        });
                    },
                    validator: (value) {
                        if(value!.isEmpty) {
                            return "Campo obbligatorio";
                        } else {
                            return null;
                        }
                    },
                );
            case "Usr-Pwd":  /// SignUp
                return TextFormField(
                    key: widget.pswKey,
                   // controller: pass,
                    obscureText: _myObscure,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                            icon: Icon(
                                _myObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility
                            ),
                            onPressed: _toggle,
                        )
                    ),
                    onSaved: (value) {
                        setState(() {
                            //widget.usr.pwd = value!;
                        });
                    },
                    validator: (value) {
                        String ris = validatePwd(value!);
                        return ris == " " ? null : ris;
                    },
              );
            case "Conf-Pwd":  /// SignUp
                return TextFormField(
                    obscureText: _myObscure,
                    //controller: confirmPass,
                    decoration: InputDecoration(
                        labelText: "Conferma Password",
                        suffixIcon: IconButton(
                            icon: Icon(
                                _myObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility
                            ),
                            onPressed: _toggle,
                        )
                    ),
                    onSaved: (value) {
                        setState(() {
                            //widget.usr.rePwd = value!;
                        });
                    },
                    validator: (value) {
                        if(value != widget.pswKey.currentState!.value) return "Le due password non coincidono";
                        return null;
                    },
                );
            case "Name": /// SignUp
                return TextFormField(
                    decoration: const InputDecoration(labelText: "Nome"),
                    onSaved: (value) => {}, //widget.usr.name = value!,
                    validator: (value) {
                        if(value == null || value.isEmpty) {
                            return "Campo obbligatorio";
                        } else if(value.length < 3) {
                            return "Nome non valido";
                        }
                        return null;
                    },
                );
            default:
                return const Scaffold(body: null);
        }
    }
}
