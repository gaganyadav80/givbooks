import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/app/bloc/app_bloc.dart';
import 'package:givbooks/utils/utils.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:velocity_x/velocity_x.dart';

import 'cubit/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    // context.read<AppBloc>().add(AppLogoutRequested())

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SettingsList(
          applicationType: ApplicationType.cupertino,
          platform: DevicePlatform.iOS,
          // contentPadding: const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 0.0),
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile.navigation(
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.photo ??
                            'https://picsum.photos/seed/picsum/200/300',
                      ),
                      radius: 32.r,
                    ),
                  ),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user.name!.text.make(),
                      VSpace(5.w),
                      user.email!.text.caption(context).make(),
                    ],
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: "Appearance".text.make(),
              tiles: [
                SettingsTile.switchTile(
                  initialValue: state.isDarkMode,
                  activeSwitchColor: Theme.of(context).primaryColor,
                  leading: const Icon(CupertinoIcons.moon_stars),
                  onToggle: (value) => context
                      .read<SettingsCubit>()
                      .toggleDarkMode(value, context),
                  title: "Dark Mode".text.make(),
                ),
              ],
            ),
            SettingsSection(
              title: "Account".text.make(),
              tiles: [
                SettingsTile.navigation(
                  title: "Forgot Password?".text.make(),
                  leading: Icon(CupertinoIcons.padlock),
                  onPressed: (_) => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Reset Password"),
                      content: const Text(
                          "We will send a password reset link to your email address"),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text("Reset"),
                          onPressed: () {
                            context
                                .read<AppBloc>()
                                .add(AppUserResetPassword(user.email!));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SettingsTile.navigation(
                  title: "Logout".text.make(),
                  leading: Icon(CupertinoIcons.person),
                  onPressed: (_) => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text("Logout"),
                          onPressed: () {
                            context.read<AppBloc>().add(AppLogoutRequested());
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
