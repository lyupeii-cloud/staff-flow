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

const _write = '''POST   /api/v1/ext/shifts           create shifts (draft, or "publish": true)
PATCH  /api/v1/ext/shifts/{id}      edit a shift (back to draft)
DELETE /api/v1/ext/shifts/{id}      delete a shift
POST   /api/v1/ext/publish          publish all drafts
POST   /api/v1/ext/members/import   import employees -> invitations with codes
GET    /api/v1/ext/invites          pending invitations (code, QR link)
PUT    /api/v1/ext/members/{ref}/profile   employee number, position
POST   /api/v1/ext/positions        new position     {"name": "…"}
POST   /api/v1/ext/sites            new site         {"name": "…", "parent": "…"}
POST   /api/v1/ext/news             announcement     {"title", "body", "audience"}
GET    /api/v1/ext/requests         pending requests
POST   /api/v1/ext/requests/{id}/approve | refuse''';

const _writeSample = r'''POST /api/v1/ext/shifts
{
  "publish": false,
  "shifts": [
    {"day": "2026-10-20", "start": "07:00", "end": "15:00",
     "person": "M-0007", "site": "Chantier Nord", "position": "Maçon"}
  ]
}''';

const _mcp = '''Adresse / URL :  https://app.staff-flow.cloud/api/v1/mcp
En-tête / Header : Authorization: Bearer sfk_…

get_company · list_members · get_shifts · get_hours · get_absences
create_shifts · update_shift · delete_shift · publish_schedule
import_employees · list_invitations · set_employee_profile
create_position · create_site · post_announcement
list_pending_requests · decide_request''';

const _hooks = '''schedule.published       planning publié / schedule published
request.created          nouvelle demande / new request
request.decided          demande validée ou refusée / approved or refused
request.cancelled        demande annulée / request cancelled
request.cancel_asked     annulation de congé demandée / leave cancellation asked
request.cancel_decided   annulation de congé décidée / leave cancellation decided
request.ended            indisponibilité terminée / unavailability ended
member.joined            nouveau salarié / new employee
announcement.published   annonce publiée / announcement published''';

const _hookSample = r'''POST https://votre-logiciel.example/staff-flow
Staff-Flow-Event: request.decided
Staff-Flow-Delivery: 6f1c…
Staff-Flow-Signature: t=1792400000,v1=5d2a…

{
  "id": "6f1c…",
  "event": "request.decided",
  "createdAt": "2026-10-13T08:12:00Z",
  "company": {"id": "SF-…", "name": "Boulangerie"},
  "data": {"kind": "leave", "approved": true, "from": "2026-11-02", "to": "2026-11-03",
           "person": {"sfId": "SF-…", "name": "Marie", "employeeNumber": "M-0007"}}
}

v1 = HMAC-SHA256(secret, t + "." + body)   (hex)''';

const apiDocs = <String, List<List<Object>>>{
  'fr': [
    ['À quoi ça sert', [
      'L\'option « accès API » permet à vos logiciels de comptabilité, de paie ou à votre CRM de lire automatiquement le planning publié de votre entreprise, les heures de chacun et les absences validées. Avec l\'option « accès API » (2 € par mois), l\'accès est en lecture seule ; l\'option « API Pro » permet aussi d\'écrire (voir plus bas).',
      'L\'option se prend dans l\'application : Management → Gérer l\'abonnement. Elle est ouverte pendant l\'essai gratuit.',
    ]],
    ['1. Créer une clé', [
      'Dans l\'application, le propriétaire (ou un responsable à qui il a confié la gestion de l\'abonnement) ouvre Management → Accès API → Nouvelle clé, et lui donne un nom (par exemple « Logiciel de paie »). La clé complète n\'est affichée qu\'une seule fois : copiez-la dans votre logiciel. Vous pouvez la révoquer à tout moment ; 10 clés au plus par entreprise.',
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
    ['API Pro : écrire dans Staff Flow', [
      'Avec l\'option « API Pro » (9 € par mois, sans remise, avec un abonnement payé ; pas pendant l\'essai ni pendant la période de grâce), vos logiciels envoient aussi des plannings, des salariés, des postes et sites, des annonces, et valident les demandes.',
      'Chaque clé a ses droits, choisis à sa création : lecture, planning, publier, salariés, postes et sites, annonces, demandes. Seuls le patron et les responsables qui gèrent l\'abonnement créent et révoquent les clés (10 au plus). « API Pro » n\'est jamais incluse : ni pendant l\'essai, ni pour une entreprise offerte, ni au-delà de 100 salariés. Elle se résilie comme toute option : elle reste active jusqu\'à la fin de la période payée.',
      ['pre', _write],
      'Les services envoyés arrivent en brouillon : les responsables les voient, les adaptent, puis publient. Avec le droit « publier » et « publish »: true, ils sont publiés tout de suite. Une personne se désigne par son identifiant SF ou son matricule ; un site ou un poste par son nom ou son id. Heures : « HH:MM » ou minutes depuis minuit.',
      ['pre', _writeSample],
      'Erreurs : 403 si la clé n\'a pas le droit demandé, 402 si l\'option « API Pro » n\'est pas active, 400 si une personne, un site ou une heure est inconnu (rien n\'est alors créé pour ce service). Chaque écriture est notée dans l\'historique de l\'entreprise avec le nom de la clé.',
    ]],
    ['Connecteur MCP : Staff Flow dans votre assistant', [
      'Les assistants compatibles MCP (Model Context Protocol), comme Claude, se branchent directement sur Staff Flow. Vous écrivez par exemple : « Mets Marie à la caisse lundi de 8 h à 16 h » ou « Combien d\'heures a fait l\'équipe en septembre ? ».',
      ['pre', _mcp],
      'Ajoutez un connecteur personnalisé avec cette adresse et une clé API. L\'assistant ne voit que les outils permis par les droits de la clé : lecture avec l\'option « accès API », écriture avec « API Pro ». Les services créés arrivent en brouillon, sauf avec le droit « publier ». Chaque action est notée dans l\'historique avec le nom de la clé.',
    ]],
    ['Webhooks : Staff Flow prévient vos logiciels', [
      'Avec l\'option « API Pro », Staff Flow envoie tout seul un message (POST en JSON) à l\'adresse de votre logiciel quand quelque chose se passe. Plus besoin d\'interroger l\'API en boucle.',
      'Dans l\'application : Management → Accès API → Webhooks. Le patron et les responsables qui gèrent l\'abonnement ajoutent jusqu\'à 5 adresses (https), choisissent les événements, et peuvent faire un envoi d\'essai.',
      ['pre', _hooks],
      ['pre', _hookSample],
      'Chaque envoi est signé avec le secret donné à la création (affiché une seule fois) : recalculez la signature et comparez-la, puis refusez les horodatages de plus de 5 minutes. Répondez par un code 2xx en moins de 10 secondes.',
      'En cas d\'échec, Staff Flow réessaie après 1 min, 5 min, 30 min, 2 h, 6 h et 12 h. Après 10 envois abandonnés d\'affilée, l\'adresse est coupée ; vous la réactivez dans l\'application. Les personnes sont désignées par leur identifiant SF et leur matricule, jamais par leur adresse e-mail. Option arrêtée ou période de grâce : plus aucun envoi.',
    ]],
    ['Journaux et alertes', [
      'Chaque appel de vos clés (lecture, écriture, assistant MCP) et chaque envoi de webhook est noté : date, clé, action en clair, résultat, durée, adresse IP. Pour une modification, l\'avant et l\'après (« début 08:00 → 09:00 »).',
      'Dans l\'application : Management → Accès API → Journaux. Un mois à la fois (glissez pour changer), recherche (personne, matricule, action) et filtres (clé, origine, lecture ou écriture, réussi ou échec). Réservé au patron et aux responsables qui gèrent l\'abonnement.',
      'Les 12 derniers mois restent en ligne ; les mois plus anciens sont archivés automatiquement, toujours consultables et cherchables (« chercher dans tout l\'historique »). Chaque année se télécharge en ZIP (un fichier CSV par mois, lisible dans Excel). Les journaux sont supprimés après 3 ans.',
      'Le patron est prévenu si une clé échoue 10 fois en une heure, ou si elle est utilisée depuis une nouvelle adresse IP (signe possible d\'une clé volée). Chaque clé affiche ses appels du jour et du mois. Les droits d\'une clé se modifient sans changer la clé.',
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
      'У застосунку власник компанії (або керівник, якому доручено підписку) відкриває Управління → Доступ до API → Новий ключ і дає йому назву (наприклад, «Програма зарплати»). Повний ключ показується лише один раз: скопіюйте його у свою програму. Ключ можна будь-коли відкликати; не більше 10 ключів на компанію.',
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
    ['API Pro: запис у Staff Flow', [
      'З опцією «API Pro» (9 € на місяць, без знижки, з оплаченою підпискою; не під час пробного періоду й не в пільговий період) ваші програми також надсилають графіки, працівників, посади й об\'єкти, оголошення та погоджують запити.',
      'Кожен ключ має свої права, вибрані під час створення: читання, графік, публікація, працівники, посади й об\'єкти, оголошення, запити. Лише власник і керівники, яким доручено керування підпискою, створюють і відкликають ключі (не більше 10). «API Pro» ніколи не входить у ціну: ні під час пробного періоду, ні для безкоштовної компанії, ні понад 100 працівників. Її можна скасувати, як будь-яку опцію: вона діє до кінця оплаченого періоду.',
      ['pre', _write],
      'Надіслані зміни потрапляють у чернетку: керівники бачать їх, адаптують, а потім публікують. З правом «публікація» та «publish»: true вони публікуються одразу. Людину вказують ідентифікатором SF або табельним номером; об\'єкт чи посаду — назвою або id. Час: «ГГ:ХХ» або хвилини від півночі.',
      ['pre', _writeSample],
      'Помилки: 403, якщо ключ не має потрібного права; 402, якщо опція «API Pro» не активна; 400, якщо людина, об\'єкт чи час невідомі. Кожен запис фіксується в історії компанії з назвою ключа.',
    ]],
    ['Конектор MCP: Staff Flow у вашому асистенті', [
      'Асистенти з підтримкою MCP (Model Context Protocol), як-от Claude, підключаються безпосередньо до Staff Flow. Ви пишете, наприклад: «Постав Марію на касу в понеділок з 8:00 до 16:00» або «Скільки годин відпрацювала команда у вересні?».',
      ['pre', _mcp],
      'Додайте власний конектор із цією адресою та ключем API. Асистент бачить лише інструменти, дозволені правами ключа: читання з опцією «Доступ до API», запис з «API Pro». Створені зміни потрапляють у чернетку, якщо немає права «публікація». Кожна дія фіксується в історії з назвою ключа.',
    ]],
    ['Вебхуки: Staff Flow сам повідомляє ваші програми', [
      'З опцією «API Pro» Staff Flow сам надсилає повідомлення (POST у JSON) на адресу вашої програми, коли щось відбувається. Більше не потрібно постійно опитувати API.',
      'У застосунку: Управління → Доступ до API → Вебхуки. Власник і керівники, яким доручено підписку, додають до 5 адрес (https), вибирають події та можуть надіслати перевірку.',
      ['pre', _hooks],
      ['pre', _hookSample],
      'Кожне надсилання підписане секретом, виданим під час створення (показується лише раз): обчисліть підпис і порівняйте, а мітки часу старші за 5 хвилин відхиляйте. Відповідайте кодом 2xx протягом 10 секунд.',
      'У разі помилки Staff Flow повторює через 1 хв, 5 хв, 30 хв, 2 год, 6 год і 12 год. Після 10 невдалих надсилань поспіль адресу вимикають; увімкнути її можна в застосунку. Людей позначено ідентифікатором SF і табельним номером, ніколи електронною адресою. Опцію припинено або пільговий період: надсилань більше немає.',
    ]],
    ['Журнали та сповіщення', [
      'Кожен виклик ваших ключів (читання, запис, асистент MCP) і кожне надсилання вебхука записується: дата, ключ, зрозуміла дія, результат, тривалість, IP-адреса. Для змін — до і після («початок 08:00 → 09:00»).',
      'У застосунку: Управління → Доступ до API → Журнали. Один місяць за раз (гортайте, щоб змінити), пошук (людина, табельний номер, дія) і фільтри (ключ, джерело, читання чи запис, успіх чи помилка). Лише для власника та керівників, яким доручено підписку.',
      'Останні 12 місяців доступні онлайн; старіші місяці автоматично архівуються, але їх можна переглядати й шукати («шукати в усій історії»). Кожен рік можна завантажити в ZIP (CSV-файл на місяць, відкривається в Excel). Журнали видаляються через 3 роки.',
      'Власника повідомляють, якщо ключ дав збій 10 разів за годину або його використано з нової IP-адреси (можлива крадіжка ключа). Кожен ключ показує виклики за день і за місяць. Права ключа змінюються без зміни самого ключа.',
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
      'In the app, the company owner (or a manager entrusted with the subscription) opens Management → API access → New key and gives it a name (for example “Payroll software”). The full key is shown only once: copy it into your software. You can revoke it at any time; 10 keys at most per company.',
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
    ['API Pro: writing into Staff Flow', [
      'With the “API Pro” option (€9 a month, no discount, with a paid subscription; not during the trial or the grace period), your software can also send schedules, employees, positions and sites, announcements, and decide on requests.',
      'Each key has its own permissions, chosen when it is created: read, schedule, publish, employees, positions and sites, announcements, requests. Only the owner and managers entrusted with the subscription create and revoke keys (10 at most). “API Pro” is never included: not during the trial, not for a complimentary company, not above 100 employees. It can be cancelled like any option: it stays active until the end of the paid period.',
      ['pre', _write],
      'Shifts you send arrive as drafts: managers see them, adjust them, then publish. With the “publish” permission and "publish": true, they are published at once. A person is given by their SF ID or employee number; a site or position by its name or id. Times: “HH:MM” or minutes since midnight.',
      ['pre', _writeSample],
      'Errors: 403 if the key lacks the permission, 402 if the “API Pro” option isn\'t active, 400 if a person, site or time is unknown. Every write is logged in the company history with the key\'s name.',
    ]],
    ['MCP connector: Staff Flow in your assistant', [
      'Assistants that support MCP (Model Context Protocol), such as Claude, connect straight to Staff Flow. You write, for example: “Put Marie on the till Monday from 8 to 4” or “How many hours did the team work in September?”.',
      ['pre', _mcp],
      'Add a custom connector with this address and an API key. The assistant only sees the tools the key\'s permissions allow: reading with the “API access” option, writing with “API Pro”. Shifts it creates arrive as drafts unless the key has the “publish” permission. Every action is logged in the history with the key\'s name.',
    ]],
    ['Webhooks: Staff Flow notifies your software', [
      'With the “API Pro” option, Staff Flow sends a message on its own (JSON POST) to your software\'s address when something happens. No more polling the API.',
      'In the app: Management → API access → Webhooks. The owner and managers entrusted with the subscription add up to 5 addresses (https), choose the events, and can send a test delivery.',
      ['pre', _hooks],
      ['pre', _hookSample],
      'Every delivery is signed with the secret given at creation (shown only once): recompute the signature and compare, then reject timestamps older than 5 minutes. Answer with a 2xx code within 10 seconds.',
      'On failure, Staff Flow retries after 1 min, 5 min, 30 min, 2 h, 6 h and 12 h. After 10 dropped deliveries in a row, the address is turned off; you turn it back on in the app. People are identified by their SF ID and employee number, never by email address. Option ended or grace period: nothing is sent any more.',
    ]],
    ['Logs and alerts', [
      'Every call from your keys (read, write, MCP assistant) and every webhook delivery is logged: date, key, plain-language action, result, duration, IP address. For an edit, the before and after (“start 08:00 → 09:00”).',
      'In the app: Management → API access → Logs. One month at a time (swipe to change), search (person, employee number, action) and filters (key, source, read or write, succeeded or failed). For the owner and managers entrusted with the subscription.',
      'The last 12 months stay online; older months are archived automatically and can still be browsed and searched (“search the whole history”). Each year can be downloaded as a ZIP (one CSV file per month, opens in Excel). Logs are deleted after 3 years.',
      'The owner is alerted if a key fails 10 times in one hour, or is used from a new IP address (a possible sign of a stolen key). Each key shows its calls today and this month. A key\'s permissions can be changed without changing the key.',
    ]],
    ['Personal data', [
      'The company remains responsible for how it uses the data it retrieves (names, hours, absences) and must protect it in its own software. Keep keys secret; revoke a key as soon as it is no longer used.',
    ]],
  ],
};
