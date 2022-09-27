import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/strow_bloc/strow_bloc.dart';
import 'package:mbc_mobile/models/strow_model.dart';
import 'package:mbc_mobile/screens/strow/strow_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';

class StrowBody extends StatefulWidget {
  final String userId;

  const StrowBody({Key? key, required this.userId}) : super(key: key);
  @override
  _StrowBodyState createState() => _StrowBodyState();
}

class _StrowBodyState extends State<StrowBody> {
  late StrowBloc strowBloc;

  @override
  void initState() {
    super.initState();

    strowBloc = BlocProvider.of<StrowBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    strowBloc.add(StrowFetchDataEvent());

    print("StrowBody");
    return BlocListener<StrowBloc, StrowState>(
      listener: (context, state) {
        if (state is StrowErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is StrowSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<StrowBloc, StrowState>(builder: (context, state) {
        EasyLoading.dismiss();

        if (state is StrowInitialState || state is StrowLoadingState) {
          return _buildLoading();
        } else if (state is StrowLoadedState) {
          return body(state.datas);
        } else if (state is StrowSuccessState) {
          return body(state.datas);
        } else if (state is StrowErrorState) {
          return body(state.datas);
        } else {
          return _buildLoading();
        }
      }),
    );
  }

  Widget body(List<Strow> list) {
    if (list.length == 0) {
      return Center(
        child: Text("Data not yet"),
      );
    }
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
              columnSpacing: 10,
              columns: [
                DataColumn(
                    label: Text("Aksi",
                        style: Theme.of(context).textTheme.subtitle1)),
                DataColumn(
                    label: Text("Nama Sapi",
                        style: Theme.of(context).textTheme.subtitle1)),
                DataColumn(
                    label: Text("Kode Batch",
                        style: Theme.of(context).textTheme.subtitle1)),
                DataColumn(
                    label: Text("Batch",
                        style: Theme.of(context).textTheme.subtitle1)),
              ],
              rows: list
                  .map((e) => DataRow(cells: [
                        DataCell(Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StrowFormScreen(
                                                      strow: e,
                                                      userId: widget.userId)))
                                      .then((value) => setState(() {}));
                                },
                                child:
                                    Icon(Icons.edit, color: kSecondaryColor)),
                            SizedBox(width: 8),
                            GestureDetector(
                                onTap: () {
                                  alertConfirm(e);
                                },
                                child: Icon(Icons.delete, color: Colors.red))
                          ],
                        )),
                        DataCell(Text(e.sapi!.namaSapi,
                            style: Theme.of(context).textTheme.caption)),
                        DataCell(Text(e.kodeBatch,
                            style: Theme.of(context).textTheme.caption)),
                        DataCell(Text(e.batch,
                            style: Theme.of(context).textTheme.caption)),
                      ]))
                  .toList()),
        ),
      ),
    );
  }

  void alertConfirm(Strow strow) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, delete it",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      strowBloc.add(StrowDeleteEvent(strow: strow));
      return;
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
