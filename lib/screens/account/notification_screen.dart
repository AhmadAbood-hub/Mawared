import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/utilties/iconly_icons.dart';
import 'package:provider/provider.dart';

import 'account_data.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ChangeNotifierProvider(
          create: (context) => NotificationData(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "الأشعارات",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Colors.black54),
              ),
              iconTheme: IconThemeData(
                color: const Color(0xFF6991C7),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: NotificationBody(),
          ),
        ));
  }
}

class NotificationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<NotificationData>(context).notifications.length > 0
        ? ListView.builder(
            itemCount:
                Provider.of<NotificationData>(context).notifications.length,
            padding: const EdgeInsets.all(5.0),
            itemBuilder: (context, index) {
              return Dismissible(
                  direction: DismissDirection.startToEnd,
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    Provider.of<NotificationData>(context, listen: false)
                        .deleteNotification(index);
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  child: Container(
                    height: 88.0,
                    child: Column(
                      children: <Widget>[
                        Divider(height: 5.0),
                        ListTile(
                          title: Text(
                            '${Provider.of<NotificationData>(context).notifications[index].title}',
                            style: TextStyle(
                                fontSize: 17.5,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Container(
                              width: 440.0,
                              child: Text(
                                '${Provider.of<NotificationData>(context).notifications[index].desc}',
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black38),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          leading: Column(
                            children: <Widget>[
                              Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60.0)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        Provider.of<NotificationData>(context)
                                            .notifications[index]
                                            .image,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                              ),
                                            )),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: Icon(
                                        FontAwesomeIcons.image,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            //todo something
                          },
                        ),
                        Divider(height: 5.0),
                      ],
                    ),
                  ));
            })
        : NoItemNotifications();
  }
}

class NoItemNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 100.0)),
            Image.asset(
              "assets/images/noNotification.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              "لا يوجد اشعارات",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.5,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
