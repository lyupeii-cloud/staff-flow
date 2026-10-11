import 'dart:io';

/// Génère le site vitrine (www/fr, www/uk, www/en) à partir des textes
/// ci-dessous :  dart tool/build.dart  (depuis le dossier site/).
///
/// Une page par langue ; la page d'accueil « / » envoie vers la langue du
/// navigateur (règle dans deploy/staff-flow.cloud.caddy).
const site = 'https://staff-flow.cloud';
const app = 'https://staff-flow.vercane.com';
const langs = ['fr', 'uk', 'en'];

/// Captures : une série par langue (www/img/fr, uk, en).
const shots = ['1-planning', '2-service', '3-messages', '4-demandes', '5-management'];
String shotDir(String l) => l;

final t = <String, Map<String, Object>>{
  'fr': {
    'name': 'Français',
    'title': 'Staff Flow – Le planning de votre équipe, simple et sur mobile',
    'desc': 'Créez et partagez le planning de vos salariés en quelques secondes. Échanges, congés, messagerie, hors connexion. Dès 1 € par mois, gratuit pour les salariés.',
    'open': 'Ouvrir l\'application',
    'pill': 'Planning d\'équipe · Android et navigateur',
    'h1': 'Le planning de votre équipe, <em>enfin simple</em>.',
    'lead': 'Créez les horaires en quelques gestes, publiez-les, et chacun les reçoit sur son téléphone. Échanges de service, congés et messages : tout au même endroit.',
    'start': 'Essayer gratuitement',
    'how': 'Comment ça marche',
    'checks': ['2 jours d\'essai complet', 'Gratuit pour les salariés', 'Consultable même sans réseau'],
    'featH': 'Tout ce qu\'il faut, rien de compliqué',
    'featSub': 'Pensé pour les cafés, restaurants, boulangeries, commerces et toutes les équipes qui travaillent en horaires décalés.',
    'feats': [
      ['🗓️', 'Un planning en quelques secondes', 'Préréglages « Matin », « Soir », répétition chaque jour ou chaque semaine, brouillon puis publication en un geste.'],
      ['🔁', 'Échanges et congés', 'Un salarié propose son service à un collègue, demande un congé ou une indisponibilité ; vous validez d\'un tap.'],
      ['💬', 'Messagerie d\'équipe', 'Groupe de toute l\'entreprise, groupes par équipe et messages privés, avec traduction automatique.'],
      ['📶', 'Même sans réseau', 'Sans connexion, le planning reste affiché et vous pouvez continuer à le préparer ou demander un congé : c\'est gardé sur le téléphone et envoyé à l\'équipe dès que le réseau revient.'],
      ['🏢', 'Plusieurs sites et entreprises', 'Sites en cascade, responsables par site, et un onglet par entreprise pour qui travaille à plusieurs endroits.'],
      ['🌍', '37 langues', 'Chacun utilise l\'application dans sa langue : français, ukrainien, anglais, espagnol, polonais…'],
    ],
    'shotsH': 'Un aperçu de l\'application',
    'shotsSub': 'De vraies captures d\'écran, telles que vous les verrez sur votre téléphone.',
    'shots': [
      ['Le planning de la semaine', 'Qui travaille, quand et où, d\'un coup d\'œil.'],
      ['Créer un service', 'Préréglages, poste, site et alertes utiles.'],
      ['La messagerie', 'Les demandes d\'échange arrivent dans la conversation.'],
      ['Les demandes', 'Échanges et congés, validés en un tap.'],
      ['Le management', 'Votre équipe, ses rôles et ses sites.'],
    ],
    'stepsH': 'Prêt en trois étapes',
    'steps': [
      ['Créez votre entreprise', 'Connectez-vous avec votre compte Google, donnez un nom à votre entreprise. C\'est tout.'],
      ['Ajoutez votre équipe', 'Chaque salarié vous montre son QR code : vous le scannez, il accepte. Pas d\'e-mail, pas de mot de passe.'],
      ['Publiez le planning', 'Créez les services, publiez : chacun est prévenu sur son téléphone, et peut l\'ajouter à son agenda.'],
    ],
    'priceH': 'Un prix tout petit',
    'priceSub': 'Seul le propriétaire de l\'entreprise paie. Les salariés utilisent l\'application gratuitement.',
    'p1': 'Propriétaire d\'entreprise',
    'p1a': '1 €',
    'p1u': '/ mois',
    'p1l': ['Jusqu\'à 10 salariés et 1 extra', '+ tarification par tranches de 10 salariés', 'Toutes les fonctions incluses', '2 jours d\'essai complet'],
    'p2': 'Salariés et extras',
    'p2a': '0 €',
    'p2u': 'pour toujours',
    'p2l': ['Planning, échanges, congés, messages', 'Sur Android et dans le navigateur', 'Petite bannière publicitaire sur Android, retirable'],
    'priceNote': 'Prix TTC, en euros. Le paiement en ligne arrive bientôt.',
    'faqH': 'Questions fréquentes',
    'faq': [
      ['Faut-il un iPhone ou un Android ?', 'L\'application existe pour Android. Sur iPhone, ordinateur ou tablette, tout fonctionne dans le navigateur, sans rien installer.'],
      ['Mes salariés doivent-ils payer ?', 'Non. Seul le propriétaire de l\'entreprise a un abonnement. Les salariés, responsables et extras utilisent l\'application gratuitement.'],
      ['Comment se connecter ?', 'Avec un compte Google, sans nouveau mot de passe. Chacun garde le même compte pour toutes ses entreprises.'],
      ['Et si le téléphone n\'a pas de réseau ?', 'Le planning déjà reçu reste affiché. Le patron peut continuer à préparer le planning et un salarié à faire une demande de congé : c\'est gardé dans la mémoire du téléphone, puis envoyé dès que la connexion revient. Les autres ne voient ces changements qu\'à ce moment-là.'],
      ['Mes données sont-elles protégées ?', 'Les échanges sont chiffrés (HTTPS), les sauvegardes aussi. Vos plannings et messages ne sont ni vendus, ni utilisés pour la publicité.'],
      ['Puis-je gérer plusieurs entreprises ?', 'Oui : un onglet par entreprise. Une personne qui travaille dans deux entreprises voit tous ses plannings au même endroit.'],
    ],
    'finalH': 'Votre prochain planning en 5 minutes',
    'final': 'Essayez gratuitement pendant 2 jours, sans engagement.',
    'soon': 'Bientôt sur Google Play',
  },
  'uk': {
    'name': 'Українська',
    'title': 'Staff Flow – Графік вашої команди, просто й на телефоні',
    'desc': 'Складайте та надсилайте графік працівникам за лічені секунди. Обмін змінами, відпустки, повідомлення, робота без інтернету. Від 1 € на місяць, безкоштовно для працівників.',
    'open': 'Відкрити застосунок',
    'pill': 'Графік команди · Android і браузер',
    'h1': 'Графік вашої команди — <em>нарешті просто</em>.',
    'lead': 'Складіть зміни за кілька дотиків, опублікуйте — і кожен отримає їх на телефон. Обмін змінами, відпустки та повідомлення — все в одному місці.',
    'start': 'Спробувати безкоштовно',
    'how': 'Як це працює',
    'checks': ['2 дні повного доступу', 'Безкоштовно для працівників', 'Графік видно навіть без мережі'],
    'featH': 'Усе потрібне, нічого зайвого',
    'featSub': 'Створено для кав\'ярень, ресторанів, пекарень, магазинів і всіх команд, що працюють змінами.',
    'feats': [
      ['🗓️', 'Графік за кілька секунд', 'Шаблони «Ранок», «Вечір», повторення щодня чи щотижня, чернетка й публікація одним дотиком.'],
      ['🔁', 'Обмін змінами та відпустки', 'Працівник пропонує зміну колезі, просить відпустку чи позначає, коли не може працювати; ви підтверджуєте одним дотиком.'],
      ['💬', 'Чат команди', 'Загальний чат компанії, групи за командами та особисті повідомлення з автоматичним перекладом.'],
      ['📶', 'Навіть без мережі', 'Без зв\'язку графік залишається на екрані, а ви можете далі його складати чи попросити відпустку: усе зберігається в телефоні й надсилається команді, щойно з\'явиться мережа.'],
      ['🏢', 'Кілька об\'єктів і компаній', 'Ієрархія об\'єктів, керівники для кожного об\'єкта й окрема вкладка для кожної компанії.'],
      ['🌍', '37 мов', 'Кожен користується застосунком своєю мовою: українська, англійська, польська, французька…'],
    ],
    'shotsH': 'Як виглядає застосунок',
    'shotsSub': 'Справжні знімки екрана — саме так ви побачите все на своєму телефоні.',
    'shots': [
      ['Графік на тиждень', 'Хто, коли й де працює — з одного погляду.'],
      ['Нова зміна', 'Шаблони, посада, об\'єкт і корисні підказки.'],
      ['Повідомлення', 'Запити на обмін змінами з\'являються просто в чаті.'],
      ['Запити', 'Обмін змінами й відпустки підтверджуються одним дотиком.'],
      ['Управління', 'Ваша команда, ролі та об\'єкти.'],
    ],
    'stepsH': 'Готово за три кроки',
    'steps': [
      ['Створіть компанію', 'Увійдіть через акаунт Google і дайте назву своїй компанії. Це все.'],
      ['Додайте команду', 'Працівник показує свій QR-код — ви скануєте, він підтверджує. Без e-mail і паролів.'],
      ['Опублікуйте графік', 'Створіть зміни й опублікуйте: кожен отримає сповіщення та зможе додати зміни до свого календаря.'],
    ],
    'priceH': 'Зовсім невелика ціна',
    'priceSub': 'Платить лише власник компанії. Працівники користуються застосунком безкоштовно.',
    'p1': 'Власник компанії',
    'p1a': '1 €',
    'p1u': '/ місяць',
    'p1l': ['До 10 працівників і 1 тимчасового', '+ тарифікація за кожні 10 працівників', 'Усі функції включено', '2 дні повного доступу'],
    'p2': 'Працівники та тимчасові працівники',
    'p2a': '0 €',
    'p2u': 'назавжди',
    'p2l': ['Графік, обмін змінами, відпустки, повідомлення', 'На Android і в браузері', 'Невеликий рекламний банер на Android, який можна прибрати'],
    'priceNote': 'Ціни з ПДВ, у євро; можна платити карткою в гривнях. Онлайн-оплата незабаром.',
    'faqH': 'Часті запитання',
    'faq': [
      ['Потрібен iPhone чи Android?', 'Застосунок є для Android. На iPhone, комп\'ютері чи планшеті все працює в браузері, нічого не треба встановлювати.'],
      ['Чи платять працівники?', 'Ні. Підписка є лише у власника компанії. Працівники, керівники й тимчасові працівники користуються застосунком безкоштовно.'],
      ['Як увійти?', 'Через акаунт Google, без нового пароля. Один акаунт для всіх ваших компаній.'],
      ['А якщо на телефоні немає зв\'язку?', 'Уже отриманий графік залишається на екрані. Власник може далі складати графік, а працівник — попросити відпустку: усе зберігається в пам\'яті телефона й надсилається, щойно з\'явиться зв\'язок. Інші побачать ці зміни саме тоді.'],
      ['Чи захищені мої дані?', 'Обмін даними зашифровано (HTTPS), резервні копії теж. Ваші графіки й повідомлення не продаються й не використовуються для реклами.'],
      ['Чи можна вести кілька компаній?', 'Так: окрема вкладка для кожної компанії. Людина, яка працює у двох компаніях, бачить усі свої графіки в одному місці.'],
    ],
    'finalH': 'Ваш наступний графік — за 5 хвилин',
    'final': 'Спробуйте безкоштовно протягом 2 днів, без зобов\'язань.',
    'soon': 'Незабаром у Google Play',
  },
  'en': {
    'name': 'English',
    'title': 'Staff Flow – Your team\'s schedule, simple and mobile',
    'desc': 'Build and share your staff schedule in seconds. Shift swaps, leave, messaging, works offline. From €1 a month, free for employees.',
    'open': 'Open the app',
    'pill': 'Team scheduling · Android and web',
    'h1': 'Your team\'s schedule, <em>finally simple</em>.',
    'lead': 'Build shifts in a few taps, publish them, and everyone gets them on their phone. Shift swaps, leave and messages — all in one place.',
    'start': 'Try it free',
    'how': 'How it works',
    'checks': ['2-day full trial', 'Free for employees', 'Readable even without signal'],
    'featH': 'Everything you need, nothing complicated',
    'featSub': 'Made for cafés, restaurants, bakeries, shops and every team that works in shifts.',
    'feats': [
      ['🗓️', 'A schedule in seconds', '“Morning” and “Evening” presets, daily or weekly repeats, draft then publish in one tap.'],
      ['🔁', 'Swaps and leave', 'An employee offers a shift to a colleague, asks for leave or marks unavailability; you approve in one tap.'],
      ['💬', 'Team messaging', 'Company-wide group, team groups and private messages, with automatic translation.'],
      ['📶', 'Even without signal', 'Offline, the schedule stays on screen and you can keep planning or ask for leave: it is kept on the phone and sent to the team as soon as the network is back.'],
      ['🏢', 'Several sites and companies', 'Nested sites, managers per site, and one tab per company for people who work in several places.'],
      ['🌍', '37 languages', 'Everyone uses the app in their own language: English, Ukrainian, French, Spanish, Polish…'],
    ],
    'shotsH': 'A look at the app',
    'shotsSub': 'Real screenshots, just as you will see them on your phone.',
    'shots': [
      ['The week\'s schedule', 'Who works when and where, at a glance.'],
      ['Creating a shift', 'Presets, position, site and helpful alerts.'],
      ['Messaging', 'Swap requests show up right in the conversation.'],
      ['Requests', 'Swaps and leave, approved in one tap.'],
      ['Management', 'Your team, its roles and its sites.'],
    ],
    'stepsH': 'Ready in three steps',
    'steps': [
      ['Create your company', 'Sign in with your Google account and name your company. That\'s it.'],
      ['Add your team', 'Each employee shows you their QR code: you scan it, they accept. No email, no password.'],
      ['Publish the schedule', 'Create the shifts and publish: everyone is notified on their phone and can add them to their calendar.'],
    ],
    'priceH': 'A tiny price',
    'priceSub': 'Only the company owner pays. Employees use the app for free.',
    'p1': 'Company owner',
    'p1a': '€1',
    'p1u': '/ month',
    'p1l': ['Up to 10 employees and 1 temp', '+ pricing per block of 10 employees', 'Every feature included', '2-day full trial'],
    'p2': 'Employees and temps',
    'p2a': '€0',
    'p2u': 'forever',
    'p2l': ['Schedule, swaps, leave, messages', 'On Android and in the browser', 'Small ad banner on Android, removable'],
    'priceNote': 'Prices include VAT, in euros. Online payment is coming soon.',
    'faqH': 'Frequently asked questions',
    'faq': [
      ['Do I need an iPhone or an Android?', 'There is an Android app. On iPhone, computer or tablet, everything works in the browser, with nothing to install.'],
      ['Do my employees pay?', 'No. Only the company owner has a subscription. Employees, managers and temps use the app for free.'],
      ['How do people sign in?', 'With a Google account, no new password. One account for all your companies.'],
      ['What if the phone has no signal?', 'The schedule you already received stays on screen. The owner can keep planning and an employee can ask for leave: it is kept in the phone\'s memory and sent as soon as the connection is back. Others see those changes only then.'],
      ['Is my data protected?', 'Connections are encrypted (HTTPS), and so are backups. Your schedules and messages are never sold or used for advertising.'],
      ['Can I manage several companies?', 'Yes: one tab per company. Someone who works for two companies sees all their schedules in one place.'],
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
    for (final o in langs) '<link rel="alternate" hreflang="$o" href="$site/$o/">',
    '<link rel="alternate" hreflang="x-default" href="$site/">',
  ].join('\n  ');
  final switcher = [
    for (final o in langs)
      '<a href="/$o/" lang="$o"${o == l ? ' aria-current="page"' : ''}>${o.toUpperCase()}</a>',
  ].join();
  return '''<!doctype html>
<html lang="$l">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${s('title')}</title>
  <meta name="description" content="${s('desc')}">
  <link rel="canonical" href="$site/$l/">
  $alternates
  <meta property="og:type" content="website">
  <meta property="og:title" content="${s('title')}">
  <meta property="og:description" content="${s('desc')}">
  <meta property="og:url" content="$site/$l/">
  <meta property="og:image" content="$site/og.png">
  <meta name="theme-color" content="#061440">
  <link rel="icon" type="image/png" href="/favicon.png">
  <link rel="preload" href="/fonts/Nunito.ttf" as="font" type="font/ttf" crossorigin>
  <link rel="stylesheet" href="/style.css?v=2">
</head>
<body>
<header class="top">
  <div class="wrap">
    <a class="brand" href="/$l/"><img src="/brand.png" alt="Staff Flow" width="205" height="46"></a>
    <nav class="langs" aria-label="Language">$switcher</nav>
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
      <div class="phone"><img src="/img/$dir/1-planning.jpg" alt="${esc(rows('shots')[0][0])}" width="540" height="1200"></div>
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
      ${[for (final (i, c) in rows('shots').indexed) '<figure><img src="/img/$dir/${shots[i]}.jpg" alt="${esc(c[0])}" width="540" height="1200" loading="lazy"><figcaption>${esc(c[0])}<span>${esc(c[1])}</span></figcaption></figure>'].join('\n      ')}
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

<footer>
  <div class="wrap">
    <span>© 2026 Staff Flow</span>
    <span>${[for (final o in langs) '<a href="/$o/" lang="$o">${esc(t[o]!['name'] as String)}</a>'].join(' · ')}</span>
  </div>
</footer>
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
  ${[for (final o in langs) '<link rel="alternate" hreflang="$o" href="$site/$o/">'].join('\n  ')}
  <link rel="icon" type="image/png" href="/favicon.png">
  <link rel="stylesheet" href="/style.css?v=2">
</head>
<body>
<section class="final" style="min-height:100vh;display:grid;place-items:center">
  <div class="wrap">
    <img src="/logo.png" alt="" width="96" height="75" style="margin:0 auto 18px">
    <h2>Staff Flow</h2>
    <div class="cta" style="justify-content:center">
      ${[for (final o in langs) '<a class="btn btn-ghost" href="/$o/" lang="$o">${esc(t[o]!['name'] as String)}</a>'].join('\n      ')}
    </div>
  </div>
</section>
</body>
</html>
''';

void main() {
  for (final l in langs) {
    Directory('www/$l').createSync(recursive: true);
    File('www/$l/index.html').writeAsStringSync(page(l));
  }
  File('www/index.html').writeAsStringSync(root());
  File('www/robots.txt').writeAsStringSync('User-agent: *\nAllow: /\nSitemap: $site/sitemap.xml\n');
  File('www/sitemap.xml').writeAsStringSync('''<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">
${[
    for (final l in langs)
      '  <url><loc>$site/$l/</loc>${[for (final o in langs) '<xhtml:link rel="alternate" hreflang="$o" href="$site/$o/"/>'].join()}</url>',
  ].join('\n')}
</urlset>
''');
  print('site généré : ${langs.join(', ')}');
}
