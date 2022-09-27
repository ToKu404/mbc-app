import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/bloc/panen_bloc/panen_bloc.dart';
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/panen_model.dart';
import 'package:mbc_mobile/repositories/panen_repo.dart';
import 'package:mbc_mobile/screens/panen/panen_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class PanenScreen extends StatelessWidget {
  final String userId;
  final String hakAkses;

  const PanenScreen(Key? key, this.userId, this.hakAkses) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Panen", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
          create: (context) => PanenBloc(PanenRepositoryImpl()),
          child: Container(
            padding: EdgeInsets.all(8),
            child: PanenScreenBody(null, userId),
          )),
      floatingActionButton: Visibility(
        visible: hakAkses == "3" ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PanenFormScreen(null, userId, null, "", hakAkses)));
          },
          backgroundColor: kSecondaryColor,
          child: Icon(Icons.add_alert_rounded),
        ),
      ),
    );
  }
}

class PanenScreenBody extends StatefulWidget {
  final String userId;
  const PanenScreenBody(Key? key, this.userId) : super(key: key);

  @override
  _PanenScreenBodyState createState() => _PanenScreenBodyState();
}

class _PanenScreenBodyState extends State<PanenScreenBody> {
  late PanenBloc panenBloc;

  @override
  void initState() {
    panenBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    panenBloc.add(PanenFetchDataEvent(id: widget.userId));
    return BlocBuilder<PanenBloc, PanenState>(
      builder: (context, state) {
        print(state);
        if (state is PanenInitial || state is PanenLoadingState) {
          return buildLoading();
        } else if (state is PanenLoadeState) {
          return body(state.model.panen!);
        } else if (state is PanenErrorState) {
          return buildError(state.msg);
        } else {
          return buildError(state.toString());
        }
      },
    );
  }

  Widget body(List<Panen> list) {
    if (list.length == 0) {
      return Center(
        child: Text("Data not yet"),
      );
    }
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var data = list[index];
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actions: [
                IconSlideAction(
                  caption: 'Print',
                  icon: FontAwesomeIcons.fileExport,
                  foregroundColor: Colors.blueAccent,
                  color: Colors.transparent,
                  onTap: () {
                    _launchURL(Api().exportURL + "/5/" + data.id.toString());
                  },
                ),
              ],
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                Api.imageURL + '/' + list[index].foto)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'MBC-${data.sapi!.generasi}.${data.sapi!.anakKe}-${data.sapi!.eartagInduk}-${data.sapi!.eartag}',
                                style: TextStyle(
                                    fontSize: 18, color: kSecondaryColor),
                              ),
                              Text(data.tanggal,
                                  style: TextStyle(
                                      fontSize: 14, color: kHintTextColor)),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Status", style: TextStyle(fontSize: 14)),
                              Text("${data.status}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red)),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Keterangan Panen",
                                  style: TextStyle(fontSize: 14)),
                              Text("${data.keterangan}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildError(String msg) {
    return Center(
      child: Text(msg,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }
}
