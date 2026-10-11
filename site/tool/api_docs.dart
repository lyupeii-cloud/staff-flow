/// Documentation de l'accès API (option payante), en français, ukrainien et
/// anglais. Un paragraphe est un texte ; `['pre', …]` est un bloc de code.
library;

const apiTitles = {
  'fr': 'Accès API : planning, heures et absences',
  'uk': 'Доступ до API: графік, години й відсутності',
  'en': 'API access: schedule, hours and absences',
};

const _curl = r'''curl -H "Authorization: Bearer sfk_xxxxxxxx_yyyyyyyy…" \
  "https://app.staff-flow.cloud/api/v1/ext/shifts?from=2026-10-01&to=2026-10-31"''';

const _sample = r'''{
  "data": [
    {
      "id": "6c1f…", "day": "2026-10-06", "start": "08:00", "end": "16:00",
      "minutes": 480, "userId": "a41e…", "userName": "Olena",
      "siteId": "…", "site": "Centre", "positionId": "…", "position": "Barista",
      "note": null
    }
  ]
}''';

const _endpoints = '''GET /api/v1/ext/company     company, sites, positions
GET /api/v1/ext/members     people (current and former), role, dates
GET /api/v1/ext/shifts      published shifts         ?from=&to=&format=csv
GET /api/v1/ext/totals      published hours/person   ?from=&to=&format=csv
GET /api/v1/ext/absences    approved leave and unavailability  ?from=&to=''';

const apiDocs = <String, List<List<Object>>>{
  'fr': [
    ['À quoi ça sert', [
      'L\'option « accès API » permet à vos logiciels de comptabilité, de paie ou à votre CRM de lire automatiquement le planning publié de votre entreprise, les heures de chacun et les absences validées. L\'accès est en lecture seule : rien ne peut être modifié par l\'API.',
      'L\'option se prend dans l\'application : Management → Gérer l\'abonnement. Elle est ouverte pendant l\'essai gratuit.',
    ]],
    ['1. Créer une clé', [
      'Dans l\'application, le propriétaire de l\'entreprise ouvre Management → Accès API → Nouvelle clé, et lui donne un nom (par exemple « Logiciel de paie »). La clé complète n\'est affichée qu\'une seule fois : copiez-la dans votre logiciel. Vous pouvez la révoquer à tout moment ; 10 clés au plus par entreprise.',
    ]],
    ['2. Appeler l\'API', [
      'Envoyez la clé dans l\'en-tête « Authorization: Bearer … » (ou « X-Api-Key »). Toutes les adresses commencent par https://app.staff-flow.cloud/api/v1/ext/.',
      ['pre', _curl],
    ]],
    ['3. Les adresses', [
      ['pre', _endpoints],
      'Période : « from » et « to » au format AAAA-MM-JJ. Sans « from », depuis la création de l\'entreprise ; sans « to », jusqu\'à aujourd\'hui ; 5 ans au plus par appel.',
      'Format : JSON par défaut ({"data": […]}) ; ajoutez « format=csv » pour un fichier CSV (séparateur « ; », lisible par Excel).',
      'Seul le planning publié est transmis (ce que voient les salariés), jamais les brouillons.',
    ]],
    ['4. Exemple de réponse', [
      ['pre', _sample],
    ]],
    ['5. Erreurs', [
      '401 : clé absente, fausse ou révoquée. 402 : l\'option « accès API » n\'est pas active (abonnement sans l\'option). 400 : dates invalides.',
    ]],
    ['Données personnelles', [
      'L\'entreprise reste responsable de l\'usage des données qu\'elle récupère (noms, horaires, absences) et doit les protéger dans ses propres logiciels. Gardez les clés secrètes ; révoquez une clé dès qu\'elle ne sert plus.',
    ]],
  ],
  'uk': [
    ['Навіщо це', [
      'Опція «доступ до API» дає змогу вашим програмам бухгалтерії, зарплати чи CRM автоматично читати опублікований графік компанії, години кожного працівника й підтверджені відсутності. Доступ лише для читання: через API нічого змінити не можна.',
      'Опцію можна підключити в застосунку: Управління → Керувати підпискою. Під час безкоштовного пробного періоду вона доступна.',
    ]],
    ['1. Створіть ключ', [
      'У застосунку власник компанії відкриває Управління → Доступ до API → Новий ключ і дає йому назву (наприклад, «Програма зарплати»). Повний ключ показується лише один раз: скопіюйте його у свою програму. Ключ можна будь-коли відкликати; не більше 10 ключів на компанію.',
    ]],
    ['2. Виклик API', [
      'Передайте ключ у заголовку «Authorization: Bearer …» (або «X-Api-Key»). Усі адреси починаються з https://app.staff-flow.cloud/api/v1/ext/.',
      ['pre', _curl],
    ]],
    ['3. Адреси', [
      ['pre', _endpoints],
      'Період: «from» і «to» у форматі РРРР-ММ-ДД. Без «from» — від створення компанії; без «to» — до сьогодні; не більше 5 років за один запит.',
      'Формат: JSON за замовчуванням ({"data": […]}); додайте «format=csv», щоб отримати файл CSV (роздільник «;», відкривається в Excel).',
      'Передається лише опублікований графік (те, що бачать працівники), ніколи не чернетки.',
    ]],
    ['4. Приклад відповіді', [
      ['pre', _sample],
    ]],
    ['5. Помилки', [
      '401: ключа немає, він неправильний або відкликаний. 402: опція «доступ до API» не активна (підписка без опції). 400: неправильні дати.',
    ]],
    ['Персональні дані', [
      'Компанія відповідає за використання отриманих даних (імена, години, відсутності) і має захищати їх у своїх програмах. Зберігайте ключі в таємниці; відкликайте ключ, щойно він більше не потрібен.',
    ]],
  ],
  'en': [
    ['What it is for', [
      'The “API access” option lets your accounting, payroll or CRM software automatically read your company\'s published schedule, everyone\'s hours and approved absences. Access is read-only: nothing can be changed through the API.',
      'Add the option in the app: Management → Manage subscription. It is available during the free trial.',
    ]],
    ['1. Create a key', [
      'In the app, the company owner opens Management → API access → New key and gives it a name (for example “Payroll software”). The full key is shown only once: copy it into your software. You can revoke it at any time; 10 keys at most per company.',
    ]],
    ['2. Call the API', [
      'Send the key in the “Authorization: Bearer …” header (or “X-Api-Key”). All addresses start with https://app.staff-flow.cloud/api/v1/ext/.',
      ['pre', _curl],
    ]],
    ['3. Endpoints', [
      ['pre', _endpoints],
      'Period: “from” and “to” as YYYY-MM-DD. Without “from”, since the company was created; without “to”, up to today; 5 years at most per call.',
      'Format: JSON by default ({"data": […]}); add “format=csv” for a CSV file (“;” separator, opens in Excel).',
      'Only the published schedule is returned (what employees see), never drafts.',
    ]],
    ['4. Sample response', [
      ['pre', _sample],
    ]],
    ['5. Errors', [
      '401: missing, wrong or revoked key. 402: the “API access” option is not active (subscription without the option). 400: invalid dates.',
    ]],
    ['Personal data', [
      'The company remains responsible for how it uses the data it retrieves (names, hours, absences) and must protect it in its own software. Keep keys secret; revoke a key as soon as it is no longer used.',
    ]],
  ],
};
