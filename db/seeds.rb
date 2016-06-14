settlements = [
                {:settlement=>"Вінниця", :settlement_type=>"місто", :region=>"Вінницька область", :district=>""},
                {:settlement=>"Абрамівка", :settlement_type=>"село", :region=>"Київська область", :district=>"Вишгородський р-н"},
                {:settlement=>"Абрамівська Долина", :settlement_type=>"село", :region=>"Вінницька область", :district=>"Чернівецький р-н"},
                {:settlement=>"Абрамок", :settlement_type=>"село", :region=>"Житомирська область", :district=>"Новоград-Волинський р-н"},
                {:settlement=>"Дніпропетровськ", :settlement_type=>"місто", :region=>"Дніпропетровська область", :district=>""},
                {:settlement=>"Блакитне", :settlement_type=>"село", :region=>"Запорізька область", :district=>"Оріхівський р-н"},
                {:settlement=>"Блешня", :settlement_type=>"село", :region=>"Чернігівська область", :district=>"Семенівський р-н"},
                {:settlement=>"Блидні", :settlement_type=>"село", :region=>"Хмельницька область", :district=>"Полонський р-н"},
                {:settlement=>"Донецьк", :settlement_type=>"місто", :region=>"Донецька область", :district=>""},
                {:settlement=>"Земляне", :settlement_type=>"село", :region=>"Сумська область", :district=>"Краснопільський р-н"},
                {:settlement=>"Земляний Яр", :settlement_type=>"село", :region=>"Харківська область", :district=>"Вовчанський р-н"},
                {:settlement=>"Земляничне", :settlement_type=>"село", :region=>"АРК", :district=>"Білогірський р-н"},
                {:settlement=>"Хмеьницький", :settlement_type=>"місто", :region=>"Хмельницька область", :district=>""},
                {:settlement=>"Хмельницький", :settlement_type=>"місто", :region=>"Хмельницька область", :district=>""},
                {:settlement=>"Хмельницький", :settlement_type=>"місто", :region=>"Хмельницька область", :district=>""},
                {:settlement=>"Хмельницький", :settlement_type=>"місто", :region=>"Хмельницька область", :district=>""},
                {:settlement=>"Хмельницький", :settlement_type=>"місто", :region=>"Хмельницька область", :district=>""},
                {:settlement=>"Київ", :settlement_type=>"місто", :region=>"Київська область", :district=>""},
                {:settlement=>"Новосвітлівка", :settlement_type=>"село", :region=>"Миколаївська область", :district=>"Веселинівський р-н"},
                {:settlement=>"Новосевастополь", :settlement_type=>"село", :region=>"Миколаївська область", :district=>"Березнегуватський р-н"},
                {:settlement=>"Луганськ", :settlement_type=>"місто", :region=>"Луганська область", :district=>""},
                {:settlement=>"Нетечинці", :settlement_type=>"село", :region=>"Хмельницька область", :district=>"Віньковецький р-н"},
                {:settlement=>"Нетішин", :settlement_type=>"місто", :region=>"Хмельницька область", :district=>"Нетішин"},
                {:settlement=>"Львів", :settlement_type=>"місто", :region=>"Львівська область", :district=>""},
                {:settlement=>"Ященків", :settlement_type=>"село", :region=>"Чернігівська область", :district=>"Варвинський р-н"},
                {:settlement=>"Ящикове", :settlement_type=>"селище міського типу", :region=>"Луганська область", :district=>"Перевальський р-н"},
                {:settlement=>"Ясногірка", :settlement_type=>"селище міського типу", :region=>"Донецька область", :district=>"Краматорськ"},
                {:settlement=>"Одеса", :settlement_type=>"місто", :region=>"Одеська область", :district=>""},
                {:settlement=>"Ясенецьке", :settlement_type=>"селище", :region=>"Вінницька область", :district=>"Липовецький р-н"},
                {:settlement=>"Полтава", :settlement_type=>"місто", :region=>"Полтавська область", :district=>""},
                {:settlement=>"Фастів", :settlement_type=>"місто", :region=>"Київська область", :district=>"Фастівський р-н"},
                {:settlement=>"Усть-Чорна", :settlement_type=>"селище міського типу", :region=>"Закарпатська область", :district=>"Тячівський р-н"},
                {:settlement=>"Ульяновка", :settlement_type=>"місто", :region=>"Кіровоградська область", :district=>"Ульяновський р-н"},
                {:settlement=>"Тячів", :settlement_type=>"місто", :region=>"Закарпатська область", :district=>"Тячівський р-н"},
                {:settlement=>"Сімферополь", :settlement_type=>"місто", :region=>"АРК", :district=>""},
                {:settlement=>"Харків", :settlement_type=>"місто", :region=>"Харківська область", :district=>""},
              ]

RANDOM_TEXT = "Lorem Ipsum - це текст-\"риба\", що використовується в друкарстві та дизайні. Lorem Ipsum є, фактично, стандартною \"рибою\" аж з XVI сторіччя, коли невідомий друкар взяв шрифтову гранку та склав на ній підбірку зразків шрифтів. \"Риба\" не тільки успішно пережила п'ять століть, але й прижилася в електронному верстуванні, залишаючись по суті незмінною. Вона популяризувалась в 60-их роках минулого сторіччя завдяки виданню зразків шрифтів Letraset, які містили уривки з Lorem Ipsum, і вдруге - нещодавно завдяки програмам комп'ютерного верстування на кшталт Aldus Pagemaker, які використовували різні версії Lorem Ipsum."

############Create Categories

  Category.create([{name: 'Гроші', color: '3498db', max: 1000000000}, {name: 'Провізія', color: '2ecc71', max: 500},
                   {name: 'Одяг', color: '1abc9c', max: 500}, {name: 'Медикаменти', color: '9b59b6', max: 500},
                   {name: 'Іграшки', color: '34495e', max: 500}, {name: 'Зброя', color: 'f1c40f', max: 500},
                   {name: 'Екіпірування', color: 'e67e22', max: 500}, {name: 'Апаратура', color: 'e74c3c', max: 500},
                   {name: 'Освіта', color: '7D1424', max: 5000}, {name: 'Транспорт', color: '5B4B27', max: 50},
                   {name: 'Беспосередня участь', color: 'E6567A', max: 50}, {name: 'Донорство', color: '48AD01', max: 500},
                   {name: 'Побут', color: 'FF6861', max: 500}
                  ])
#############

###############Create Users
  settlement = settlements[Random.rand(settlements.size)]
  user = User.new(
      :name                  => "Адмін",
      :email                 => "first@admin.com",
      :role                  => "admin",
      :skype                 => "skype_admin",
      :phone                 => "+380967861621",
      :avatar_file_name      => "avatar.jpg",
      :info                  => "Помощь бойцам, которые на фронте. Обмундирование, термобелье, аптечки, питание…Поездки на фронт с гум.помощью для: детских домов, госпиталям, бойцам, гражданским…Помощь, консультации семьям бойцов. Пишите на ФБ или e-mail.",
      :password              => "12345678",
      :password_confirmation => "12345678",
      :settlement            => settlement[:settlement],
      :settlement_type       => settlement[:settlement_type],
      :region                => settlement[:region],
      :district              => settlement[:district]

  )
  user.skip_confirmation!
  user.save!

  settlement = settlements[Random.rand(settlements.size)]
  user = User.new(
      :name                  => "Модератор",
      :email                 => "second@admin.com",
      :role                  => "moderator",
      :phone                 => "0984335353",
      :avatar_file_name      => "avatar.jpg",
      :info                  => "Харьковский активист и волонтер. Помогает армии и Нацгвардии, старается доставить то, что заказывают бойцы.",
      :password              => "12345678",
      :password_confirmation => "12345678",
      :settlement            => settlement[:settlement],
      :settlement_type       => settlement[:settlement_type],
      :region                => settlement[:region],
      :district              => settlement[:district]
  )
  user.skip_confirmation!
  user.save!

  settlement = settlements[Random.rand(settlements.size)]
  user = User.new(
      :name                  => "Благодійний фонд \"За Україну\"",
      :email                 => "third@admin.com",
      :role                  => "newsmaker",
      :skype                 => "heaven_pleasure443",
      :phone                 => "+380952455359",
      :avatar_file_name      => "avatar.jpg",
      :info                  => "Благодійний Фонд “За Україну” створено у 2014 р.. У важкий для країни час фонд долучився до активної допомоги українським військовим, солдатам Збройних сил України, Національної гвардії, які приймають участь у антитерористичній операції на Сході України. Також Фонд надає допомогу у лікуванні та реабілітації поранених солдатів АТО, допомагає родинам, в яких залишились неповнолітні діти, батько яких загинув під час бойових дій. На даний момент ці напрямки стали пріоритетними у роботі Фонду.",
      :password              => "12345678",
      :password_confirmation => "12345678",
      :settlement            => settlement[:settlement],
      :settlement_type       => settlement[:settlement_type],
      :region                => settlement[:region],
      :district              => settlement[:district]
  )
  user.skip_confirmation!
  user.save!

  settlement = settlements[Random.rand(settlements.size)]
  user = User.new(
      :name                  => "Богуш Олександр Станіславович",
      :email                 => "fourth@admin.com",
      :role                  => "banned",
      :avatar_file_name      => "avatar.jpg",
      :info                  => "Група волонтерів, яка розпочала свою діяльність з вироблення бастіонів по типу HESCO.
                                  Після чого розробила та створила дистанційно-керовані модулі “Шабля”, які дозволяють військовому знаходитися у безпечному для життя місці та вести спостереження за територією, та відповідати на вогонь сєпаратистів, без загрози для життя військового.",
      :password              => "12345678",
      :password_confirmation => "12345678",
      :settlement            => settlement[:settlement],
      :settlement_type       => settlement[:settlement_type],
      :region                => settlement[:region],
      :district              => settlement[:district]
  )
  user.skip_confirmation!
  user.save!

  settlement = settlements[Random.rand(settlements.size)]
  user = User.new(
      :name                  => "Немирний Артем Леонідович",
      :email                 => "fifth@admin.com",
      :avatar_file_name      => "avatar.jpg",
      :info                  => "Допомога спорядженням, побутовими речами, грішми, технікою.",
      :password              => "12345678",
      :password_confirmation => "12345678",
      :settlement            => settlement[:settlement],
      :settlement_type       => settlement[:settlement_type],
      :region                => settlement[:region],
      :district              => settlement[:district]
  )
  user.skip_confirmation!
  user.save!

  25.times do |x|
    settlement = settlements[Random.rand(settlements.size)]
    user = User.new(
        :name                  => "Користувач_#{x}",
        :email                 => "#{x}_user@user.com",
        :skype                 => "#{x}_user_skype",
        :phone                 => "+38096#{Random.rand(10000000)}",
        :avatar_file_name      => "avatar.jpg",
        :info                  => BetterLorem.p(1, true, true ),
        :password              => "12345678",
        :password_confirmation => "12345678",
        :settlement            => settlement[:settlement],
        :settlement_type       => settlement[:settlement_type],
        :region                => settlement[:region],
        :district              => settlement[:district]
    )
    user.skip_confirmation!
    user.save!
  end

###################

#############Create Requests

  (6..30).each do |i|
    Random.rand(6).times.each do
      status = case Random.rand(4)
               when 0 then :archived
               when 1 then :actual
               when 2 then :unchecked
               when 3 then :declined
               end

      temp = Random.rand(9)
      categories = (1..Random.rand(1..5)).map do |x|
        rand = (temp + x != 1)? Random.rand(1..50) : Random.rand(100..20000)
        remaining = (temp + x != 1)? Random.rand(1..50) : Random.rand(100..20000)
        { current_count: rand, goal_count: rand + remaining, category_id:  temp + x }
      end

      User.find(i).requests.create(
        name: "#{BetterLorem.w(15, true, true)}",
        description: BetterLorem.p(7, true, true ),
        status: status,
        :photo_file_name => Random.rand(2) == 0 ? 'photo.jpg' : nil,
        required_items_attributes: categories
      )
      User.find(i).requests.each do |request|
        request.create_activity key: 'request.create', owner: request.user
        case request.status
        when 'actual'
          request.create_activity key: 'request.check', status: 'new', owner: request.user
        when 'declined'
          request.create_activity key: 'request.decline', status: 'new', owner: request.user
        when 'archived'
          request.create_activity key: 'request.check', status: 'new', owner: request.user
          request.create_activity key: 'request.archive', owner: request.user
        end
      end
    end
  end

  User.first.requests.create(
    :name => 'Потрібна допомога: У харківський госпіталь привезли 40 поранених бійців, медики та волонтери не встигають',
    :description => "Зранку, 12 січня, стало відомо про те, що у військовий госпіталь Харкова надійшло 40 тяжко поранених українських військових. Про це йдеться у повідомленні волонтерів з групи «Сестри милосердя АТО/Харків», передають Патріоти України.
      Через наплив поранених бійців волонтери не встигають надавати адресну допомогу усім, хто цього потребує. До того ж у госпіталі медики не можуть самотужки забезпечити усіх хворих необхідним, потрібним доглядом в тому числі.
      «ГОСПІТАЛЬ ХАРКІВ!!!! Станом на 5 ранку 11 січня 2016 р. Надійшло 40 осіб - є важкі в реанімації, палатах інтенсивної терапії. В травматології багато народу на милицях і лежачих», - йдеться у повідомленні спільноти у соціальній мережі.",
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 4, current_count: 0, goal_count: 5},
        {category_id: 8, current_count: 2, goal_count: 2},
        {category_id: 11, current_count: 5, goal_count: 15}
    ]
  )
  User.first.requests.last.create_activity key: 'request.create', owner: User.first

  User.first.requests.create(
    :name => 'Спецкор: у Маріуполі загонам ВСУ вже потрібна допомога волонтерів',
    :description => "«Вчора з другої години дня збиралися підписи на знак протесту, і тепер всі ці підписи будуть направлені разом із листом президенту України Петру Порошенку. На 2 серпня вже призначений великий мітинг. Можна сказати, що ті, хто підписався сьогодні, там будуть точно. Тобто це мінімум 200 осіб. Також поставили ще один намет, додаткові прапори, наметове містечко потихеньку розростається.
      Крім тих, хто проти, є і люди, які позитивно дивляться на ротацію. Військові залишилися, а все важке озброєння було відведено. За словами Ярослава Чепурнова, прес-офіцера сектора М, вже сьогодні вивели всі батальйони з Широкино, їх місце зайняли морські піхотинці. Цікаво, що морська піхота, як говорив президент України, повністю обмундирована від А до Я, це кращі бійці і самі забезпечені війська нашої країни. Але вже вчора волонтери кидали клич на Facebook про те, що нашим морським котикам потрібні шкарпетки, ліхтарики, труси, генератори і так далі, тобто предмети першої необхідності.
      Всі чекають 2 серпня, щоб прийти на великий мітинг. До нього йде повномасштабна підготовка. Вчора було кілька конфліктів прихильників і супротивників відводу добровольців з Широкиного. Звучали і мати, але бійок не було. Сьогодні прийшла, наскільки я знаю, поки тільки одна людина, яка проти цієї мирної акції, але ніякого відкритого невдоволення вона не висловлювала.
      Біля наметів регулярно перебувають до 30 осіб. Прості жителі просто проходять повз, дізнаються про ситуацію, в чому причина, деякі на знак згоди ставлять свій підпис. Хтось бере плакати, вони також підтримують повністю цей мітинг.",
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 1, current_count: 500, goal_count: 8000},
        {category_id: 3, current_count: 2, goal_count: 4},
        {category_id: 6, current_count: 15, goal_count: 21},
        {category_id: 7, current_count: 1, goal_count: 7}
    ]
  )
  User.first.requests.last.create_activity key: 'request.create', owner: User.first

  User.second.requests.create(
    :name => 'Луцьк: волонтеру терміново потрібна допомога',
    :description => "Волонтер міжнародного фонду «Милосердні руки» Анатолій наразі перебуває у Волинській обласній лікарні і терміново потребує грошей для лікування.
       Про це у соціальній мережі Facebook написала волонтерка Марина Бляшук.
       За інформацією Теліпського, Анатолій, будучи інвалідом 2-ї групи допомагав на Схід України, але з 6 липня 2015 року перебуває в обласній лікарні. Він переніс гість операцій, але лежить знову розрізаний, так як пошкоджений кишківник не зростається.
       На лікування вже пішло більше 100 ста тисяч гривень і, за прогнозами лікарі,в може піти ще 150-200 тисяч.
       Терміново потрібні шість донорів будь-якої групи крові.
       “За детальною інформацією звертатися по тел. 050 152 11 17 до Володимира або 099 327 03 07 (зазвичай, слухавку бере мама Анатолія – Марія Йосипівна…. вона постійно сидить поряд з сином у лікарні)”, – йдеться у повідомленні.",
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 3, current_count: 2, goal_count: 15},
        {category_id: 4, current_count: 9, goal_count: 10},
        {category_id: 12, current_count: 4, goal_count: 10}
    ]
  )
  User.second.requests.last.create_activity key: 'request.create', owner: User.second

  User.third.requests.create(
     :name => 'Загону №3 з Харківського батальону потрібна допомога.',
     :description => "Поки держава, фактично з нуля відбудовували наші Збройні сили, саме ті патріоти, які з першого до останнього дня пройшли Майдан, першими пішли на фронт захищати Україну.
        Першими був батальйон на базі 1-го та 2-го резервних батальйонів Національної гвардії, який пізніше отримав ім'я генерала-героя Кульчицького. Саме батальйон імені Кульчицького взяв на себе перший і найважчий удар, і, безумовно, втрат серед перших було більше.
        Згідно з інформацією на сторінці підрозділу в соцмережі Facebook, за час боїв в Донбасі батальйон втратив 23 людини, 76 бійців були поранені.
        Потрібні 3 мішки шкарпеток, 10 бронежилетів та провізія. Допоможіть хто чим може, дякуємо.",
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
         {category_id: 1, current_count: 900, goal_count: 2000},
         {category_id: 2, current_count: 2, goal_count: 2},
         {category_id: 7, current_count: 3, goal_count: 6}
     ]
  )
  User.third.requests.last.create_activity key: 'request.create', owner: User.third

  User.third.requests.create(
     :name => 'Друзья : волонтёры , военнослужащие , дембеля !',
     :description => "Большая просьба ко всем этим категориям !
        Если у кого из Вас есть или знаете у кого есть :
        -Неисправный тепловизор
        -Запчасти от тепловизора
        -Детали от тепловизора
        -В хлам разбитый тепловизор или даже его останки
        ОГРОМНАЯ ПРОСЬБА
        Приносите или передавайте всё это Андрею на Кардачи , всё это можно отремонтировать , использовать как запчасть или на запчасть , таким образом Вы поможете своим побратимам на фронте ''ночными глазами '' !!!
        Это очень важно во время т.н. ''перемирья'' и спасёт много жизней !!!
        Ну нахрена Вам весь этот хлам ?! Отдайте , помогите братьям побыстрей ''прозреть'' !!!
        Перепост крайне приветствуется !!!",
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
        {category_id: 7, current_count: 1, goal_count: 10}
     ]
  )
  User.third.requests.last.create_activity key: 'request.create', owner: User.third

  User.third.requests.create(
     :name => 'Вельмишановні! Хто найближчого часу іде в Маріуполь?',
     :description => "Вельмишановні! Хто найближчого часу іде в Маріуполь, і у нього є ще трошки вільного місця, будь ласочка прихопить 2 мішки подарунків для хлопців. Підробиці в лічку.",
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
        {category_id: 10, current_count: 8, goal_count: 10}
     ]
  )
  User.third.requests.last.create_activity key: 'request.create', owner: User.third

  User.third.requests.create(
     :name => 'Потрібна допомога волонтерів!',
     :description => "95 аеромобілна бригада \"рота розвідників\". Потребує допомогу. Їм потрібен спец. одяг.
        Будь ласка допоможіть!",
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
         {category_id: 1, current_count: 1000, goal_count: 25000},
         {category_id: 7, current_count: 5, goal_count: 7}
     ]
  )
  User.third.requests.last.create_activity key: 'request.create', owner: User.third

  User.third.requests.create(
     :name => 'Просимо допомогти зібрати кошти на лікування Максима Лободюка.',
     :description => "Лободюк Максим Віталійович, 2015 року народження, тяжко хворіє, йому був поставлений діагноз: Гемофілія А, тяжкий перебіг. Дитина перебувала на профілактичному лікуванні у рамках Швейцарської програми з травня 2014р.
        Через чотири місяці після початку лікування розвинувся інгібітор до РУНІ (вересень 2014р. ) з титром 12,8 БО/мл., (квітень 2015 р.) титр 7,9 БО/мл. Від вересня 2014 року по сьогодні хлопчик не має можливості на нормальне існування, оскільки держава не виділяє необхідних препаратів (Новосевен), які б допомогли дитині жити нормально, а саме головне, як наслідок нелікування стати інвалідом.
        На жаль, сім'я не має достатнього фінансово-матеріального забезпечення, щоб купити необхідні препарати для лікування сина, адже щомісячний дохід сім'ї складає 3200 грн, включаючи кошти, які приходять на дитину, тому мати звернулась до Благодійного фонду «Сучасне село та місто» з проханням допомогти зібрати кошти на лікування.
        Ціна одного флакону препарату Новосевен (2мг) - 42 000 гривень (звичайний поріз чи синяк через хвилини може перетворитися на величезну гематому, а для зупинки однієї такої кровотечі потрібно від 3 до 10 флаконів препарату Новосевен (2мг). На місяць в середньому потрібно до 50 флаконів такого препарату!
        Просимо допомогти придбати необхідні ліки:
        Карта Приват Банку мами 5168 7572 9873 9501
        Віримо, що спільними зусиллями, та завдяки вашій небайдужості та підтримці дитина зможе отримати необхідну допомогу.
        Директор благодійної організації Благодійний фонд «Сучасне село та місто» Євгеній Клімов",
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
         {category_id: 4, current_count: 2, goal_count: 10},
         {category_id: 3, current_count: 2, goal_count: 2}
     ]
  )
  User.third.requests.last.create_activity key: 'request.create', owner: User.third

  User.fourth.requests.create(
    :name => 'Потрібна допомога: У харківський госпіталь привезли 40 поранених бійців, медики та волонтери не встигають',
    :description => "Зранку, 12 січня, стало відомо про те, що у військовий госпіталь Харкова надійшло 40 тяжко поранених українських військових. Про це йдеться у повідомленні волонтерів з групи «Сестри милосердя АТО/Харків», передають Патріоти України.
      Через наплив поранених бійців волонтери не встигають надавати адресну допомогу усім, хто цього потребує. До того ж у госпіталі медики не можуть самотужки забезпечити усіх хворих необхідним, потрібним доглядом в тому числі.
      «ГОСПІТАЛЬ ХАРКІВ!!!! Станом на 5 ранку 11 січня 2016 р. Надійшло 40 осіб - є важкі в реанімації, палатах інтенсивної терапії. В травматології багато народу на милицях і лежачих», - йдеться у повідомленні спільноти у соціальній мережі.",
    :status => 'declined',
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 4, current_count: 10, goal_count: 10},
        {category_id: 8, current_count: 5, goal_count: 20},
        {category_id: 11, current_count: 3, goal_count: 9}
    ]
  )
  User.fourth.requests.last.create_activity key: 'request.create', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.decline', status: 'new', owner: User.fourth


  User.fourth.requests.create(
    :name => 'Спецкор: у Маріуполі загонам ВСУ вже потрібна допомога волонтерів',
    :description => "«Вчора з другої години дня збиралися підписи на знак протесту, і тепер всі ці підписи будуть направлені разом із листом президенту України Петру Порошенку. На 2 серпня вже призначений великий мітинг. Можна сказати, що ті, хто підписався сьогодні, там будуть точно. Тобто це мінімум 200 осіб. Також поставили ще один намет, додаткові прапори, наметове містечко потихеньку розростається.
      Крім тих, хто проти, є і люди, які позитивно дивляться на ротацію. Військові залишилися, а все важке озброєння було відведено. За словами Ярослава Чепурнова, прес-офіцера сектора М, вже сьогодні вивели всі батальйони з Широкино, їх місце зайняли морські піхотинці. Цікаво, що морська піхота, як говорив президент України, повністю обмундирована від А до Я, це кращі бійці і самі забезпечені війська нашої країни. Але вже вчора волонтери кидали клич на Facebook про те, що нашим морським котикам потрібні шкарпетки, ліхтарики, труси, генератори і так далі, тобто предмети першої необхідності.
      Всі чекають 2 серпня, щоб прийти на великий мітинг. До нього йде повномасштабна підготовка. Вчора було кілька конфліктів прихильників і супротивників відводу добровольців з Широкиного. Звучали і мати, але бійок не було. Сьогодні прийшла, наскільки я знаю, поки тільки одна людина, яка проти цієї мирної акції, але ніякого відкритого невдоволення вона не висловлювала.
      Біля наметів регулярно перебувають до 30 осіб. Прості жителі просто проходять повз, дізнаються про ситуацію, в чому причина, деякі на знак згоди ставлять свій підпис. Хтось бере плакати, вони також підтримують повністю цей мітинг.",
    :status => 'declined',
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 1, current_count: 14560, goal_count: 20000},
        {category_id: 3, current_count: 0, goal_count: 2},
        {category_id: 6, current_count: 0, goal_count: 8},
        {category_id: 7, current_count: 10, goal_count: 15}
    ]
  )
  User.fourth.requests.last.create_activity key: 'request.create', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.decline', status: 'new', owner: User.fourth

  User.fourth.requests.create(
    :name => 'Луцьк: волонтеру терміново потрібна допомога',
    :description => "Волонтер міжнародного фонду «Милосердні руки» Анатолій наразі перебуває у Волинській обласній лікарні і терміново потребує грошей для лікування.
      Про це у соціальній мережі Facebook написала волонтерка Марина Бляшук.
      За інформацією Теліпського, Анатолій, будучи інвалідом 2-ї групи допомагав на Схід України, але з 6 липня 2015 року перебуває в обласній лікарні. Він переніс гість операцій, але лежить знову розрізаний, так як пошкоджений кишківник не зростається.
      На лікування вже пішло більше 100 ста тисяч гривень і, за прогнозами лікарі,в може піти ще 150-200 тисяч.
      Терміново потрібні шість донорів будь-якої групи крові.
      “За детальною інформацією звертатися по тел. 050 152 11 17 до Володимира або 099 327 03 07 (зазвичай, слухавку бере мама Анатолія – Марія Йосипівна…. вона постійно сидить поряд з сином у лікарні)”, – йдеться у повідомленні.",
    :status => 'declined',
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 3, current_count: 25, goal_count: 27},
        {category_id: 4, current_count: 2, goal_count: 5},
        {category_id: 12, current_count: 3, goal_count: 4}
    ]
  )
  User.fourth.requests.last.create_activity key: 'request.create', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.decline', status: 'new', owner: User.fourth

  User.fourth.requests.create(
     :name => 'Загону №3 з Харківського батальону потрібна допомога.',
     :description => "Поки держава, фактично з нуля відбудовували наші Збройні сили, саме ті патріоти, які з першого до останнього дня пройшли Майдан, першими пішли на фронт захищати Україну.
        Першими був батальйон на базі 1-го та 2-го резервних батальйонів Національної гвардії, який пізніше отримав ім'я генерала-героя Кульчицького. Саме батальйон імені Кульчицького взяв на себе перший і найважчий удар, і, безумовно, втрат серед перших було більше.
        Згідно з інформацією на сторінці підрозділу в соцмережі Facebook, за час боїв в Донбасі батальйон втратив 23 людини, 76 бійців були поранені.
        Потрібні 3 мішки шкарпеток, 10 бронежилетів та провізія. Допоможіть хто чим може, дякуємо.",
     :status => 'declined',
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
         {category_id: 1, current_count: 1000, goal_count: 2000},
         {category_id: 2, current_count: 2, goal_count: 3},
         {category_id: 7, current_count: 3, goal_count: 4}
     ]
  )
  User.fourth.requests.last.create_activity key: 'request.create', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.decline', status: 'new', owner: User.fourth

  User.fourth.requests.create(
     :name => 'Друзья : волонтёры , военнослужащие , дембеля !',
     :description => "Большая просьба ко всем этим категориям !
        Если у кого из Вас есть или знаете у кого есть :
        -Неисправный тепловизор
        -Запчасти от тепловизора
        -Детали от тепловизора
        -В хлам разбитый тепловизор или даже его останки
        ОГРОМНАЯ ПРОСЬБА
        Приносите или передавайте всё это Андрею на Кардачи , всё это можно отремонтировать , использовать как запчасть или на запчасть , таким образом Вы поможете своим побратимам на фронте ''ночными глазами '' !!!
        Это очень важно во время т.н. ''перемирья'' и спасёт много жизней !!!
        Ну нахрена Вам весь этот хлам ?! Отдайте , помогите братьям побыстрей ''прозреть'' !!!
        Перепост крайне приветствуется !!!",
     :status => 'declined',
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
        {category_id: 7, current_count: 11, goal_count: 33}
     ]
  )
  User.fourth.requests.last.create_activity key: 'request.create', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.decline', status: 'new', owner: User.fourth

  User.fourth.requests.create(
     :name => 'Вельмишановні! Хто найближчого часу іде в Маріуполь?',
     :description => "Вельмишановні! Хто найближчого часу іде в Маріуполь, і у нього є ще трошки вільного місця, будь ласочка прихопить 2 мішки подарунків для хлопців. Підробиці в лічку.",
     :status => 'archive',
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
        {category_id: 10, current_count: 35, goal_count: 50}
     ]
  )
  User.fourth.requests.last.create_activity key: 'request.create', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.check', status: 'new', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.archive', owner: User.fourth

  User.fourth.requests.create(
     :name => 'Потрібна допомога волонтерів!',
     :description => "95 аеромобілна бригада \"рота розвідників\". Потребує допомогу. Їм потрібен спец. одяг.
        Будь ласка допоможіть!",
     :status => 'archive',
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
         {category_id: 1, current_count: 1100, goal_count: 1150},
         {category_id: 7, current_count: 2, goal_count: 4}
     ]
  )
  User.fourth.requests.last.create_activity key: 'request.create', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.check', status: 'new', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.archive', owner: User.fourth

  User.fourth.requests.create(
     :name => 'Просимо допомогти зібрати кошти на лікування Максима Лободюка.',
     :description => "Лободюк Максим Віталійович, 2015 року народження, тяжко хворіє, йому був поставлений діагноз: Гемофілія А, тяжкий перебіг. Дитина перебувала на профілактичному лікуванні у рамках Швейцарської програми з травня 2014р.
        Через чотири місяці після початку лікування розвинувся інгібітор до РУНІ (вересень 2014р. ) з титром 12,8 БО/мл., (квітень 2015 р.) титр 7,9 БО/мл. Від вересня 2014 року по сьогодні хлопчик не має можливості на нормальне існування, оскільки держава не виділяє необхідних препаратів (Новосевен), які б допомогли дитині жити нормально, а саме головне, як наслідок нелікування стати інвалідом.
        На жаль, сім'я не має достатнього фінансово-матеріального забезпечення, щоб купити необхідні препарати для лікування сина, адже щомісячний дохід сім'ї складає 3200 грн, включаючи кошти, які приходять на дитину, тому мати звернулась до Благодійного фонду «Сучасне село та місто» з проханням допомогти зібрати кошти на лікування.
        Ціна одного флакону препарату Новосевен (2мг) - 42 000 гривень (звичайний поріз чи синяк через хвилини може перетворитися на величезну гематому, а для зупинки однієї такої кровотечі потрібно від 3 до 10 флаконів препарату Новосевен (2мг). На місяць в середньому потрібно до 50 флаконів такого препарату!
        Просимо допомогти придбати необхідні ліки:
        Карта Приват Банку мами 5168 7572 9873 9501
        Віримо, що спільними зусиллями, та завдяки вашій небайдужості та підтримці дитина зможе отримати необхідну допомогу.
        Директор благодійної організації Благодійний фонд «Сучасне село та місто» Євгеній Клімов",
     :status => 'archive',
     :photo_file_name => "photo.jpg",
     required_items_attributes: [
         {category_id: 4, current_count: 1, goal_count: 5},
         {category_id: 3, current_count: 1, goal_count: 10}
     ]
  )
  User.fourth.requests.last.create_activity key: 'request.create', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.check', status: 'new', owner: User.fourth
  User.fourth.requests.last.create_activity key: 'request.archive', owner: User.fourth

  User.fifth.requests.create(
    :name => 'Потрібна допомога: У харківський госпіталь привезли 40 поранених бійців, медики та волонтери не встигають',
    :description => "У 3-го Кіровоградського полку спеціального призначення є необхідність в наступних речах:
      ​​1. Берці демісезонні(-belle wille або wellco розмір 42 -44)
      ​42 розмір 10 пар
      43 розмір 12 пар
      44 розмір 6 пар
      45 розмір 5 пар​
      ​​2. Аптечки стандарту НАТО​ – 50 шт.
      ​​3. Тактичні окуляри-ESS – ​70 шт.
      4. Тактичні рукавички ( mechanix) – ​70 пар.
      5. Форма (Гірка 4, GOR-TEX (MTP, woodland) – ​Розміри від М до ХХХL
      6. 3-х точкові ремені для АКС
      7. Наколінникі – ​70 пар.
      8. Ремінно-плечові системи ​- 35​
      9. Бронежилети або плити (6 клас) -​ 35
      10.​ ​Радіостанціі + гарнітури (портативні та автомобільні Hytera) -​ 10​
      11. Дискові магазини, для патронів калібру 5,45. – 60шт.",
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 1, current_count: 13000, goal_count: 35000},
        {category_id: 3, current_count: 1, goal_count: 2},
        {category_id: 4, current_count: 3, goal_count: 4},
        {category_id: 7, current_count: 5, goal_count: 6},
        {category_id: 8, current_count: 7, goal_count: 8}
    ]
  )

  User.fifth.requests.create(
    :name => 'Потребуємо допомоги',
    :description => "Нашим військовим дуже потрібна фарба маскувальних кольорів (хакі, оливкова, зелена) для фарбування техніки.
      Зараз як ніколи актуально зробити військову техніку непомітною для ворога. Будь ласка, допоможіть фарбою або коштами на її придбання.
      Наша допомога дуже важлива для бійців.",
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 3, current_count: 5, goal_count: 20},
        {category_id: 13, current_count: 2, goal_count: 50}
    ]
  )
  User.fifth.requests.last.create_activity key: 'request.create', owner: User.fifth

  User.fifth.requests.create(
    :name => 'УВАГА! ВОЛОНТЕРИ!',
    :description => "В понеділок 9 березня  запрошуємо волонтерів долучитись до виробництва хімічних термопакетів “ПТН ПХ”.
      Всі бажаючі попрацювати для фронту можуть приходити до офісу “Української Жіночої Варти” за адресою м.Шулявка, вул..О.Довженка, 14/1
      Приходьте, будь ласка! Хлопцям на фронті дуже потрібно тепло!
      Виробничий процес розпочнеться: 09 березня 2015 року в 11:00
      Якщо є можливість попереджайте, будь ласка, заздалегідь коли ви можете прийти та на який час.",
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 11, current_count: 7, goal_count: 10}
    ]
  )
  User.fifth.requests.last.create_activity key: 'request.create', owner: User.fifth

  User.fifth.requests.create(
    :name => 'Терміново потрібна допомога у облаштуванні 12 казарми учбового центру «Десна»',
    :description => "Терміново потрібна допомога у облаштуванні 12 казарми учбового центру «Десна», куди повернулися на ротацію бійці 25-го батальйону «Київська Русь». Умови жахливі, їх просто немає. 14 січня до казарми повернуться 300 бійців, яким фактично ніде спати. Маємо встигнути до тих пір по максимуму!
      Передмова: ми зустріли героїв у «Десні». Героїв, що 4 місяці тримали Дебальцеве – апендикс нашої землі, вклинений у гущу сепаратизму. Зустріли душевно, та без особливих почестей. Тому що «генштаб дав наказ не пускати нікого на територію частини».
      Пізніше ми таки потрапили у славетну 12 казарму, де розмістили без перебільшення героїв (яких представили, до речі, до нагород – і дуже не до речі вони їх не отримали). Казарма збудована близько 1960 року і з тих пір там не було й духу ремонту.
      Влітку, коли батальйон лише формувався, казарма виглядала майже так само. З усіх туалетів працювали 2 (ДВА!), та й ті до обіду. Та одна справа – потрапити в такі умови влітку, на навчання, і зовсім інше – повернутися на «відпочинок» з війни. Відпочинок на підлозі, у спальнику, який передали волонтери ще в Дебальцевому.
      Що на сьогодні необхідно?
      Звернення до відповідальних за це жахіття у Міноборони. Закріплення 12 казарми за 25-м батальйоном у якості місця постійної дислокації. Це мали зробити ще при формуванні батальйону. І це дасть змогу нам контролювати стан казарми у майбутньому і стежити за цілістю майна. Дякуючи ГО «Українська Жіноча Варта», Олені та Олександру Білецьким ця справа зрушилася з мертвої точки.
      Звернення до меценатів. Будьмо реалістами, швидко наше керівництво вміє тільки красти. З найнеобхіднішого (це окрім ремонту) у казармах потрібні: ліжка, матраци, подушки, сантехніка (раковини, змішувачі для умивальників та душів), вікна. Якщо ви виробляєте або реалізуєте щось із цієї продукції – ви матимете найкращу рекламу з усіх можливих. Всі медіа говоритимуть про вашу допомогу.
      Як зробити, щоб все це не осіло в звітах та кишенях керівництва? Гравірування (штампи) на видному місці продукції. Щось на кшталт «Не для продажу! Подарунок від волонтерів» абощо. Прозора звітніть. Підписання керівництвом «Десни» документів про прийняття мат.забезпечення у якості благодійної допомоги. З можливістю перевірки наявності та справності у майбутньому. Простими словами: щоб даючи частині 500 ліжок ми змогли приїхати через місяць/півроку і порахувати їх. Звичайно, з висвітленням цього факту у ЗМІ. Якщо не дорахуємося – висвітлимо навіть з більшим ентузіазмом.
      Волонтерська допомога. Руками, часом та фінансами. Руками: утеплити вікна (поролон + скотч), у деякі – вставити скло (зараз закрито клейонкою), змайструвати душові кабіни. Фінансами: на динамічні водонагрівачі (бойлери не потягне мережа казарми), баки для душів, електрику (стабілізатори напруження, кабель тощо).",
    :photo_file_name => "photo.jpg",
    required_items_attributes: [
        {category_id: 1, current_count: 220, goal_count: 875},
        {category_id: 2, current_count: 3, goal_count: 19},
        {category_id: 3, current_count: 5, goal_count: 21},
        {category_id: 7, current_count: 3, goal_count: 6},
        {category_id: 11, current_count: 1, goal_count: 2},
        {category_id: 13, current_count: 20, goal_count: 25}
    ]
  )
  User.fifth.requests.last.create_activity key: 'request.create', owner: User.fifth

####################

################Create HelpedItems

  User.all.each do |usr|
    temp = Random.rand(8)
    usr.helped_items.create((1..Random.rand(1..6)).map do |x|
                               {
                                   category_id: temp + x,
                                   count: (temp + x) != 1 ? Random.rand(1..50) : Random.rand(100..20000)
                               }
                             end
    )
  end

#######################

################Create Decisions

  User.all.each do |usr|
    usr.requests.each do |request|
      decisions = Array.new
      (Random.rand(1..3)).times do
        helper_id = nil
        catch (:found) do
          loop do
            helper_id = Random.rand(1..29)
            throw :found unless usr.id == helper_id || decisions.map{|value| value[:helper_id] }.include?(helper_id)
          end
        end

        accepted_items = Array.new
        Random.rand(1..request.required_items.size).times do
          required_item_id = nil
          catch (:found) do
            loop do
              required_item_id = request.required_items.offset(Random.rand(request.required_items.size)).first.id
              throw :found unless accepted_items.map{|value| value[:required_item_id] }.include?(required_item_id)
            end
          end
          accepted_items << {required_item_id: required_item_id, count: Random.rand(0..RequiredItem.find(required_item_id).remaining_count)}
        end

        decisions << {
            helper_id: helper_id,
            description: BetterLorem.p(3, true, true ),
            status: Random.rand(2) == 0 ? 'unaccepted' : 'new',
            accepted_items_attributes: accepted_items
        }

      end
      request.decisions.create(decisions)

      # request.decisions.each do |decision|
      #   decision.create_activity recipient: request, status: 'new', parameters: { helper_id: request.user.id }, key: 'decision.create', owner: decision.helper
      # end
    end
  end

################

Message.create([
    { body: 'What is that, my friend?', sender: User.fourth, receiver: User.first },
    { body: 'We have what we have, comrad!', receiver: User.fourth, sender: User.first }
])