import 'dart:io';

import 'api_docs.dart';
import 'legal.dart';

/// Génère le site vitrine (www/fr, www/ua, www/en) à partir des textes
/// ci-dessous, et les pages légales (…/terms/, …/privacy/, textes dans
/// legal.dart) :  dart tool/build.dart  (depuis le dossier site/).
///
/// Une page par langue ; la page d'accueil « / » envoie vers la langue du
/// navigateur (règle dans deploy/staff-flow.cloud.caddy).
const site = 'https://staff-flow.cloud';
const app = 'https://app.staff-flow.cloud';
const langs = ['fr', 'uk', 'en'];

/// Captures : une série par langue (www/img/fr, uk, en).
const shots = ['1-planning', '2-service', '3-actualites', '4-demandes', '5-management'];
String shotDir(String l) => l;

/// Adresse de chaque langue : le pays pour l'Ukraine (UA ; « UK » serait le Royaume-Uni).
String slug(String l) => l == 'uk' ? 'ua' : l;

/// Libellé du choix de langue.
String label(String l) => slug(l).toUpperCase();

final t = <String, Map<String, Object>>{
  'fr': {
    'name': 'Français',
    'title': 'Staff Flow – Le planning de votre équipe, simple et sur mobile',
    'desc': 'Créez et partagez le planning de vos salariés en quelques secondes. Échanges, congés, annonces, consultable même sans réseau. Dès 3 € par mois, gratuit pour les salariés.',
    'open': 'Ouvrir l\'application',
    'pill': 'Planning d\'équipe · Android et navigateur',
    'h1': 'Le planning de votre équipe, <em>enfin simple</em>.',
    'lead': 'Créez les horaires en quelques gestes, publiez-les, et chacun les reçoit sur son téléphone. Échanges de service, congés et annonces : tout au même endroit.',
    'start': 'Essayer gratuitement',
    'how': 'Comment ça marche',
    'checks': ['2 jours d\'essai complet', 'Gratuit pour les salariés', 'Consultable même sans réseau'],
    'featH': 'Tout ce qu\'il faut, rien de compliqué',
    'featSub': 'De la petite équipe de quelques salariés à la grande entreprise aux nombreux sites et responsables : Staff Flow s\'adapte à votre taille, dans tous les secteurs qui travaillent en horaires.',
    'feats': [
      ['🗓️', 'Un planning en quelques secondes', 'Préréglages « Matin », « Soir », répétition chaque jour ou chaque semaine, brouillon puis publication en un geste.'],
      ['🔁', 'Échanges et congés', 'Un salarié propose son service à un collègue, demande un congé ou une indisponibilité ; vous validez d\'un tap.'],
      ['📣', 'Fil d\'actualités', 'Le patron et les responsables publient des annonces pour tous, un poste, un site ou des personnes choisies ; chacun les traduit dans sa langue.'],
      ['📶', 'Même sans réseau', 'Sans connexion, le planning reste affiché et vous pouvez continuer à le préparer ou demander un congé : c\'est gardé sur le téléphone et envoyé à l\'équipe dès que le réseau revient.'],
      ['🏢', 'Plusieurs sites et entreprises', 'Sites en cascade, responsables par site, salariés importés depuis Excel, et un onglet par entreprise pour qui travaille à plusieurs endroits.'],
      ['🌍', '10 langues', 'Chacun utilise l\'application dans sa langue : français, ukrainien, anglais (américain ou britannique), russe, polonais, roumain, allemand, espagnol, portugais et italien.'],
      ['🔌', 'Relié à vos logiciels', 'Accès API pour votre paie, votre comptabilité ou votre CRM : les heures arrivent toutes seules.'],
      ['🧾', 'Factures claires', 'Chaque paiement détaillé ligne par ligne, factures téléchargeables et rangées par année.'],
      ['🛡️', 'Vos données protégées', 'Export de vos données en un geste, suppression du compte à tout moment, aucune publicité ciblée.'],
    ],
    'shotsH': 'Un aperçu de l\'application',
    'shotsSub': 'De vraies captures d\'écran, telles que vous les verrez sur votre téléphone.',
    'shots': [
      ['Le planning de la semaine', 'Qui travaille, quand et où, d\'un coup d\'œil.'],
      ['Créer un service', 'Préréglages, poste, site et alertes utiles.'],
      ['Le fil d\'actualités', 'Des annonces ciblées, et qui les a lues.'],
      ['Les demandes', 'Échanges et congés, validés en un tap.'],
      ['Le management', 'Votre équipe, ses rôles et ses sites.'],
    ],
    'stepsH': 'Prêt en trois étapes',
    'steps': [
      ['Créez votre entreprise', 'Connectez-vous avec votre compte Google, donnez un nom à votre entreprise. C\'est tout.'],
      ['Ajoutez votre équipe', 'Chaque salarié vous montre son QR code : vous le scannez, il accepte. Pas d\'e-mail, pas de mot de passe.'],
      ['Publiez le planning', 'Créez les services, publiez : chacun est prévenu sur son téléphone, et peut l\'ajouter à son agenda.'],
    ],
    'apiPill': 'Pour les entreprises',
    'apiH': 'Vos plannings, directement dans votre comptabilité',
    'apiSub': 'Avec l\'accès API, votre logiciel de paie, de comptabilité ou votre CRM récupère tout seul les heures de chacun : plus de ressaisie, plus d\'erreurs de copie.',
    'apiPoints': [
      'Planning publié, heures par salarié et absences validées',
      'Une période au choix, ou tout depuis le premier jour',
      'JSON pour les développeurs, CSV pour Excel',
      'Lecture seule, clés révocables à tout moment',
    ],
    'apiCta': 'Voir la documentation',
    'apiNote': 'Option à 3 € par mois, sans engagement, incluse pendant l\'essai.',
    'installH': 'Installez-la comme une application',
    'installSub': 'Pas besoin de passer par un store : depuis le navigateur, ajoutez Staff Flow à votre écran d\'accueil. Elle s\'ouvre alors en plein écran, avec son icône.',
    'install': [
      ['🤖', 'Android', 'Ouvrez app.staff-flow.cloud dans Chrome (ou Edge, Samsung Internet), menu ⋮ puis « Installer l\'application » ou « Ajouter à l\'écran d\'accueil ». L\'application Android arrive aussi sur Google Play.'],
      ['🍎', 'iPhone et iPad', 'Ouvrez app.staff-flow.cloud dans Safari, touchez le bouton Partager puis « Sur l\'écran d\'accueil ». Depuis iOS 16.4, c\'est aussi possible depuis Chrome ou Edge, avec leur bouton Partager.'],
      ['💻', 'Ordinateur', 'Dans Chrome ou Edge, cliquez sur l\'icône d\'installation à droite de la barre d\'adresse. Avec un autre navigateur, gardez simplement l\'adresse en favori.'],
    ],
    'priceH': 'Un prix tout petit',
    'priceSub': 'Seul le propriétaire de l\'entreprise paie. Les salariés utilisent l\'application gratuitement.',
    'p1': 'Propriétaire d\'entreprise',
    'p1a': '3 €',
    'p1u': '/ mois',
    'p1l': ['Jusqu\'à 10 salariés et 1 extra', '+ tarification par tranches de 10 salariés', '2 mois offerts en paiement annuel', '2 jours d\'essai complet', 'Option accès API (comptabilité, CRM) : 3 € / mois'],
    'p2': 'Salariés et extras',
    'p2a': '0 €',
    'p2u': 'pour toujours',
    'p2l': ['Planning, échanges, congés, annonces', 'Sur Android et dans le navigateur', 'Petite bannière publicitaire sur Android, retirable'],
    'priceNote': 'Prix TTC, en euros. Le paiement en ligne arrive bientôt.',
    'faqH': 'Questions fréquentes',
    'faq': [
      ['Faut-il un iPhone ou un Android ?', 'L\'application existe pour Android. Sur iPhone, ordinateur ou tablette, tout fonctionne dans le navigateur, et vous pouvez l\'ajouter à l\'écran d\'accueil comme une application.'],
      ['Mes salariés doivent-ils payer ?', 'Non. Seul le propriétaire de l\'entreprise a un abonnement. Les salariés, responsables et extras utilisent l\'application gratuitement.'],
      ['Comment se connecter ?', 'Avec un compte Google, sans nouveau mot de passe. Chacun garde le même compte pour toutes ses entreprises. Après avoir relié votre Telegram, vous pouvez aussi demander un lien de connexion au bot (/connexion) et ouvrir Staff Flow dans n\'importe quel navigateur, sans rien installer.'],
      ['Et si le téléphone n\'a pas de réseau ?', 'Le planning déjà reçu reste affiché. Le patron peut continuer à préparer le planning et un salarié à faire une demande de congé : c\'est gardé dans la mémoire du téléphone, puis envoyé dès que la connexion revient. Les autres ne voient ces changements qu\'à ce moment-là.'],
      ['Mes données sont-elles protégées ?', 'Les échanges sont chiffrés (HTTPS), les sauvegardes aussi. Vos plannings et annonces ne sont ni vendus, ni utilisés pour la publicité.'],
      ['Staff Flow se connecte-t-il à mon logiciel de paie ou à mon CRM ?', 'Oui, avec l\'option accès API : votre logiciel lit automatiquement le planning publié, les heures par salarié et les absences, en JSON ou en CSV. Vous créez les clés vous-même dans l\'application et pouvez les révoquer à tout moment. La documentation est publique : staff-flow.cloud/fr/api.'],
      ['Puis-je gérer plusieurs entreprises ?', 'Oui : un onglet par entreprise. Une personne qui travaille dans deux entreprises voit tous ses plannings au même endroit.'],
      ['Comment importer tous mes salariés d\'un coup ?', 'Dans Management, touchez l\'icône d\'importation, téléchargez le modèle Excel et remplissez une ligne par salarié : nom et prénom (obligatoire), e-mail Google, matricule, poste et site (facultatifs). Enregistrez-le en Excel (.xlsx) ou en CSV, puis choisissez-le dans l\'application. Un aperçu montre chaque ligne avant de valider : nouveaux, mis à jour, déjà invités ou en erreur, avec la raison. Les postes et sites manquants sont créés automatiquement.'],
      ['Et ensuite, comment mes salariés rejoignent-ils l\'entreprise ?', 'Chacun reçoit une invitation. Si vous avez indiqué son e-mail Google, il la voit dès sa connexion à Staff Flow et l\'accepte d\'un geste. Sinon, donnez-lui son code personnel ou son QR code : la page « Invitations en attente » les affiche et peut tous les imprimer sur une feuille. Il touche « J\'ai un code d\'invitation » et arrive dans l\'entreprise avec le nom, le matricule et le poste que vous avez prévus. Personne n\'est ajouté sans son accord ; une invitation non utilisée est effacée au bout de 90 jours.'],
      ['Quels téléphones sont compatibles ?', 'L\'application Android fonctionne à partir d\'Android 7 (2016). Sur un téléphone plus ancien, un iPhone ou un ordinateur, utilisez Staff Flow dans un navigateur récent, à l\'adresse app.staff-flow.cloud.'],
    ],
    'finalH': 'Votre prochain planning en 5 minutes',
    'final': 'Essayez gratuitement pendant 2 jours, sans engagement.',
    'soon': 'Bientôt sur Google Play',
  },
  'uk': {
    'name': 'Українська',
    'title': 'Staff Flow – Графік вашої команди, просто й на телефоні',
    'desc': 'Складайте та надсилайте графік працівникам за лічені секунди. Обмін змінами, відпустки, оголошення, робота без інтернету. Від 3 € на місяць, безкоштовно для працівників.',
    'open': 'Відкрити застосунок',
    'pill': 'Графік команди · Android і браузер',
    'h1': 'Графік вашої команди — <em>нарешті просто</em>.',
    'lead': 'Складіть зміни за кілька дотиків, опублікуйте — і кожен отримає їх на телефон. Обмін змінами, відпустки та оголошення — все в одному місці.',
    'start': 'Спробувати безкоштовно',
    'how': 'Як це працює',
    'checks': ['2 дні повного доступу', 'Безкоштовно для працівників', 'Графік видно навіть без мережі'],
    'featH': 'Усе потрібне, нічого зайвого',
    'featSub': 'Від невеликої команди з кількох працівників до великої компанії з багатьма об\'єктами й керівниками: Staff Flow підлаштовується під ваш розмір у будь-якій галузі, де працюють за графіком.',
    'feats': [
      ['🗓️', 'Графік за кілька секунд', 'Шаблони «Ранок», «Вечір», повторення щодня чи щотижня, чернетка й публікація одним дотиком.'],
      ['🔁', 'Обмін змінами та відпустки', 'Працівник пропонує зміну колезі, просить відпустку чи позначає, коли не може працювати; ви підтверджуєте одним дотиком.'],
      ['📣', 'Стрічка новин', 'Власник і керівники публікують оголошення для всіх, посади, об\'єкта або вибраних людей; кожен перекладає їх своєю мовою.'],
      ['📶', 'Навіть без мережі', 'Без зв\'язку графік залишається на екрані, а ви можете далі його складати чи попросити відпустку: усе зберігається в телефоні й надсилається команді, щойно з\'явиться мережа.'],
      ['🏢', 'Кілька об\'єктів і компаній', 'Ієрархія об\'єктів, керівники для кожного об\'єкта, імпорт працівників з Excel і окрема вкладка для кожної компанії.'],
      ['🌍', '10 мов', 'Кожен користується застосунком своєю мовою: українська, французька, англійська (американська чи британська), російська, польська, румунська, німецька, іспанська, португальська та італійська.'],
      ['🔌', 'Зв\'язок з вашими програмами', 'Доступ до API для зарплати, бухгалтерії чи CRM: години надходять самі.'],
      ['🧾', 'Зрозумілі рахунки', 'Кожна оплата з деталями по рядках, рахунки для завантаження, впорядковані за роками.'],
      ['🛡️', 'Ваші дані під захистом', 'Експорт даних одним дотиком, видалення облікового запису будь-коли, жодної таргетованої реклами.'],
    ],
    'shotsH': 'Як виглядає застосунок',
    'shotsSub': 'Справжні знімки екрана — саме так ви побачите все на своєму телефоні.',
    'shots': [
      ['Графік на тиждень', 'Хто, коли й де працює — з одного погляду.'],
      ['Нова зміна', 'Шаблони, посада, об\'єкт і корисні підказки.'],
      ['Стрічка новин', 'Цільові оголошення — і видно, хто їх прочитав.'],
      ['Запити', 'Обмін змінами й відпустки підтверджуються одним дотиком.'],
      ['Управління', 'Ваша команда, ролі та об\'єкти.'],
    ],
    'stepsH': 'Готово за три кроки',
    'steps': [
      ['Створіть компанію', 'Увійдіть через акаунт Google і дайте назву своїй компанії. Це все.'],
      ['Додайте команду', 'Працівник показує свій QR-код — ви скануєте, він підтверджує. Без e-mail і паролів.'],
      ['Опублікуйте графік', 'Створіть зміни й опублікуйте: кожен отримає сповіщення та зможе додати зміни до свого календаря.'],
    ],
    'apiPill': 'Для бізнесу',
    'apiH': 'Ваші графіки — одразу у вашій бухгалтерії',
    'apiSub': 'Завдяки доступу до API ваша програма зарплати, бухгалтерії чи CRM сама отримує години кожного працівника: жодного повторного введення, жодних помилок копіювання.',
    'apiPoints': [
      'Опублікований графік, години кожного працівника й підтверджені відсутності',
      'Будь-який період або все з першого дня',
      'JSON для розробників, CSV для Excel',
      'Лише читання, ключі можна відкликати будь-коли',
    ],
    'apiCta': 'Переглянути документацію',
    'apiNote': 'Опція за 3 € на місяць, без зобов\'язань, доступна під час пробного періоду.',
    'installH': 'Встановіть як застосунок',
    'installSub': 'Магазин застосунків не потрібен: додайте Staff Flow на головний екран прямо з браузера. Тоді він відкриватиметься на весь екран, зі своєю іконкою.',
    'install': [
      ['🤖', 'Android', 'Відкрийте app.staff-flow.cloud у Chrome (або Edge, Samsung Internet), меню ⋮, потім «Установити застосунок» або «Додати на головний екран». Застосунок для Android також з\'явиться в Google Play.'],
      ['🍎', 'iPhone та iPad', 'Відкрийте app.staff-flow.cloud у Safari, натисніть кнопку «Поділитися», потім «На початковий екран». Починаючи з iOS 16.4, це можна зробити й у Chrome чи Edge — тією ж кнопкою «Поділитися».'],
      ['💻', 'Комп\'ютер', 'У Chrome чи Edge натисніть значок установлення праворуч в адресному рядку. В іншому браузері просто додайте адресу в закладки.'],
    ],
    'priceH': 'Зовсім невелика ціна',
    'priceSub': 'Платить лише власник компанії. Працівники користуються застосунком безкоштовно.',
    'p1': 'Власник компанії',
    'p1a': '3 €',
    'p1u': '/ місяць',
    'p1l': ['До 10 працівників і 1 тимчасового', '+ тарифікація за кожні 10 працівників', '2 місяці в подарунок при оплаті за рік', '2 дні повного доступу', 'Опція доступу до API (бухгалтерія, CRM): 3 € / місяць'],
    'p2': 'Працівники та тимчасові працівники',
    'p2a': '0 €',
    'p2u': 'назавжди',
    'p2l': ['Графік, обмін змінами, відпустки, оголошення', 'На Android і в браузері', 'Невеликий рекламний банер на Android, який можна прибрати'],
    'priceNote': 'Ціни з ПДВ, у євро; можна платити карткою в гривнях. Онлайн-оплата незабаром.',
    'faqH': 'Часті запитання',
    'faq': [
      ['Потрібен iPhone чи Android?', 'Застосунок є для Android. На iPhone, комп\'ютері чи планшеті все працює в браузері, і його можна додати на головний екран як застосунок.'],
      ['Чи платять працівники?', 'Ні. Підписка є лише у власника компанії. Працівники, керівники й тимчасові працівники користуються застосунком безкоштовно.'],
      ['Як увійти?', 'Через акаунт Google, без нового пароля. Один акаунт для всіх ваших компаній. Прив\'язавши Telegram, ви можете також попросити в бота посилання для входу (/connexion) і відкрити Staff Flow у будь-якому браузері, нічого не встановлюючи.'],
      ['А якщо на телефоні немає зв\'язку?', 'Уже отриманий графік залишається на екрані. Власник може далі складати графік, а працівник — попросити відпустку: усе зберігається в пам\'яті телефона й надсилається, щойно з\'явиться зв\'язок. Інші побачать ці зміни саме тоді.'],
      ['Чи захищені мої дані?', 'Обмін даними зашифровано (HTTPS), резервні копії теж. Ваші графіки й оголошення не продаються й не використовуються для реклами.'],
      ['Чи підключається Staff Flow до моєї програми зарплати чи CRM?', 'Так, з опцією доступу до API: ваша програма автоматично читає опублікований графік, години кожного працівника й відсутності у форматі JSON або CSV. Ключі ви створюєте самі в застосунку й можете будь-коли відкликати. Документація відкрита: staff-flow.cloud/ua/api.'],
      ['Чи можна вести кілька компаній?', 'Так: окрема вкладка для кожної компанії. Людина, яка працює у двох компаніях, бачить усі свої графіки в одному місці.'],
      ['Як імпортувати всіх працівників одразу?', 'У розділі «Керування» торкніться значка імпорту, завантажте шаблон Excel і заповніть по рядку на працівника: прізвище та ім\'я (обов\'язково), e-mail Google, табельний номер, посада й об\'єкт (необов\'язково). Збережіть файл у форматі Excel (.xlsx) або CSV і виберіть його в застосунку. Попередній перегляд показує кожен рядок перед підтвердженням: нові, оновлені, уже запрошені або з помилкою та її причиною. Відсутні посади й об\'єкти створюються автоматично.'],
      ['А як потім працівники приєднуються до компанії?', 'Кожен отримує запрошення. Якщо ви вказали його e-mail Google, він побачить запрошення одразу після входу в Staff Flow і прийме його одним дотиком. Інакше дайте йому особистий код або QR-код: сторінка «Запрошення в очікуванні» показує їх і може надрукувати всі на одному аркуші. Працівник торкається «У мене є код запрошення» і потрапляє до компанії з ім\'ям, табельним номером і посадою, які ви вказали. Нікого не додають без згоди; невикористане запрошення видаляється через 90 днів.'],
      ['Які телефони підтримуються?', 'Застосунок для Android працює починаючи з Android 7 (2016). На старішому телефоні, iPhone чи комп\'ютері користуйтеся Staff Flow у сучасному браузері за адресою app.staff-flow.cloud.'],
    ],
    'finalH': 'Ваш наступний графік — за 5 хвилин',
    'final': 'Спробуйте безкоштовно протягом 2 днів, без зобов\'язань.',
    'soon': 'Незабаром у Google Play',
  },
  'en': {
    'name': 'English',
    'title': 'Staff Flow – Your team\'s schedule, simple and mobile',
    'desc': 'Build and share your staff schedule in seconds. Shift swaps, leave, announcements, works offline. From €3 a month, free for employees.',
    'open': 'Open the app',
    'pill': 'Team scheduling · Android and web',
    'h1': 'Your team\'s schedule, <em>finally simple</em>.',
    'lead': 'Build shifts in a few taps, publish them, and everyone gets them on their phone. Shift swaps, leave and announcements — all in one place.',
    'start': 'Try it free',
    'how': 'How it works',
    'checks': ['2-day full trial', 'Free for employees', 'Readable even without signal'],
    'featH': 'Everything you need, nothing complicated',
    'featSub': 'From a small team of a few employees to a large company with many sites and managers: Staff Flow adapts to your size, in every sector that works on schedules.',
    'feats': [
      ['🗓️', 'A schedule in seconds', '“Morning” and “Evening” presets, daily or weekly repeats, draft then publish in one tap.'],
      ['🔁', 'Swaps and leave', 'An employee offers a shift to a colleague, asks for leave or marks unavailability; you approve in one tap.'],
      ['📣', 'News feed', 'The owner and managers post announcements for everyone, a position, a site or chosen people; everyone translates them into their language.'],
      ['📶', 'Even without signal', 'Offline, the schedule stays on screen and you can keep planning or ask for leave: it is kept on the phone and sent to the team as soon as the network is back.'],
      ['🏢', 'Several sites and companies', 'Nested sites, managers per site, employees imported from Excel, and one tab per company for people who work in several places.'],
      ['🌍', '10 languages', 'Everyone uses the app in their own language: English (US or UK), French, Ukrainian, Russian, Polish, Romanian, German, Spanish, Portuguese and Italian.'],
      ['🔌', 'Connected to your software', 'API access for your payroll, accounting or CRM: hours arrive on their own.'],
      ['🧾', 'Clear invoices', 'Every payment detailed line by line, invoices to download, sorted by year.'],
      ['🛡️', 'Your data protected', 'Export your data in one tap, delete your account at any time, no targeted advertising.'],
    ],
    'shotsH': 'A look at the app',
    'shotsSub': 'Real screenshots, just as you will see them on your phone.',
    'shots': [
      ['The week\'s schedule', 'Who works when and where, at a glance.'],
      ['Creating a shift', 'Presets, position, site and helpful alerts.'],
      ['News feed', 'Targeted announcements, and who has read them.'],
      ['Requests', 'Swaps and leave, approved in one tap.'],
      ['Management', 'Your team, its roles and its sites.'],
    ],
    'stepsH': 'Ready in three steps',
    'steps': [
      ['Create your company', 'Sign in with your Google account and name your company. That\'s it.'],
      ['Add your team', 'Each employee shows you their QR code: you scan it, they accept. No email, no password.'],
      ['Publish the schedule', 'Create the shifts and publish: everyone is notified on their phone and can add them to their calendar.'],
    ],
    'apiPill': 'For businesses',
    'apiH': 'Your schedules, straight into your accounting',
    'apiSub': 'With API access, your payroll, accounting or CRM software fetches everyone\'s hours on its own: no more retyping, no more copy errors.',
    'apiPoints': [
      'Published schedule, hours per employee and approved absences',
      'Any period, or everything since day one',
      'JSON for developers, CSV for Excel',
      'Read-only, keys you can revoke at any time',
    ],
    'apiCta': 'Read the documentation',
    'apiNote': 'Option at €3 a month, no commitment, included during the trial.',
    'installH': 'Install it like an app',
    'installSub': 'No app store needed: add Staff Flow to your home screen straight from the browser. It then opens full screen, with its own icon.',
    'install': [
      ['🤖', 'Android', 'Open app.staff-flow.cloud in Chrome (or Edge, Samsung Internet), menu ⋮ then “Install app” or “Add to Home screen”. The Android app is also coming to Google Play.'],
      ['🍎', 'iPhone and iPad', 'Open app.staff-flow.cloud in Safari, tap the Share button then “Add to Home Screen”. Since iOS 16.4 you can also do it from Chrome or Edge, with their Share button.'],
      ['💻', 'Computer', 'In Chrome or Edge, click the install icon on the right of the address bar. In another browser, simply bookmark the address.'],
    ],
    'priceH': 'A tiny price',
    'priceSub': 'Only the company owner pays. Employees use the app for free.',
    'p1': 'Company owner',
    'p1a': '€3',
    'p1u': '/ month',
    'p1l': ['Up to 10 employees and 1 temp', '+ pricing per block of 10 employees', '2 months free when paying yearly', '2-day full trial', 'API access option (accounting, CRM): €3 / month'],
    'p2': 'Employees and temps',
    'p2a': '€0',
    'p2u': 'forever',
    'p2l': ['Schedule, swaps, leave, announcements', 'On Android and in the browser', 'Small ad banner on Android, removable'],
    'priceNote': 'Prices include VAT, in euros. Online payment is coming soon.',
    'faqH': 'Frequently asked questions',
    'faq': [
      ['Do I need an iPhone or an Android?', 'There is an Android app. On iPhone, computer or tablet, everything works in the browser, and you can add it to your home screen like an app.'],
      ['Do my employees pay?', 'No. Only the company owner has a subscription. Employees, managers and temps use the app for free.'],
      ['How do people sign in?', 'With a Google account, no new password. One account for all your companies. Once your Telegram is linked, you can also ask the bot for a sign-in link (/connexion) and open Staff Flow in any browser, with nothing to install.'],
      ['What if the phone has no signal?', 'The schedule you already received stays on screen. The owner can keep planning and an employee can ask for leave: it is kept in the phone\'s memory and sent as soon as the connection is back. Others see those changes only then.'],
      ['Is my data protected?', 'Connections are encrypted (HTTPS), and so are backups. Your schedules and announcements are never sold or used for advertising.'],
      ['Does Staff Flow connect to my payroll software or CRM?', 'Yes, with the API access option: your software automatically reads the published schedule, hours per employee and absences, as JSON or CSV. You create the keys yourself in the app and can revoke them at any time. The documentation is public: staff-flow.cloud/en/api.'],
      ['Can I manage several companies?', 'Yes: one tab per company. Someone who works for two companies sees all their schedules in one place.'],
      ['How do I import all my employees at once?', 'In Management, tap the import icon, download the Excel template and fill in one row per employee: full name (required), Google e-mail, employee number, position and site (optional). Save it as Excel (.xlsx) or CSV, then pick it in the app. A preview shows every row before you confirm: new, updated, already invited or with an error and its reason. Missing positions and sites are created automatically.'],
      ['Then how do my employees join the company?', 'Each one gets an invitation. If you gave their Google e-mail, they see it as soon as they sign in to Staff Flow and accept it in one tap. Otherwise, give them their personal code or QR code: the “Pending invitations” page shows them and can print them all on one sheet. They tap “I have an invitation code” and join the company with the name, employee number and position you set. Nobody is added without their consent; an unused invitation is erased after 90 days.'],
      ['Which phones are supported?', 'The Android app works from Android 7 (2016). On an older phone, an iPhone or a computer, use Staff Flow in an up-to-date browser at app.staff-flow.cloud.'],
    ],
    'finalH': 'Your next schedule in 5 minutes',
    'final': 'Try it free for 2 days, no commitment.',
    'soon': 'Coming soon to Google Play',
  },
};

String esc(String s) => s.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;');

/// Texte avec du balisage voulu (<em>) : seules les apostrophes et les & sont protégés.
String rich(String s) => s.replaceAll('&', '&amp;');

String page(String l) {
  final x = t[l]!;
  String s(String k) => esc(x[k] as String);
  List<List<String>> rows(String k) => [for (final r in x[k] as List) [for (final c in r as List) c as String]];
  List<String> list(String k) => [for (final c in x[k] as List) c as String];
  final dir = shotDir(l);
  final alternates = [
    for (final o in langs) '<link rel="alternate" hreflang="$o" href="$site/${slug(o)}/">',
    '<link rel="alternate" hreflang="x-default" href="$site/">',
  ].join('\n  ');
  final switcher = [
    for (final o in langs)
      '<a href="/${slug(o)}/" lang="$o" title="${esc(t[o]!['name'] as String)}"${o == l ? ' aria-current="page"' : ''}>${label(o)}</a>',
  ].join();
  return '''<!doctype html>
<html lang="$l">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${s('title')}</title>
  <meta name="description" content="${s('desc')}">
  <link rel="canonical" href="$site/${slug(l)}/">
  $alternates
  <meta property="og:type" content="website">
  <meta property="og:title" content="${s('title')}">
  <meta property="og:description" content="${s('desc')}">
  <meta property="og:url" content="$site/${slug(l)}/">
  <meta property="og:image" content="$site/og.png">
  <meta name="theme-color" content="#061440">
  <link rel="icon" type="image/png" href="/favicon.png">
  <link rel="preload" href="/fonts/Nunito.ttf" as="font" type="font/ttf" crossorigin>
  <link rel="stylesheet" href="/style.css?v=6">
</head>
<body>
<header class="top">
  <div class="wrap">
    <a class="brand" translate="no" href="/${slug(l)}/"><img src="/brand.png" alt="Staff Flow" width="205" height="46"></a>
    <nav class="langs" translate="no" aria-label="Language">$switcher</nav>
    <a class="btn btn-main" href="$app">${s('open')}</a>
  </div>
</header>

<main>
<section class="hero">
  <div class="wrap">
    <div>
      <span class="pill">${s('pill')}</span>
      <h1>${rich(x['h1'] as String)}</h1>
      <p class="lead">${s('lead')}</p>
      <div class="cta">
        <a class="btn btn-main" href="$app">${s('start')}</a>
        <a class="btn btn-ghost" href="#steps">${s('how')}</a>
      </div>
      <ul class="checks">${[for (final c in list('checks')) '<li>${esc(c)}</li>'].join()}</ul>
    </div>
    <div class="hero-phone">
      <div class="phone"><img src="/img/$dir/1-planning.jpg?v=2" alt="${esc(rows('shots')[0][0])}" width="540" height="1200"></div>
    </div>
  </div>
</section>

<section>
  <div class="wrap center">
    <h2>${s('featH')}</h2>
    <p class="sub">${s('featSub')}</p>
  </div>
  <div class="wrap grid">
    ${[for (final f in rows('feats')) '<div class="card"><div class="ico" aria-hidden="true">${f[0]}</div><h3>${esc(f[1])}</h3><p>${esc(f[2])}</p></div>'].join('\n    ')}
  </div>
</section>

<section class="soft" id="shots">
  <div class="wrap">
    <h2>${s('shotsH')}</h2>
    <p class="sub">${s('shotsSub')}</p>
    <div class="shots">
      ${[for (final (i, c) in rows('shots').indexed) '<figure><img src="/img/$dir/${shots[i]}.jpg?v=2" alt="${esc(c[0])}" width="540" height="1200" loading="lazy"><figcaption>${esc(c[0])}<span>${esc(c[1])}</span></figcaption></figure>'].join('\n      ')}
    </div>
  </div>
</section>

<section class="api-band" id="api">
  <div class="wrap api-grid">
    <div>
      <span class="pill">${s('apiPill')}</span>
      <h2>${s('apiH')}</h2>
      <p class="sub">${s('apiSub')}</p>
      <ul class="checks api-points">${[for (final c in list('apiPoints')) '<li>${esc(c)}</li>'].join()}</ul>
      <div class="cta">
        <a class="btn btn-main" href="/${slug(l)}/api/">${s('apiCta')}</a>
      </div>
      <p class="note">${s('apiNote')}</p>
    </div>
    <div class="api-code" aria-hidden="true" translate="no">
      <div class="api-code-bar"><span></span><span></span><span></span></div>
<pre><span class="c-cmd">GET</span> /api/v1/ext/totals?from=2026-10-01
<span class="c-key">Authorization:</span> Bearer sfk_••••••

{ <span class="c-key">"data"</span>: [
  { <span class="c-key">"name"</span>: <span class="c-str">"Olena"</span>, <span class="c-key">"minutes"</span>: <span class="c-num">9120</span> },
  { <span class="c-key">"name"</span>: <span class="c-str">"Andriy"</span>, <span class="c-key">"minutes"</span>: <span class="c-num">7680</span> },
  { <span class="c-key">"name"</span>: <span class="c-str">"Sofia"</span>, <span class="c-key">"minutes"</span>: <span class="c-num">6240</span> }
] }</pre>
    </div>
  </div>
</section>

<section id="steps">
  <div class="wrap">
    <h2 class="center">${s('stepsH')}</h2>
    <ol class="steps" style="margin-top:40px">
      ${[for (final st in rows('steps')) '<li><h3>${esc(st[0])}</h3><p>${esc(st[1])}</p></li>'].join('\n      ')}
    </ol>
  </div>
</section>

<section id="install">
  <div class="wrap center">
    <h2>${s('installH')}</h2>
    <p class="sub">${s('installSub')}</p>
  </div>
  <div class="wrap grid">
    ${[for (final f in rows('install')) '<div class="card"><div class="ico" aria-hidden="true">${f[0]}</div><h3>${esc(f[1])}</h3><p>${esc(f[2])}</p></div>'].join('\n    ')}
  </div>
</section>

<section class="soft" id="prices">
  <div class="wrap center">
    <h2>${s('priceH')}</h2>
    <p class="sub">${s('priceSub')}</p>
    <div class="prices">
      <div class="card price main">
        <h3>${s('p1')}</h3>
        <div class="amount">${s('p1a')} <small>${s('p1u')}</small></div>
        <ul>${[for (final c in list('p1l')) '<li>${esc(c)}</li>'].join()}</ul>
      </div>
      <div class="card price">
        <h3>${s('p2')}</h3>
        <div class="amount">${s('p2a')} <small>${s('p2u')}</small></div>
        <ul>${[for (final c in list('p2l')) '<li>${esc(c)}</li>'].join()}</ul>
      </div>
    </div>
    <p class="note">${s('priceNote')}</p>
  </div>
</section>

<section id="faq">
  <div class="wrap">
    <h2 class="center">${s('faqH')}</h2>
    <div class="faq" style="margin-top:32px">
      ${[for (final q in rows('faq')) '<details><summary>${esc(q[0])}</summary><p>${esc(q[1])}</p></details>'].join('\n      ')}
    </div>
  </div>
</section>

<section class="final">
  <div class="wrap">
    <h2>${s('finalH')}</h2>
    <p>${s('final')}</p>
    <div class="cta" style="justify-content:center">
      <a class="btn btn-main" href="$app">${s('start')}</a>
    </div>
    <p style="margin:22px 0 0;font-size:15px">${s('soon')}</p>
  </div>
</section>
</main>

${footer(l)}
</body>
</html>
''';
}

String footer(String l) => '''<footer>
  <div class="wrap">
    <span>© 2026 Staff Flow · <a href="/${slug(l)}/terms/">${esc(legalTitles[l]!['terms']!)}</a> · <a href="/${slug(l)}/privacy/">${esc(legalTitles[l]!['privacy']!)}</a> · <a href="/${slug(l)}/api/">API</a> · <a href="mailto:contact@staff-flow.cloud">contact@staff-flow.cloud</a></span>
    <span>${[for (final o in langs) '<a href="/${slug(o)}/" lang="$o">${esc(t[o]!['name'] as String)}</a>'].join(' · ')}</span>
  </div>
</footer>''';

/// Page légale [doc] (`terms` ou `privacy`) dans la langue [l].
String legalPage(String l, String doc) {
  final x = t[l]!;
  final title = doc == 'api' ? apiTitles[l]! : legalTitles[l]![doc]!;
  final switcher = [
    for (final o in langs)
      '<a href="/${slug(o)}/$doc/" lang="$o" title="${esc(t[o]!['name'] as String)}"${o == l ? ' aria-current="page"' : ''}>${label(o)}</a>',
  ].join();
  String item(Object p) => p is List ? '<pre><code>${esc(p[1] as String)}</code></pre>' : '<p>${esc(p as String)}</p>';
  final sections = [
    for (final s in doc == 'api' ? apiDocs[l]! : legal[l]![doc]!)
      '<h2>${esc(s[0] as String)}</h2>\n      ${[for (final p in s[1] as List) item(p as Object)].join('\n      ')}',
  ].join('\n      ');
  return '''<!doctype html>
<html lang="$l">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${esc(title)} – Staff Flow</title>
  <link rel="canonical" href="$site/${slug(l)}/$doc/">
  ${[for (final o in langs) '<link rel="alternate" hreflang="$o" href="$site/${slug(o)}/$doc/">'].join('\n  ')}
  <meta name="theme-color" content="#061440">
  <link rel="icon" type="image/png" href="/favicon.png">
  <link rel="stylesheet" href="/style.css?v=6">
</head>
<body>
<header class="top">
  <div class="wrap">
    <a class="brand" translate="no" href="/${slug(l)}/"><img src="/brand.png" alt="Staff Flow" width="205" height="46"></a>
    <nav class="langs" translate="no" aria-label="Language">$switcher</nav>
    <a class="btn btn-main" href="$app">${esc(x['open'] as String)}</a>
  </div>
</header>
<main>
  <section>
    <div class="wrap legal">
      <h1>${esc(title)}</h1>
      ${doc == 'api' ? '' : '<p class="note">${esc(legalUpdated[l]!)}</p>'}
      $sections
    </div>
  </section>
</main>
${footer(l)}
</body>
</html>
''';
}

/// Page d'accueil sans langue : normalement jamais vue (le serveur envoie
/// vers /fr/, /uk/ ou /en/) ; sinon, simple choix de langue.
String root() => '''<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Staff Flow</title>
  ${[for (final o in langs) '<link rel="alternate" hreflang="$o" href="$site/${slug(o)}/">'].join('\n  ')}
  <link rel="icon" type="image/png" href="/favicon.png">
  <link rel="stylesheet" href="/style.css?v=6">
</head>
<body>
<section class="final" style="min-height:100vh;display:grid;place-items:center">
  <div class="wrap">
    <img src="/logo.png" alt="" width="96" height="75" style="margin:0 auto 18px">
    <h2>Staff Flow</h2>
    <div class="cta" style="justify-content:center">
      ${[for (final o in langs) '<a class="btn btn-ghost" href="/${slug(o)}/" lang="$o">${esc(t[o]!['name'] as String)}</a>'].join('\n      ')}
    </div>
  </div>
</section>
</body>
</html>
''';

void main() {
  for (final l in langs) {
    Directory('www/${slug(l)}').createSync(recursive: true);
    File('www/${slug(l)}/index.html').writeAsStringSync(page(l));
    for (final doc in ['terms', 'privacy', 'api']) {
      Directory('www/${slug(l)}/$doc').createSync(recursive: true);
      File('www/${slug(l)}/$doc/index.html').writeAsStringSync(legalPage(l, doc));
    }
  }
  File('www/index.html').writeAsStringSync(root());
  File('www/robots.txt').writeAsStringSync('User-agent: *\nAllow: /\nSitemap: $site/sitemap.xml\n');
  File('www/sitemap.xml').writeAsStringSync('''<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">
${[
    for (final l in langs)
      for (final p in ['', 'terms/', 'privacy/', 'api/'])
        '  <url><loc>$site/${slug(l)}/$p</loc>${[for (final o in langs) '<xhtml:link rel="alternate" hreflang="$o" href="$site/${slug(o)}/$p"/>'].join()}</url>',
  ].join('\n')}
</urlset>
''');
  print('site généré : ${langs.join(', ')}');
}
