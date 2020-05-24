import 'package:farmcart/pages/seller/add_team_member_page.dart';
import 'package:farmcart/services/my_team_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyTeamPage extends StatefulWidget {
  @override
  _MyTeamPageState createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {
  @override
  Widget build(BuildContext context) {
    final MyTeamService _myTeamService = Provider.of<MyTeamService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Team',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor,
                  ),
            ),
          ),
          titleSpacing: 0.0,
          elevation: 1.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
              // color: Colors.black,
              ),
        ),
        backgroundColor: Colors.orange.shade100,
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _myTeamService.getMyTeamMembers(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding: EdgeInsets.all(12.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> member = snapshot.data[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        // isThreeLine: true,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'ID',
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orange,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              member['Id'],
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      // color: Colors.orange,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          member['Name'],
                          style: GoogleFonts.lato(
                            textStyle:
                                Theme.of(context).textTheme.subhead.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orange,
                                    ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              member['Contact'],
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.grey.shade700,
                                    ),
                              ),
                            ),
                            Text(
                              member['City'],
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                        // fontWeight: FontWeight.w700,
                                        // color: Colors.orange,
                                        ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Status',
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orange,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              member['Status'],
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      // color: Colors.orange,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: RaisedButton(
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: 132.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  'નવા મેમ્બર ઉમેરો',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.subhead.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTeamMemberPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
