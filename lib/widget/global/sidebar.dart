import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/application/stock/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/library/auth/dialog.dart';
import 'package:flutter_application/library/auth/logout.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_application/library/stock/dialog.dart';
import 'package:flutter_application/model/stock.dart';
import 'package:flutter_application/widget/global/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

List<SidebarItem> pageList = [];
List<SidebarItem> settingList = [];

void setPageList(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  pageList = [];
  pageList.addAll([
    SidebarItem( title: '選股', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/');}),
    SidebarItem( title: '券商買賣超', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/');}),
    SidebarItem( title: '自選股', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/mystock');}),
    SidebarItem( title: '警示股', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/warning');}),
    SidebarItem( title: '回測系統', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/');}),
    SidebarItem( title: '我的券商', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/mybroker');}),
  ]);
}
void setSettingList(BuildContext context, BuildContext parentContext, GlobalKey<ScaffoldState> scaffoldKey) {
  settingList = [];
  settingList.addAll([
    SidebarItem( title: '個人設定', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/connect'); }),
    SidebarItem( title: '訂閱方案', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/'); }),
    SidebarItem( title: '修改密碼', onTap: () { closeSidebar(scaffoldKey); showUpdatePWDDialog(parentContext); }),
    SidebarItem( title: 'FAQ', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/faq'); }),
    SidebarItem( title: '免責聲明', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/faq/disclaimer'); }),
    SidebarItem( title: '隱私權聲明', onTap: () { closeSidebar(scaffoldKey); toPath(context, '/faq/privacy'); }),
  ]);
}
void closeSidebar(GlobalKey<ScaffoldState> scaffoldKey) {
  if (scaffoldKey.currentState != null && scaffoldKey.currentState!.isDrawerOpen) {
    scaffoldKey.currentState!.openEndDrawer();
  }
}

class Sidebar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final BuildContext parentContext;
  late String token = '';
  late String account = '';
  late String email = '';
  late int rank = 0;
  Sidebar({Key? key, required GlobalKey<ScaffoldState> scaffoldKey, required this.parentContext}) : _scaffoldKey = scaffoldKey, super(key: key);

  @override
  Widget build(BuildContext mainContext) {
    setPageList(mainContext, _scaffoldKey);
    setSettingList(mainContext, parentContext, _scaffoldKey);
    var authBloc = BlocProvider.of<AuthBloc>(mainContext);
    token = authBloc.state.token;
    account = authBloc.state.account;
    email = authBloc.state.email;
    rank = authBloc.state.rank;

    return Drawer(
      backgroundColor: rootColor['cardBg'],
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Stack(
                children: [
                  if (rank == 3) const VIPTitle()
                  else if (rank == 2) const AdvancedTitle()
                  else const GenerallyTitle(),
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          overflow: TextOverflow.ellipsis,
                          account.length > 10 ? email : account,
                          style: TextStyle(
                            color: rootColor['mainFont'],
                            fontSize: 20
                          ),
                        )
                    ),
                  ),
                ],
              )
          ),
          ListTile(
            minVerticalPadding: 0.2,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: SizedBox(
              height: 30,
              child: BlocBuilder<StockBloc, StockState>(builder: (context, state) {
                return TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      hintText: "輸入查詢股票",
                      hintStyle: TextStyle(
                        color: rootColor['placeholder'],
                        fontSize: 12
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: rootColor['border']!,
                        )
                      )
                    ),
                    style: TextStyle(
                      color: rootColor['mainFont'],
                    )
                  ),
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    color: rootColor['bgColor'],
                  ),
                  suggestionsCallback: (pattern) async {
                    List<StockOption> stockList = [];
                    if (pattern.length >= 2) {
                      for (var key in state.allStock.keys.toList()) {
                        if (key.contains(pattern) || state.allStock[key]!.contains(pattern)) {
                          StockOption stockOption = StockOption(code: key, name: state.allStock[key]!);
                          stockList.add(stockOption);
                        }
                      }
                    }
                    return stockList;
                  },
                  itemBuilder: (context, StockOption suggestion) {
                    return ListTile(
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(
                        "${suggestion.code} - ${suggestion.name}",
                        style: TextStyle(color: rootColor['mainFont']),
                      ),
                    );
                  },
                  noItemsFoundBuilder: (context) {
                    return ListTile(
                      title: Text(
                        "查無此股票",
                        style: TextStyle(color: rootColor['mainFont']),
                      )
                    );
                  },
                  onSuggestionSelected: (StockOption suggestion) {
                    print(suggestion);
                    showStockDialog(suggestion.code, parentContext);
                    closeSidebar(_scaffoldKey);
                  },
                );
              })
            )
          ),
          WListTile(
            title: '回首頁',
            onTap: () { toPath(mainContext, '/'); closeSidebar(_scaffoldKey); }
          ),
          const PaddingHr(),
          for ( var i in pageList ) WListTile(
            title: i.title,
            onTap: i.onTap,
          ),
          const PaddingHr(),
          for ( var i in settingList ) WListTile(
            title: i.title,
            onTap: i.onTap,
          ),
          const PaddingHr(),
          WListTile(
            title: '登出',
            onTap: () { logout(mainContext); }
          ),
        ],
      )
    );
  }
}

class WListTile extends StatelessWidget {
  final String _title;
  final Function() _onTap;

  const WListTile({Key? key, required String title, required Function() onTap}) : _title = title, _onTap = onTap, super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Center(
        child: Text(
          _title,
          style: TextStyle(
            color: rootColor['mainFont'],
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      onTap: _onTap,
    );
  }
}

class VIPTitle extends StatelessWidget {
  const VIPTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: const Color.fromARGB(255, 26, 12, 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(200, 237, 228, 206),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
        child: Text(
          "VIP",
          style: TextStyle(
            color: Color.fromARGB(255, 220, 173, 46)
          ),
        )
      ),
    );
  }
}

class AdvancedTitle extends StatelessWidget {
  const AdvancedTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: const Color.fromARGB(255, 240, 216, 143),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
        child: Text(
          "高級",
          style: TextStyle(
            color: Color.fromARGB(255, 201, 104, 0)
          ),
        )
      ),
    );
  }
}

class GenerallyTitle extends StatelessWidget {
  const GenerallyTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: const Color.fromARGB(255, 97, 153, 229),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
        child: Text(
          "一般",
          style: TextStyle(
            color: Color.fromARGB(255, 221, 234, 235)
          ),
        )
      ),
    );
  }
}

class SidebarItem {
  final String title;
  final Function() onTap;

  SidebarItem({required this.title, required this.onTap});
}