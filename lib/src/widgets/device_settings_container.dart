import 'package:dashbook/src/widgets/helpers.dart';
import 'package:dashbook/src/widgets/select_device/custom_device.dart';
import 'package:dashbook/src/widgets/select_device/device_settings.dart';
import 'package:dashbook/src/widgets/select_device/select_device.dart';
import 'package:dashbook/src/widgets/side_bar_panel.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

class DeviceSettingsContainer extends StatefulWidget {
  final VoidCallback onCancel;

  const DeviceSettingsContainer({
    Key? key,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<DeviceSettingsContainer> createState() =>
      _DeviceSettingsContainerState();
}

class _DeviceSettingsContainerState extends State<DeviceSettingsContainer> {
  final _formKey = GlobalKey<FormState>();
  bool _isCustom = false;

  @override
  void initState() {
    super.initState();
  }

  set isCustom(bool isCustom) {
    setState(() {
      _isCustom = isCustom;
      DeviceSettings.of(context, listen: false).updateDevice(
        isCustom ? Devices.android.largeTablet : null,
      );
    });
  }

  bool get isCustom => _isCustom;

  @override
  Widget build(BuildContext context) {
    return SideBarPanel(
      title: 'Properties',
      width: sideBarSizeProperties(context),
      onCancel: widget.onCancel,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isCustom)
              CustomDevice(
                formKey: _formKey,
                changeToList: () {
                  isCustom = false;
                },
              )
            else
              SelectDevice(changeToCustom: () => isCustom = true),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}