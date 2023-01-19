import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/View-Model/third_screen.dart';


class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    final userprovider =
        Provider.of<ThirdScreenProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
            color: const Color.fromRGBO(85, 74, 240, 1),
          ),
          title: const Text("Third Screen"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: context.read<ThirdScreenProvider>().setAllUser,
          child: FutureBuilder(
            future: userprovider.setAllUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        onLongPress: () {
                          final selectuser =
                              userprovider.getusers.elementAt(index);
                          context
                              .read<ThirdScreenProvider>()
                              .selectedUser(selectuser);
                          Navigator.pop(context);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${userprovider.getusers[index].avatar}"),
                        ),
                        title: Text(
                          "${userprovider.getusers[index].firstName} ${userprovider.getusers[index].lastName}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        subtitle: Text(
                          "${userprovider.getusers[index].email}".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(104, 103, 119, 1)),
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: userprovider.getusers.length);
            },
          ),
        ));
  }
}
