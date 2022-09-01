import 'package:flutter/material.dart';
import 'package:flutter_application/library/global/path.dart';
import 'package:flutter_application/widget/faq/home_ui.dart';

class FAQHomePage extends StatelessWidget {
  const FAQHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Column(
          children: [
            const WTitle(text: "選股畫面"),
            WItem(
              text: "前往選股畫面說明",
              onPressed: () { toPath(context, '/faq/pickstock'); },
            ),
            WItem(
              text: "前往選股畫面",
              onPressed: () { toPath(context, '/'); },
            ),
            const WTitle(text: "券商買賣超"),
            WItem(
              text: "前往券商買賣超說明",
              onPressed: () { toPath(context, '/faq/broker'); },
            ),
            WItem(
              text: "前往券商買賣超",
              onPressed: () { toPath(context, '/'); },
            ),
            const WTitle(text: "自選股"),
            WItem(
              text: "前往自選股說明",
              onPressed: () { toPath(context, '/faq/group'); },
            ),
            WItem(
              text: "前往自選股",
              onPressed: () { toPath(context, '/mystock'); },
            ),
            const WTitle(text: "回測系統"),
            WItem(
              text: "前往回測系統說明",
              onPressed: () { toPath(context, '/faq/testing'); },
            ),
            WItem(
              text: "前往回測系統",
              onPressed: () { toPath(context, '/'); },
            ),
            const WTitle(text: "Telegram"),
            WItem(
              text: "前往Telegram說明",
              onPressed: () { toPath(context, '/faq/telegram'); },
            ),
            const WTitle(text: "法律聲明"),
            WItem(
              text: "免責聲明",
              onPressed: () { toPath(context, '/faq/disclaimer'); },
            ),
            WItem(
              text: "隱私權聲明",
              onPressed: () { toPath(context, '/faq/privacy'); },
            ),
          ],
        ),
      ),
    );
  }
}