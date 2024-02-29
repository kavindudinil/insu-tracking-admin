import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'create_account_model.dart';
export 'create_account_model.dart';

class CreateAccount4Widget extends StatefulWidget {
  const CreateAccount4Widget({super.key});

  @override
  State<CreateAccount4Widget> createState() => _CreateAccount4WidgetState();
}

class _CreateAccount4WidgetState extends State<CreateAccount4Widget> {
  late CreateAccount4Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateAccount4Model());

    _model.emailAddressController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.confirmPasswordController ??= TextEditingController();
    _model.confirmPasswordFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 100,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0.87, -1),
                    end: AlignmentDirectional(-0.87, 1),
                  ),
                ),
                alignment: const AlignmentDirectional(0, -1),
                child: Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 32, 0, 32),
                          child: Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              'INSU-Tracking',
                              style: FlutterFlowTheme.of(context).displaySmall,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 570,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2,
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Create an account',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 24),
                                      child: Text(
                                        'Let\'s get started by filling out the form below.',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller:
                                              _model.emailAddressController,
                                          focusNode:
                                              _model.emailAddressFocusNode,
                                          autofocus: true,
                                          autofillHints: const [
                                            AutofillHints.email
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            labelStyle: FlutterFlowTheme.of(
                                                    context)
                                                .labelLarge
                                                .override(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color:
                                                      const Color(0xFF57636C),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFF1F4F8),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFF4B39EF),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor:const Color(0xFFF1F4F8),
                                            contentPadding:
                                                const EdgeInsets.all(24),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: const Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: _model
                                              .emailAddressControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _model.passwordController,
                                          focusNode: _model.passwordFocusNode,
                                          autofocus: true,
                                          autofillHints: const [
                                            AutofillHints.password
                                          ],
                                          obscureText:
                                              !_model.passwordVisibility,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF57636C),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFF1F4F8),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFF4B39EF),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFE0E3E7),
                                                  width: 2,
                                                ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor:
                                            const Color(0xFFF1F4F8),
                                            contentPadding:
                                                const EdgeInsets.all(24),
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                () => _model
                                                        .passwordVisibility =
                                                    !_model.passwordVisibility,
                                              ),
                                              focusNode: FocusNode(
                                                  skipTraversal: true),
                                              child: Icon(
                                                _model.passwordVisibility
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: const Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          validator: _model
                                              .passwordControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller:
                                              _model.confirmPasswordController,
                                          focusNode:
                                              _model.confirmPasswordFocusNode,
                                          autofocus: true,
                                          autofillHints: const [
                                            AutofillHints.password
                                          ],
                                          obscureText:
                                              !_model.confirmPasswordVisibility,
                                          decoration: InputDecoration(
                                            labelText: 'Confirm Password',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF57636C),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFF1F4F8),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFF4B39EF),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor:
                                            const Color(0xFFF1F4F8),
                                            contentPadding:
                                                const EdgeInsets.all(24),
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                () => _model
                                                        .confirmPasswordVisibility =
                                                    !_model
                                                        .confirmPasswordVisibility,
                                              ),
                                              focusNode: FocusNode(
                                                  skipTraversal: true),
                                              child: Icon(
                                                _model.confirmPasswordVisibility
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: const Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          validator: _model
                                              .confirmPasswordControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 16),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            // GoRouter.of(context).prepareAuthEvent();
                                            if (_model
                                                    .passwordController.text !=
                                                _model.confirmPasswordController
                                                    .text) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Passwords don\'t match!',
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            // final user = await authManager
                                            //     .createAccountWithEmail(
                                            //   context,
                                            //   _model.emailAddressController.text,
                                            //   _model.passwordController.text,
                                            // );
                                            // if (user == null) {
                                            //   return;
                                            // }
                                            //
                                            // context.goNamedAuth(
                                            //     'null', context.mounted);
                                          },
                                          text: 'Get Started',
                                          options: FFButtonOptions(
                                            width: 230,
                                            height: 52,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                            elevation: 3,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 0, 16, 24),
                                        child: Text(
                                          'Or sign up with',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Wrap(
                                        spacing: 16,
                                        runSpacing: 0,
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.center,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 16),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                // GoRouter.of(context)
                                                //     .prepareAuthEvent();
                                                // final user = await authManager
                                                //     .signInWithGoogle(context);
                                                // if (user == null) {
                                                //   return;
                                                // }
                                                //
                                                // context.goNamedAuth(
                                                //     'null', context.mounted);
                                              },
                                              text: 'Continue with Google',
                                              icon: const FaIcon(
                                                FontAwesomeIcons.google,
                                                size: 20,
                                              ),
                                              options: FFButtonOptions(
                                                width: 230,
                                                height: 44,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                elevation: 0,
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                hoverColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                            ),
                                          ),
                                          isAndroid
                                              ? Container()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 0, 0, 16),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      // GoRouter.of(context)
                                                      //     .prepareAuthEvent();
                                                      // final user = await authManager
                                                      //     .signInWithApple(context);
                                                      // if (user == null) {
                                                      //   return;
                                                      // }
                                                      //
                                                      // context.goNamedAuth(
                                                      //     'null', context.mounted);
                                                    },
                                                    text: 'Continue with Apple',
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons.apple,
                                                      size: 20,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 230,
                                                      height: 44,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0, 0, 0, 0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0, 0, 0, 0),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                      elevation: 0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      hoverColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),

                                    // You will have to add an action on this rich text to go to your login page.
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 12),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text:
                                                    'Already have an account?  ',
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: 'Sign In',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          textScaler: TextScaler.linear(
                                              MediaQuery.of(context)
                                                  .textScaleFactor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
