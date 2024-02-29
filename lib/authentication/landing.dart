import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';


import 'landing_model.dart';
import 'login_screen.dart';
export 'landing_model.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late LandingPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation2': AnimationInfo(
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
    'textOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 300.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 300.ms,
          begin: const Offset(0, 140),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'textOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 300.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 300.ms,
          begin: const Offset(0, 140),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };


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
                    colors: [Color(0xCCFFFFFF),Color(0xFF4B39EF)],
                    stops: [0,1],
                    begin: AlignmentDirectional(1.8, -1),
                    end: AlignmentDirectional(-1, 1.8),
                  ),
                ),
                alignment: const AlignmentDirectional(-1, 0),
                child: Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: SingleChildScrollView(
                    child: // Generated code for this Column Widget...
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          // decoration: const BoxDecoration(
                          //   color: Color(0xCCFFFFFF),
                          //   shape: BoxShape.circle,
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              'asset/images/mimage.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation2']!),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                          child: Text(
                            'INSU-Tracking',
                            style: FlutterFlowTheme.of(context).displaySmall.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: const Color(0xFF101213),
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                          child: Text(
                            'ADMIN',
                            style: FlutterFlowTheme.of(context).displaySmall.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: const Color(0xFF101213),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                          child: Text(
                            'Thanks for joining! Access or create your account below, and get started on your journey!',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: const Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation2']!),
                        ),
                        Container(
                          height: 100,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignInWidget()));
                            },
                            text: 'Get Started',
                            options: FFButtonOptions(
                              width: 230,
                              height: 52,
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: const Color(0xFF333333),
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                              ),
                              elevation: 3,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    )
                    ,
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
