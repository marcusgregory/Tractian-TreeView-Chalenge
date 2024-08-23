import 'package:flutter/material.dart';
import 'package:treeview_challenge/src/app/presentation/icons/tractian_icons_icons.dart';

import '../../domain/entities/asset.entity.dart';
import '../../domain/enums/component_sensor_type.enum.dart';
import '../../domain/enums/component_status.enum.dart';

class ItemTreeWidget extends StatelessWidget {
  const ItemTreeWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    IconData displayedIcon = TractianIcons.location;

    ComponentStatusEnum? currentStatus;
    ComponentSensorTypeEnum? currentSensorType;

    if (data is AssetEntity) {
      if (data.sensorType != null) {
        displayedIcon = TractianIcons.component;
        currentStatus = data.status;
        currentSensorType = data.sensorType;
      } else {
        displayedIcon = TractianIcons.asset;
      }
    }

    return Row(
      children: [
        Icon(
          displayedIcon,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 16.0,
        ),
        Flexible(
          child: Text(
            data.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Visibility(
          visible: currentSensorType == ComponentSensorTypeEnum.energy,
          child: const Icon(
            Icons.bolt,
            color: Colors.green,
          ),
        ),
        Visibility(
          visible: currentStatus == ComponentStatusEnum.alert,
          child: const Icon(
            Icons.circle,
            color: Colors.red,
            size: 14.0,
          ),
        ),
      ],
    );
  }
}
