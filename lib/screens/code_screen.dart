import '../blocs/otpbloc/otp_bloc.dart';
import '../blocs/otpbloc/otp_event.dart';
import '../screens/home_screen.dart';
import '../services/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/otpbloc/otp_state.dart';
import '../services/token_provider.dart';
import '../widgets/textfield.dart';

class CodeScreen extends StatefulWidget {
  static const routename = '/code_screen';
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  @override
  Widget build(BuildContext context) {
    void initState() {
    // TODO: implement initState
    super.initState();
   
  }
    
    TextEditingController codeController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => OtpBloc(context),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    height: constraints.maxHeight * 1 / 2,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(200),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: constraints.maxWidth * 0.82,
                    height: constraints.maxHeight * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 4,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: constraints.maxWidth * 0.38,
                            height: constraints.maxHeight * 0.15,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(120),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 10,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFieldWidget(
                            'Code',
                            'Your Code',
                            codeController,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return "* Required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: BlocListener<OtpBloc, OtpState>(
                              listener: (context, state) {
                                if (state is OtpSuccess) {
                                  Navigator.of(context)
                                      .pushNamed(HomeScreen.routename);
                                }
                              },
                              child: BlocBuilder<OtpBloc, OtpState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<OtpBloc>(context).add(
                                          SubmitOtpEvent(
                                              int.parse(codeController.text),));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 0,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        top: 15,
                                        bottom: 10,
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
