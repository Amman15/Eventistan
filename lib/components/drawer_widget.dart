import 'package:eventistan/providers/future_providers.dart';
import 'package:eventistan/providers/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventistan/providers/go_router.dart';
import 'package:eventistan/flutter_flow/flutter_flow_theme.dart';
import 'package:eventistan/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventistan/components/drawer_model.dart';

export 'drawer_model.dart';

class DrawerWidget extends ConsumerStatefulWidget {
  const DrawerWidget({super.key});

  @override
  ConsumerState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends ConsumerState<DrawerWidget> {
  late DrawerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrawerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final user = ref.watch(userProvider);

    return Container(
      width: 320.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(0.0, 2.0),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        12.0,
                        0.0,
                      ),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).accent1,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: user.when(
                              data: (data) {
                                return Image.network(
                                  data.profilePicture ?? '',
                                  width: 36.0,
                                  height: 36.0,
                                  fit: BoxFit.cover,
                                );
                              },
                              error: (error, stackTrace) {
                                return Image.asset(
                                  'assets/images/avatar.jpeg',
                                  width: 36.0,
                                  height: 36.0,
                                  fit: BoxFit.cover,
                                );
                              },
                              loading: () {
                                return Image.asset(
                                  'assets/images/avatar.jpeg',
                                  width: 36.0,
                                  height: 36.0,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        4.0,
                        0.0,
                        0.0,
                        0.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.when(data: (data) {
                              return data.name ?? '';
                            }, error: (error, stackTrace) {
                              return '';
                            }, loading: () {
                              return '';
                            }),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              4.0,
                              0.0,
                              0.0,
                            ),
                            child: Text(
                              user.when(data: (data) {
                                return data.email ?? '';
                              }, error: (error, stackTrace) {
                                return '';
                              }, loading: () {
                                return '';
                              }),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  12.0,
                  0.0,
                  12.0,
                  4.0,
                ),
                child: TextButton(
                  onPressed: () async {
                    await ref.read(userProvider.future);

                    if (context.mounted) {
                      context.goNamed(
                        AppRoute.profile.name,
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      8.0,
                      0.0,
                      8.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 0.0, 0.0),
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0,
                            0.0,
                            0.0,
                            0.0,
                          ),
                          child: Text(
                            'My Account',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              user.when(
                data: (data) {
                  if (data.role == 'Attendee') {
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0,
                        0.0,
                        12.0,
                        4.0,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await ref.read(userProvider.future);

                          if (context.mounted) {
                            context.goNamed(
                              AppRoute.purchases.name,
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            8.0,
                            0.0,
                            8.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.attach_money,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 20.0,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0,
                                  0.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Text(
                                  'Purchases',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                error: (error, stackTrace) => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  12.0,
                  0.0,
                  12.0,
                  4.0,
                ),
                child: TextButton(
                  onPressed: () async {
                    await ref.read(userProvider.future);

                    if (context.mounted) {
                      context.goNamed(AppRoute.settings.name);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      8.0,
                      0.0,
                      8.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 0.0, 0.0),
                        child: Icon(
                          Icons.settings_outlined,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Settings',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  12.0,
                  0.0,
                  12.0,
                  4.0,
                ),
                child: TextButton(
                  onPressed: () {
                    ref.read(tokenProvider.notifier).setToken('');
                    ref.invalidate(userProvider);
                    if (context.mounted) {
                      context.goNamed(
                        AppRoute.main.name,
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      8.0,
                      0.0,
                      8.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 0.0, 0.0),
                        child: Icon(
                          Icons.login_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Log out',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
