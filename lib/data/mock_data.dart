import 'models/app_notification.dart';
import 'models/company.dart';
import 'models/trip.dart';

/// Sample content used until the backend API is connected.
abstract class MockData {
  static const companies = <Company>[
    Company(
      id: 'safra-express',
      name: 'سفره إكسبريس',
      location: 'بغداد',
      specialty: 'رحلات شاملة',
      rating: '4.9',
      foundedYear: 2016,
      phone: '+964 770 000 1001',
      imageUrl:
          'https://images.unsplash.com/photo-1488085061387-422e29b40080?w=400&q=80',
      about:
          'شركة سياحية مقرها بغداد تنظّم رحلات جماعية إلى مختلف محافظات العراق، مع باصات حديثة ومشرفين مرافقين طوال الرحلة.',
    ),
    Company(
      id: 'kurdistan-tourism',
      name: 'كردستان للسياحة',
      location: 'أربيل',
      specialty: 'شمال العراق',
      rating: '4.8',
      foundedYear: 2012,
      phone: '+964 750 000 2002',
      imageUrl:
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400&q=80',
      about:
          'متخصصون برحلات إقليم كردستان: المدن التاريخية، المصايف والجبال، مع مرشدين محليين يعرفون المنطقة جيداً.',
    ),
    Company(
      id: 'atabat-transport',
      name: 'العتبات للنقل السياحي',
      location: 'النجف',
      specialty: 'عتبات مقدسة',
      rating: '4.7',
      foundedYear: 2009,
      phone: '+964 780 000 3003',
      imageUrl:
          'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400&q=80',
      about:
          'رحلات زيارة منظمة إلى العتبات المقدسة في النجف وكربلاء والكاظمية وسامراء، مع خدمة مريحة للعوائل وكبار السن.',
    ),
    Company(
      id: 'south-marshes',
      name: 'أهوار الجنوب',
      location: 'ذي قار',
      specialty: 'طبيعة وأهوار',
      rating: '4.6',
      foundedYear: 2018,
      phone: '+964 781 000 4004',
      imageUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&q=80',
      about:
          'نأخذك في جولات المشاحيف داخل أهوار الجبايش وزيارة مدينة أور الأثرية، مع ضيافة جنوبية أصيلة.',
    ),
    Company(
      id: 'basra-tours',
      name: 'بصرة تورز',
      location: 'البصرة',
      specialty: 'جنوب العراق',
      rating: '4.5',
      foundedYear: 2015,
      phone: '+964 771 000 5005',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&q=80',
      about:
          'جولات في البصرة القديمة وشط العرب والفاو، تجمع بين التاريخ والاسترخاء على الكورنيش.',
    ),
    Company(
      id: 'duhok-mountains',
      name: 'جبال دهوك',
      location: 'دهوك',
      specialty: 'مغامرات',
      rating: '4.8',
      foundedYear: 2019,
      phone: '+964 751 000 6006',
      imageUrl:
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400&q=80',
      about:
          'رحلات مغامرات ومشي جبلي في دهوك والعمادية وزاخو لمحبي الطبيعة والهواء الطلق.',
    ),
  ];

  static const trips = <Trip>[
    Trip(
      id: 'erbil-historic',
      title: 'رحلة أربيل التاريخية',
      location: 'أربيل · كردستان',
      category: TripCategory.north,
      companyId: 'kurdistan-tourism',
      days: 3,
      dateLabel: 'السبت · 17 تشرين الأول',
      price: 120000,
      rating: '4.9',
      seatsLeft: 8,
      meetingPoint: 'بغداد · ساحة النسور · 6:00 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800&q=80',
      description:
          'ثلاثة أيام في عاصمة الإقليم بين القلعة التاريخية والأسواق القديمة والمصايف القريبة، مع إقامة فندقية وسط المدينة.',
      highlights: [
        'قلعة أربيل وسوق القيصرية',
        'منارة المظفرية وحديقة سامي عبد الرحمن',
        'مصيف شقلاوة وجبل سفين',
      ],
      itinerary: [
        (
          title: 'الانطلاق والوصول',
          details:
              'التحرك من بغداد صباحاً، الوصول والسكن ثم جولة مسائية في القلعة.',
        ),
        (
          title: 'معالم المدينة',
          details: 'سوق القيصرية، المنارة والحدائق، وعشاء جماعي.',
        ),
        (
          title: 'شقلاوة والعودة',
          details: 'زيارة مصيف شقلاوة ثم العودة إلى بغداد مساءً.',
        ),
      ],
    ),
    Trip(
      id: 'sulaymaniyah-mountains',
      title: 'سليمانية والجبال',
      location: 'سليمانية · كردستان',
      category: TripCategory.north,
      companyId: 'kurdistan-tourism',
      days: 2,
      dateLabel: 'الأحد · 18 تشرين الأول',
      price: 110000,
      rating: '4.8',
      seatsLeft: 14,
      meetingPoint: 'بغداد · ساحة النسور · 5:30 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80',
      description:
          'يومان بين جبال السليمانية وأسواقها، مع إطلالات جبل أزمر ومصيف سرجنار.',
      highlights: [
        'جبل أزمر وإطلالة المدينة',
        'مصيف سرجنار',
        'شارع سالم والأسواق الشعبية',
      ],
      itinerary: [
        (
          title: 'الطريق إلى السليمانية',
          details: 'الانطلاق فجراً، الوصول ظهراً ثم جولة في المدينة وجبل أزمر.',
        ),
        (
          title: 'سرجنار والعودة',
          details: 'صباح في المصيف، تسوّق حر ثم التحرك نحو بغداد.',
        ),
      ],
    ),
    Trip(
      id: 'duhok-nature',
      title: 'دهوك والطبيعة',
      location: 'دهوك · كردستان',
      category: TripCategory.north,
      companyId: 'duhok-mountains',
      days: 2,
      dateLabel: 'الإثنين · 19 تشرين الأول',
      price: 95000,
      rating: '4.7',
      seatsLeft: 10,
      meetingPoint: 'أربيل · كراج الشمال · 7:00 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800&q=80',
      description:
          'رحلة هادئة إلى دهوك والعمادية، بين السدود والوديان والقرى الجبلية.',
      highlights: ['سد دهوك', 'مدينة العمادية المعلّقة', 'مصيف سولاف'],
      itinerary: [
        (
          title: 'دهوك',
          details: 'الوصول، زيارة السد وجولة مسائية في مركز المدينة.',
        ),
        (
          title: 'العمادية وسولاف',
          details: 'يوم كامل بين العمادية ومصيف سولاف ثم العودة.',
        ),
      ],
    ),
    Trip(
      id: 'holy-shrines',
      title: 'زيارة العتبات المقدسة',
      location: 'النجف · كربلاء',
      category: TripCategory.shrines,
      companyId: 'atabat-transport',
      days: 1,
      dateLabel: 'الأحد · 18 تشرين الأول',
      price: 45000,
      rating: '4.7',
      seatsLeft: 20,
      meetingPoint: 'بغداد · ساحة عدن · 5:00 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800&q=80',
      description:
          'زيارة ليوم واحد إلى النجف الأشرف وكربلاء المقدسة مع وقت كافٍ في كل عتبة.',
      highlights: [
        'مرقد الإمام علي (ع) في النجف',
        'مسجد الكوفة',
        'العتبتان الحسينية والعباسية',
      ],
      itinerary: [
        (
          title: 'النجف الأشرف',
          details: 'الزيارة صباحاً ثم مسجد الكوفة ووجبة الغداء.',
        ),
        (
          title: 'كربلاء المقدسة',
          details: 'الزيارة عصراً والعودة إلى بغداد بعد صلاة العشاء.',
        ),
      ],
    ),
    Trip(
      id: 'kadhimiya-samarra',
      title: 'مسار الكاظمين وسامراء',
      location: 'بغداد · سامراء',
      category: TripCategory.shrines,
      companyId: 'safra-express',
      days: 1,
      dateLabel: 'الثلاثاء · 20 تشرين الأول',
      price: 35000,
      rating: '4.6',
      seatsLeft: 16,
      meetingPoint: 'بغداد · الكاظمية · 6:30 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?w=800&q=80',
      description:
          'مسار قصير يجمع زيارة الكاظمية المقدسة مع سامراء ومئذنتها الملوية.',
      highlights: [
        'العتبة الكاظمية المقدسة',
        'مرقد الإمامين العسكريين (ع)',
        'المئذنة الملوية',
      ],
      itinerary: [
        (title: 'الكاظمية', details: 'الزيارة صباحاً ثم التحرك نحو سامراء.'),
        (
          title: 'سامراء',
          details: 'الزيارة، جولة عند الملوية ثم العودة عصراً.',
        ),
      ],
    ),
    Trip(
      id: 'shrines-full',
      title: 'رحلة العتبات الشاملة',
      location: 'النجف · كربلاء · الكاظمين',
      category: TripCategory.shrines,
      companyId: 'atabat-transport',
      days: 3,
      dateLabel: 'الخميس · 22 تشرين الأول',
      price: 90000,
      rating: '4.9',
      seatsLeft: 6,
      meetingPoint: 'البصرة · ساحة سعد · 4:30 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&q=80',
      description:
          'برنامج متكامل لثلاثة أيام يشمل جميع العتبات المقدسة مع سكن قريب من الحرم.',
      highlights: ['النجف والكوفة', 'كربلاء المقدسة', 'الكاظمية وسامراء'],
      itinerary: [
        (
          title: 'النجف والكوفة',
          details: 'الوصول والسكن، الزيارة ومسجدا الكوفة والسهلة.',
        ),
        (title: 'كربلاء', details: 'يوم كامل في كربلاء مع المبيت قرب الحرم.'),
        (title: 'الكاظمية وسامراء', details: 'الزيارة ثم التحرك للعودة مساءً.'),
      ],
    ),
    Trip(
      id: 'southern-marshes',
      title: 'جولة الأهوار الجنوبية',
      location: 'الأهوار · ذي قار',
      category: TripCategory.south,
      companyId: 'south-marshes',
      days: 2,
      dateLabel: 'الجمعة · 16 تشرين الأول',
      price: 85000,
      rating: '4.8',
      seatsLeft: 9,
      meetingPoint: 'الناصرية · كراج بغداد · 7:00 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
      description:
          'جولة بالمشحوف وسط القصب في أهوار الجبايش، مع زيارة زقورة أور والمبيت في مضيف تراثي.',
      highlights: [
        'جولة مشاحيف في أهوار الجبايش',
        'زقورة أور الأثرية',
        'غداء سمك مسگوف في المضيف',
      ],
      itinerary: [
        (
          title: 'أور والناصرية',
          details: 'زيارة الزقورة والمتحف ثم التحرك إلى الجبايش والمبيت.',
        ),
        (
          title: 'الأهوار',
          details: 'جولة المشاحيف عند الشروق، الغداء في المضيف ثم العودة.',
        ),
      ],
    ),
    Trip(
      id: 'faw-beach',
      title: 'شاطئ الفاو واسترخاء',
      location: 'البصرة · الفاو',
      category: TripCategory.south,
      companyId: 'basra-tours',
      days: 2,
      dateLabel: 'الإثنين · 19 تشرين الأول',
      price: 95000,
      rating: '4.6',
      seatsLeft: 12,
      meetingPoint: 'البصرة · كورنيش شط العرب · 8:00 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
      description:
          'يومان للاسترخاء عند رأس البيشة وشط العرب مع جولة بحرية قصيرة.',
      highlights: [
        'رأس البيشة',
        'جولة بحرية في شط العرب',
        'مزارع الحنّاء في الفاو',
      ],
      itinerary: [
        (
          title: 'الفاو',
          details: 'التحرك من البصرة، الوصول والغداء ثم الشاطئ حتى الغروب.',
        ),
        (
          title: 'الجولة البحرية',
          details: 'جولة صباحية بالزورق ثم العودة إلى البصرة.',
        ),
      ],
    ),
    Trip(
      id: 'basra-historic',
      title: 'البصرة التاريخية',
      location: 'البصرة',
      category: TripCategory.south,
      companyId: 'basra-tours',
      days: 1,
      dateLabel: 'الأربعاء · 21 تشرين الأول',
      price: 55000,
      rating: '4.5',
      seatsLeft: 18,
      meetingPoint: 'البصرة · ساحة أم البروم · 9:00 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800&q=80',
      description:
          'جولة ليوم واحد بين شناشيل البصرة القديمة وأسواقها وكورنيش شط العرب.',
      highlights: [
        'شناشيل البصرة القديمة',
        'متحف البصرة الحضاري',
        'سوق العشار والكورنيش',
      ],
      itinerary: [
        (
          title: 'البصرة القديمة',
          details: 'جولة مشي بين الشناشيل ثم زيارة المتحف.',
        ),
        (
          title: 'العشار والكورنيش',
          details: 'غداء بصري، تسوّق حر وجلسة غروب على الشط.',
        ),
      ],
    ),
    Trip(
      id: 'bekhal-waterfalls',
      title: 'شلالات بيخال',
      location: 'أربيل · شقلاوة',
      category: TripCategory.nature,
      companyId: 'safra-express',
      days: 1,
      dateLabel: 'السبت · 24 تشرين الأول',
      price: 40000,
      rating: '4.8',
      seatsLeft: 15,
      meetingPoint: 'أربيل · قرب القلعة · 7:30 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800&q=80',
      description:
          'يوم في أحضان الطبيعة بين شلالات بيخال وكلي علي بيك ومضيق راوندوز.',
      highlights: ['شلال بيخال', 'شلال كلي علي بيك', 'إطلالة راوندوز'],
      itinerary: [
        (
          title: 'الطريق الجبلي',
          details: 'التحرك عبر شقلاوة مع استراحة إفطار.',
        ),
        (
          title: 'الشلالات',
          details: 'بيخال وكلي علي بيك، غداء على الماء ثم العودة.',
        ),
      ],
    ),
    Trip(
      id: 'dukan-lake',
      title: 'بحيرة دوكان',
      location: 'السليمانية',
      category: TripCategory.nature,
      companyId: 'kurdistan-tourism',
      days: 2,
      dateLabel: 'الجمعة · 23 تشرين الأول',
      price: 75000,
      rating: '4.7',
      seatsLeft: 11,
      meetingPoint: 'السليمانية · مركز المدينة · 8:00 ص',
      imageUrl:
          'https://images.unsplash.com/photo-1439066615861-d1af74d74000?w=800&q=80',
      description: 'يومان على ضفاف بحيرة دوكان مع جولة بالزورق وسهرة شواء.',
      highlights: [
        'جولة زورق في البحيرة',
        'سهرة شواء على الضفاف',
        'إطلالة سد دوكان',
      ],
      itinerary: [
        (
          title: 'البحيرة',
          details: 'الوصول والسكن في الشاليهات، جولة الزورق وسهرة الشواء.',
        ),
        (title: 'السد والعودة', details: 'إفطار، زيارة السد ثم العودة ظهراً.'),
      ],
    ),
  ];

  static const notifications = <AppNotification>[
    AppNotification(
      id: 'n1',
      kind: NotificationKind.reminder,
      title: 'رحلتك تقترب',
      body: 'جولة الأهوار الجنوبية تنطلق يوم الجمعة، لا تنسَ موعد التجمّع.',
      timeLabel: 'قبل ساعتين',
    ),
    AppNotification(
      id: 'n2',
      kind: NotificationKind.offer,
      title: 'خصم على رحلات الشمال',
      body: 'خصم 15% على رحلات أربيل والسليمانية حتى نهاية الأسبوع.',
      timeLabel: 'أمس',
    ),
    AppNotification(
      id: 'n3',
      kind: NotificationKind.general,
      title: 'أهلاً بك في سفره',
      body: 'اكتشف رحلات سياحية داخل العراق واحجز مقعدك بخطوات بسيطة.',
      timeLabel: 'قبل 3 أيام',
      isRead: true,
    ),
  ];
}
