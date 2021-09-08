import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iteservice_dashboard/utilities/utils.dart';

class UserCircle extends StatelessWidget {
  final String profileImage;
  final String name;
  final double radius;

  const UserCircle({Key? key, required this.profileImage, required this.name, this.radius = 23}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return profileImage != "" ? CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(
        "$profileImage",
      ),
    ):CircleAvatar(
      radius: radius,
      child: Text(Utils.getInitials(name)),
    );
  }
}
