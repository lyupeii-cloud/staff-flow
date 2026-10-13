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
    ['Personal data', [
      'The company remains responsible for how it uses the data it retrieves (names, hours, absences) and must protect it in its own software. Keep keys secret; revoke a key as soon as it is no longer used.',
    ]],
  ],
};
