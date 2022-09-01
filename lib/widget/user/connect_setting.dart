import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth/bloc.dart';
import 'package:flutter_application/application/stock/bloc.dart';
import 'package:flutter_application/config/color.dart';
import 'package:flutter_application/config/stock.dart';
import 'package:flutter_application/infrastructure/user.dart';
import 'package:flutter_application/library/global/input.dart';
import 'package:flutter_application/library/global/response.dart';
import 'package:flutter_application/library/global/toast.dart';
import 'package:flutter_application/library/user/connect.dart';
import 'package:flutter_application/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectSetting extends StatefulWidget {
  final String token;
  const ConnectSetting({Key? key, required this.token}): super(key: key);

  @override
  ConnectSettingState createState() => ConnectSettingState();
}

class ConnectSettingState extends State<ConnectSetting> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late int rank = 0;
  late String account = '';
  late String token = widget.token;
  late String chooseConnect = '';
  late String email = '';
  late String telegram = '';
  late String phone = '';

  void setChoose(String val) {
    setState(() {
      chooseConnect = val;
    });
  }
 
  void getUserSetting(String token) async {
    var res = await getConnectSetting(token);
    if (res.code != 10000) {
      apiErrorAction(res.code, '取得使用者設定失敗', context);
    }
    var defaultSetting = res.body!;
    setState(() {
      chooseConnect = defaultSetting.sendAction;
      email = defaultSetting.email;
      emailController.text = email;
      telegram = defaultSetting.chatID;
      telegramController.text = telegram;
      phone = defaultSetting.phone;
      phoneController.text = phone;
    });
  }

  @override
  void initState() {
    getUserSetting(widget.token);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    account = authBloc.state.account;
    rank = authBloc.state.rank;
    return Theme(
      data: ThemeData(unselectedWidgetColor: rootColor['lightBorder']),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 'email',
                groupValue: chooseConnect,
                onChanged: (String? value) { setChoose(value!); },
              ),
              RadioLabel(
                label: "E-mail",
                callback: () { setChoose('email'); }
              ),
              Expanded(
                child: TextField(
                  controller: emailController,
                  decoration: inputUnderLineStyle(),
                  style: TextStyle(
                    color: rootColor['mainFont'],
                  ),
                  onChanged: (String? value) {
                    email = value!;
                  },
                ),
              )
            ]
          ),
          Row(
            children: [
              Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 'telegram',
                groupValue: chooseConnect,
                onChanged: (String? value) { setChoose(value!); },
              ),
              RadioLabel(
                label: "Telegram",
                callback: () { setChoose('telegram'); }
              ),
              Expanded(
                child: TextField(
                  controller: telegramController,
                  decoration: inputUnderLineStyle(),
                  style: TextStyle(
                    color: rootColor['mainFont'],
                  ),
                  onChanged: (String? value) {
                    telegram = value!;
                  },
                )
              )
            ]
          ),
          Row(
            children: [
              Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 'phone',
                groupValue: chooseConnect,
                onChanged: (String? value) { setChoose(value!); },
              ),
              RadioLabel(
                label: "Phone",
                callback: () { setChoose('phone'); }
              ),
              Expanded(
                child: TextField(
                  controller: phoneController,
                  decoration: inputUnderLineStyle(),
                  style: TextStyle(
                    color: rootColor['mainFont'],
                  ),
                  onChanged: (String? value) {
                    phone = value!;
                  },
                )
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: rootColor['dangerButton'],
                ),
                onPressed: () {
                  setChoose('');
                },
                child: const Text("不選擇"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: rootColor['sendButton'],
                  ),
                  onPressed: () async {
                    if (checkInput(email, telegram, phone, chooseConnect)) {
                      showFlushbar("選擇方式及對應欄位不得為空", context, 'error', '接收方式修改失敗');
                    } else {
                      var res = await storeConnectSetting(token, account, email, telegram, phone, chooseConnect, rank);
                      if (res.code == 10000) {
                        showToast('接收方式修改成功', context, 'success');
                      } else {
                        showFlushbar(res.message, context, 'error', '接收方式修改失敗');
                      }
                    }
                  },
                  child: const Text("儲存"),
                )
            ],
          )
        ],
      )
    );
  }
}

class StrategySetting extends StatefulWidget {
  final String token;
  const StrategySetting({Key? key, required this.token}): super(key: key);

  @override
  StrategySettingState createState() => StrategySettingState();
}

class StrategySettingState extends State<StrategySetting> {
  late Map<String, ConnectStrrategy> allStategy = {};
  late bool test = false;
  late String token = '';
 
  void getDefaultStrategy(String token) async {
    var res = await getConnectStrategy(token);
    if (res.code != 10000) {
      apiErrorAction(res.code, '取得使用者策略設定失敗', context);
    }
    var defaultSetting = res.body!;
    setState(() {
      allStategy = defaultSetting;
    });
  }

  @override
  void initState() {
    getDefaultStrategy(widget.token);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    token = BlocProvider.of<AuthBloc>(context).state.token;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Label(label: "策略選項"),
            SizedBox(
              width: 80,
              child: Center(
                child: Label(label: "第一天符合"),
              )
            )
          ],
        ),
        for (var key in allStategy.keys.toList()) Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      side: BorderSide(color: rootColor['mainFont']!),
                      value: allStategy[key]!.needSend == 1,
                      onChanged: (bool? val) {
                        setState(() {
                          allStategy[key]!.needSend = val! ? 1 : 0;
                        });
                      }
                    ),
                    RadioLabel(
                      label: key,
                      callback: () {
                        setState(() {
                          allStategy[key]!.needSend = allStategy[key]!.needSend == 0 ? 1 : 0;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 115,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(
                              color: rootColor['border']!
                            )
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          filled: true,
                          fillColor: rootColor['cardBg']
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            itemHeight: 48,
                            value: allStategy[key]!.filterMarket,
                            alignment: Alignment.center,
                            dropdownColor: rootColor['cardBg'],
                            items: stockClassOption.keys.toList().map<DropdownMenuItem<String>>((key) => DropdownMenuItem<String>(
                                value: stockClassOption[key],
                                child: Option(label: key),
                              )
                            ).toList(),
                            onChanged: (String? val) {
                              setState(() {
                                allStategy[key]!.filterMarket = val!;
                              });
                            }
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 150,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(
                              color: rootColor['border']!
                            )
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          filled: true,
                          fillColor: rootColor['cardBg']
                        ),
                        child: DropdownButtonHideUnderline(
                          child: BlocBuilder<StockBloc, StockState>(builder: (context, state) {
                            var options = state.industrys.map((x) => { 'name': x, 'value': x }).toList();
                            options.insert(0, { 'name': '--行業別--', 'value': '' });
                            return DropdownButton<String>(
                              itemHeight: 48,
                              value: allStategy[key]!.industry,
                              alignment: Alignment.center,
                              dropdownColor: rootColor['cardBg'],
                              items: options.map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
                                  value: item['value'],
                                  child: Option(label: item['name']!),
                                )
                              ).toList(),
                              onChanged: (String? val) {
                                setState(() {
                                  allStategy[key]!.industry = val!;
                                });
                              }
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 80,
              height: 100,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Checkbox(
                  side: BorderSide(color: rootColor['mainFont']!),
                  value: allStategy[key]!.firstMatch == 1,
                  onChanged: (bool? val) {
                    setState(() {
                      allStategy[key]!.firstMatch = val! ? 1 : 0;
                    });
                  }
                ),
              )
            )
          ]
        ),
        Container(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: rootColor['sendButton'],
              ),
              onPressed: () async {
                var count = 0;
                for (var item in allStategy.values) {
                  if (item.needSend == 1) { count ++; }
                }
                if (count > 5) {
                  showFlushbar("訂閱的策略上限為5個", context, 'error', '訂閱策略失敗');
                } else {
                  var res = await storeConnectStrategy(token, allStategy);
                  if (res.code == 10000) {
                    showToast('接收方式修改成功', context, 'success');
                  } else {
                    showFlushbar(res.message, context, 'error', '訂閱策略失敗');
                  }
                }
              },
              child: const Text("儲存"),
            )
        )
      ],
    );
  }
}

class RadioLabel extends StatelessWidget {
  final String label;
  final Function() callback;
  const RadioLabel({Key? key, required this.label, required this.callback}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => callback(),
      child: Label(label: label,)
    );
  }
}

class Label extends StatelessWidget {
  final String label;
  const Label({Key? key, required this.label}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 16,
        fontWeight: FontWeight.bold
      )
    );
  }
}

class Option extends StatelessWidget {
  final String label;
  const Option({Key? key, required this.label}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: rootColor['mainFont'],
        fontSize: 14,
        fontWeight: FontWeight.bold
      )
    );
  }
}
