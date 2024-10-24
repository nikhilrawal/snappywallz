import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:snappywalls/models/imageModel.dart';
import 'package:snappywalls/pages/full_screen.dart';

Widget wallpaper(List<Photomodel> listphotos, BuildContext context) {
  return Expanded(
    child: Container(
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            children: listphotos.map(
              (Photomodel photomodel) {
                return GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  imagepath: photomodel.src!.portrait!)));
                    },
                    child: Hero(
                      tag: photomodel.src!.portrait!,
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: photomodel.src!.portrait!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList())),
  );
}
