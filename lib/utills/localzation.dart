import 'package:get/get.dart';

/// Localization translations for the Eskan app.
/// Supports Arabic (ar_EG) as the primary locale.
/// 
/// Note: For production apps, consider migrating to ARB-based localization
/// using flutter_localizations and intl packages for better tooling support.
class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_EG': {
          // App-level
          'appTitle': 'إسكان',
          
          // Navigation
          'home': 'الرئيسية',
          'favorites': 'المفضلة',
          'myServices': 'عقاراتي',
          'search': 'البحث',
          
          // Home page
          'welcome': 'أهلا بكم فى إسكان',
          'featured': 'عناصر مميزة',
          'recentlyAdded': 'مضاف حديثا',
          'noProperties': 'لم تضف عقارات بعد',
          
          // Property form
          'addProperty': 'أضف عقار',
          'propertyName': 'اسم العقار',
          'propertyType': 'نوع العقار',
          'selectCity': 'اختر المدينة',
          'selectArea': 'اختر المنطقة',
          'area': 'المنطقة',
          'size': 'المساحة',
          'sizeHint': 'المساحة بالمتر',
          'bedrooms': 'غرف النوم',
          'bedroomsHint': 'عدد غرف النوم',
          'bathrooms': 'الحمامات',
          'bathroomsHint': 'عدد الحمامات',
          'kitchen': 'المطبخ',
          'kitchenHint': 'عدد المطابخ',
          'halls': 'قاعات الاستقبال',
          'hallsHint': 'عدد أماكن الاستقبال',
          'price': 'السعر',
          'rentPrice': 'الإيجار / الشهر',
          'description': 'الوصف',
          'descriptionHint': 'وصف العقار',
          'selectImages': 'اختر الصور',
          'saveProperty': 'حفظ العقار',
          
          // Messages
          'propertyAdded': 'تمت إضافة العقار',
          'somethingWentWrong': 'حدث خطأ ما',
          'selectImagesFirst': 'يرجى اختيار الصور أولاً',
          
          // Property details
          'address': 'العنوان',
          'addressHint': 'أدخل عنوان العقار',
          'city': 'المدينة',
          'areaName': 'المنطقة',
          'propertyFor': 'نوع الإعلان',
          'forSale': 'للبيع',
          'forRent': 'للإيجار',
          
          // Account
          'accountSettings': 'إعدادات الحساب',
          'name': 'الاسم',
          'phone': 'الهاتف',
          'logout': 'تسجيل الخروج',
          'noAccount': 'ليس لديك حساب',
          'editProfile': 'تعديل الملف الشخصي',
          
          // Search
          'searchPlaceholder': 'ابحث باسم المنطقة',
          'filters': 'الفلاتر',
          'searchButton': 'بحث',
          'selectCityHint': 'أدخل اسم المدينة',
          'selectProperty': 'اختر العقار',
          'selectService': 'اختر الخدمة',
          'serviceName': 'اسم الخدمة',
          'serviceProvider': 'مقدم العقار',
          'typeOfService': 'نوع العقار',
          'enterInfo': 'أدخل معلوماتك',
          'enterPropertyDetails': 'أدخل تفاصيل العقار لتدرجه في الإعلانات',
          
          // Results
          'noResults': 'لا توجد نتائج بحث',
          'searchResults': 'نتائج البحث',
          
          // Labels
          'ownerName': 'المالك: {name}',
          'propertyDetails': 'تفاصيل العقار',
          'contactOwner': 'اتصل بالمُلك',
          'shareProperty': 'شارك العقار',
          'addToFavorites': 'أضف للمفضلة',
          'removeFromFavorites': 'إزالة من المفضلة',
          
          // Common
          'loading': 'جارٍ التحميل...',
          'error': 'حدث خطأ',
          'retry': 'إعادة المحاولة',
          'cancel': 'إلغاء',
          'confirm': 'تأكيد',
          'noInternet': 'لا يوجد اتصال بالإنترنت',
          'tryAgain': 'حاول مرة أخرى',
        },
      };
}
