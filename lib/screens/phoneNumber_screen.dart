import '../blocs/phonebloc/phone_number_bloc.dart';
import '../blocs/phonebloc/phone_number_event.dart';
import '../services/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/phonebloc/phone_number_state.dart';
import '../services/token_provider.dart';
import '../widgets/textfield.dart';
import 'code_screen.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  late TextEditingController phoneNumController;
  late GlobalKey _formKey;
  @override
  void initState() {
    super.initState();
    phoneNumController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    context.read<TokenProvider>().init(context);
    return BlocProvider(
      create: (context) =>
          PhoneNumberBloc(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        
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
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
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
                                bottom: 8,
                                top: 28,
                              ),
                              child: Text(
                                'Welcome!',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                              'Phone Number',
                              'Your Number',
                              phoneNumController,
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
                              child: BlocListener<PhoneNumberBloc,
                                  PhoneNumberState>(
                                listener: (context, state) {
                                  if (state is PhoneNumberSuccess) {
                                    Navigator.of(context)
                                        .pushNamed(CodeScreen.routename);
                                  }
                                },
                                child: BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<PhoneNumberBloc>(
                                                context)
                                            .add(SubmitPhoneNumberEvent(
                                                phoneNumController.text));
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
                            )
                          ]),
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
