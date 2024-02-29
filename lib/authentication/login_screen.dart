import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insu_tracking_admin/authentication/firebase_auth.dart';
import 'package:insu_tracking_admin/authentication/screens/home.dart';
import 'package:provider/provider.dart';

import 'create_account.dart';
import 'login_screen_model.dart';
export 'login_screen_model.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget>
    with TickerProviderStateMixin {
  late SignInModel _model;
  final AuthenticationService _authManager = AuthenticationService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(0, 140),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
        ),
        TiltEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(-0.349, 0),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignInModel());

    _model.emailAddressController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
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
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  width: 100,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    // color: Colors.black12,
                    gradient: LinearGradient(
                      colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0.87, -1),
                      end: AlignmentDirectional(-0.87, 1),
                    ),
                  ),
                  alignment: const AlignmentDirectional(0, -1),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'asset/images/Mask_group_(9).png',
                            width: 237,
                            height: 58,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Text(
                        //   'INSU -Tracking',
                        //   style: FlutterFlowTheme.of(context)
                        //       .displaySmall
                        //       .override(
                        //         fontFamily: 'Plus Jakarta Sans',
                        //         color: Colors.white,
                        //         fontSize: 25,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 570,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.5)],
                              ),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Get Started',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: const Color(0xFF101213),
                                            fontSize: 36,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 24),
                                      child: Text(
                                        'Let\'s get started by filling out the form below.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: const Color(0xFF57636C),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
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
                                                color: Color(0xFFf44336),
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
                                            fillColor: const Color(0xFFF1F4F8),
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
                                                color: Color(0xFFFF5963),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF5963),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xFFF1F4F8),
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
                                                color: const Color(0xFF57636C),
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
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          // GoRouter.of(context).prepareAuthEvent();
                                          //
                                          // final user =
                                          // await authManager.signInWithEmail(
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
                                        text: 'Create Account',
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 44,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 0),
                                          iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                          color: const Color(0xFF4B39EF),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                          elevation: 3,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 24),
                                      child: Text(
                                        'Or sign up with',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: const Color(0xFF57636C),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          // _signInWithGoogle();
                                          _signInWithGoogle();
                                          // GoRouter.of(context).prepareAuthEvent();
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
                                          width: double.infinity,
                                          height: 44,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 0),
                                          iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                          color: Colors.white,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: const Color(0xFF101213),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                          elevation: 0,
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          hoverColor: const Color(0xFFF1F4F8),
                                        ),
                                      ),
                                    ),
                                    isAndroid
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 16),
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
                                                width: double.infinity,
                                                height: 44,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                color: Colors.white,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          color: const Color(
                                                              0xFF101213),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                elevation: 0,
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFE0E3E7),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                hoverColor:
                                                    const Color(0xFFF1F4F8),
                                              ),
                                            ),
                                          ),

                                    // You will have to add an action on this rich text to go to your login page.
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 12),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Don\'t have an account?  ',
                                              style: TextStyle(),
                                            ),
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const CreateAccount4Widget())),
                                              text: 'Sign Up here',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color:
                                                        const Color(0xFF4B39EF),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: const Color(0xFF101213),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        textScaler: TextScaler.linear(
                                            MediaQuery.of(context)
                                                .textScaleFactor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithGoogle() async {
    User? user = (await _authManager.signInIP());

    if (user != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomeWidget()));
    }
  }
}
