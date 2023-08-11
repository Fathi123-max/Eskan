import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_new)),
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: 100.0,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icon.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "أهلا بكم فى اسكان !",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "نحن مجموعه اسكان العقاريه نهدف بك لسهوله الوصول للحياة اللتي تستحقها من خلال البحث عن عقار ملائم وآمن نسعي للحصول علي منزل افضل ومستقبل افضل",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () => Get.dialog(Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Card(
                    margin: EdgeInsets.all(15),
                    child: Markdown(
                      controller: ScrollController(),
                      selectable: true,
                      data: '''##  شروط الاستخدام

1. نحن لسنا وكالة عقارات، وإنما نقدم خدمة من خلالها يستطيع الوكلاء ممارسة التسويق ويمكنك مشاهدة تفاصيل العقارات وإرسال الاستفسارات إليك مباشرة. ولا نشترك في أي اتصالات بينك وبين الوكلاء ولا تشارك في أي جزء من الصفقة.

2. نحن نحفظ التفاصيل بحسن نية ولكن هذه التفاصيل تُنتج مباشرة من قبل العملاء و/أو أطراف ثالثة ولا نقوم بالتحقق منها. وأنتم من تتحملون مسؤولية تقديم الاستفسارات الخاصة بكم، ونحن لا نقدم أي ضمان ولا نتحمل أية مسؤولية عن دقة أو اكتمال أي من المعلومات الواردة في التفاصيل.

3. أنتم المسؤولون عن التحقق من التفاصيل وتأكيدها والاطمئنان إلى صحتها.

4. تتحملون مسؤولية الاستعانة بمساحين و/أو الحصول على المشورة القانونية قبل الالتزام بأي عملية شراء. وتتحملون مسؤولية ضمان تصرفكم بحسن نية تجاه أي أطراف أخرى. عند دخولكم الموقع أو استخدامكم له، تقرون وتتعهدون تعهداً نهائياً أنكم لن:

   - تستخدموا أي جهاز آلي، أو برامج أو وسيلة للوصول إلى أو استرداد أو نسخ أو فهرسة الموقع الإلكتروني الخاص بنا أو أي محتوى على موقعنا على الإنترنت.
   - تستخدموا أي جهاز آلي، أو برمجيات، أو وسائل للتدخل أو محاولة التدخل في التشغيل الصحيح لموقعنا على الإنترنت.
   - تقوموا بإرسال الرسائل غير المرغوب بها أو الرسائل المتسلسلة أو المحتوى العشوائي أو الاستطلاعات أو الرسائل الجماعية الأخرى.
   - تقوموا بإرسال أو محاولة إرسال أي فيروسات حاسوبية أو فيروسات متنقلة (ديدان) أو عيوب أو أي مواد تدميرية أخرى.

## الترخيص والقيود

نحتفظ بالحق في ممارسة أي تدابير نرى أنها ضرورية لمنع الوصول غير المصرح به لاستخدام الموقع، بما في ذلك على سبيل المثال لا الحصر، إقامة الحواجز التكنولوجية، أو الإبلاغ عن السلوك الخاص بك لأي شخص أو كيان.

ينتهي هذا الترخيص تلقائياً إذا خرقتم أيا من هذه الشروط، ويمكن إنهاؤه من قبلنا في أي وقت. وعند إنهاء مشاهدتكم لهذه المواد أو عند انتهاء هذا الترخيص، يجب عليكم إتلاف أي مواد تم تحميلها في حيازتكم سواء أكان في شكل مادة مطبوعة أو إلكترونية.

## الضمان والمسؤولية

لا نتحمل في أي حال من الأحوال المسؤولية عن أية أضرار (بما في ذلك، دون حصر، التعويض عن فقدان البيانات أو الأرباح) التي تنشأ من استخدام أو عدم القدرة على استخدام المواد على الموقع.

ولن نتحمل أي مسؤولية تجاهكم عن أية خسارة أو ضرر، ناشئ من أو متعلق بالآتي:
- أي عطل بسبب البرنامج أو أخطاء في شبكة الإنترنت أو عدم التوفر أو أي أسباب أخرى خارجة عن إرادتنا المعقولة.
- أي فقدان لكلمة المرور أو الحساب إذا كان بسبب انقطاع الكهرباء أو حدوث خطأ بها أو توقفها.
- استخدام، أو عدم القدرة على استخدام موقعنا.
- الاعتماد على أي محتوى أو معلومات تم عرضها على موقعنا.
- أي خسارة مباشرة أو تبعية أو خاصة أو جزائية، أو ضرر، أو تكاليف والنفقات.
- خسارة أرباح؛ خسارة أعمال؛ خسارة الشهرة؛ تراجع الشهرة؛ فقد البيانات أو تلفها أو فسادها.

## المساهمات والقيود

أنتم مسؤولون عن المساهمات التي تقدمونها وتقرون وتتعهدون بالآتي:
- أن لديكم الحق القانوني بما في ذلك جميع التراخيص اللازمة والحقوق.
- لن تقدموا أي مساهمات تتعدى حقوق الملكية الفكرية لأي طرف ثالث.
- لن تقدموا أي مساهمات مضللة أو خادعة أو غير صحيحة بالأساس.
- لن تقدموا مساهمات تسبب جريمة أو تحتوي على إساءات أو محتوى غير لائق.
 ''',
                    )),
              )),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "الشروط والاحكام ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => launchWhatsApp(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "تواصل معانا عبر الواتساب",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

launchWhatsApp() async {
  try {
    final link = WhatsAppUnilink(phoneNumber: '+201024021764', text: "");
    await launch('$link');
  } catch (e) {
    print(e);
  }
}
