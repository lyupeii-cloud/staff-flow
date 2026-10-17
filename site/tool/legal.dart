/// Conditions d'utilisation et de vente (`terms`) et politique de
/// confidentialité (`privacy`), en français, ukrainien et anglais.
/// Chaque section : un titre et ses paragraphes.
library;

const legalUpdated = {'fr': 'Version du 17 octobre 2026', 'uk': 'Редакція від 17 жовтня 2026 р.', 'en': 'Version of 17 October 2026'};

const legalTitles = {
  'fr': {'terms': 'Conditions d\'utilisation et de vente', 'privacy': 'Politique de confidentialité'},
  'uk': {'terms': 'Умови використання та продажу', 'privacy': 'Політика конфіденційності'},
  'en': {'terms': 'Terms of use and sale', 'privacy': 'Privacy policy'},
};

const legal = <String, Map<String, List<List<Object>>>>{
  'fr': {
    'terms': [
      ['1. Éditeur', [
        'Staff Flow est édité par Vercane, nom commercial de ФОП Дютертре Ремі Ів (FOP Dutertre Remy Yves), entrepreneur individuel (фізична особа-підприємець) enregistré en Ukraine le 13 octobre 2026. Numéro fiscal (РНОКПП) : 2938925032. Adresse : 112A Saltivske shose, apt. 45, Kharkiv, 61110, Ukraine (Салтівське шосе, буд. 112А, кв. 45, м. Харків, 61110). Payeur de l\'impôt unique, 3e groupe (5 %), non assujetti à la TVA.',
        'Contact : contact@staff-flow.cloud.',
      ]],
      ['2. Le service', [
        'Staff Flow permet à une entreprise de créer et partager le planning de son équipe : services, échanges, congés et indisponibilités, fil d\'actualités, importation des salariés, exports, notifications. Il fonctionne sur Android et dans un navigateur (https://app.staff-flow.cloud).',
        'Les alertes « légales » proposées (durées de travail, repos…) sont des repères indicatifs : l\'employeur reste seul responsable du respect du droit du travail qui s\'applique à lui.',
        'Options pour les entreprises : accès API en lecture (1 clé) et « API Pro » (lecture et écriture, 1 ou 10 clés, webhooks, journaux des appels, connecteur MCP pour les assistants comme Claude). L\'entreprise choisit les logiciels et assistants qu\'elle branche, reste responsable de ce qu\'ils font avec ses clés et des données qu\'ils reçoivent, et protège ses clés comme des mots de passe. Pour la stabilité du service, le nombre d\'appels est limité (par minute et par jour) ; les limites en vigueur figurent dans la documentation de l\'API.',
      ]],
      ['3. Compte', [
        'La connexion se fait avec un compte Google, ou sans Google avec une application d\'authentification (2FA) : identifiant Staff Flow ou matricule, puis un code à 6 chiffres ; des codes de secours sont donnés à l\'activation. Créer une entreprise demande un compte Google. Chaque personne a un seul compte Staff Flow, identifié par un numéro (SF-…), valable dans toutes ses entreprises. Il faut avoir au moins 16 ans.',
        'Vous êtes responsable de l\'accès à votre compte Google. Vous pouvez relier un compte Telegram vérifié : il sert à confirmer votre identité, notamment pour rattacher votre compte à un autre compte Google (commande /changegoogle du bot). Sans Telegram, le patron ou un responsable peut créer un lien à usage unique pour ce changement.',
        'Chacun est responsable de la sécurité de son téléphone, de son ordinateur, de son compte Google et de son compte Telegram, et de ce qui est fait depuis ceux-ci. Vercane ne peut être tenu responsable d\'un usage frauduleux résultant de leur perte, de leur vol, d\'un code communiqué à un tiers ou de leur piratage. Nous ferons toutefois notre possible pour vous aider : écrivez à contact@staff-flow.cloud.',
        'Vous pouvez à tout moment exporter vos données et supprimer votre compte depuis « Mon profil ». Un « Ghost » anonyme reste dans l\'historique des entreprises (services passés, demandes de congé…) pour qu\'elles puissent retracer les évènements.',
      ]],
      ['4. Rôles et responsabilité de l\'entreprise', [
        'Dans chaque entreprise, le propriétaire et les responsables organisent le planning ; les salariés et extras le consultent et font leurs demandes.',
        'L\'entreprise est responsable des informations qu\'elle saisit sur son équipe et de leur conformité au droit (notamment au RGPD pour les entreprises situées dans l\'Union européenne). Pour ces données, Vercane agit pour le compte de l\'entreprise, comme sous-traitant.',
      ]],
      ['5. Prix et abonnement', [
        'Seul le propriétaire d\'une entreprise paie. Les salariés, responsables et extras utilisent l\'application gratuitement.',
        'Les achats (abonnement, places, options) se font uniquement sur la version web de Staff Flow (https://app.staff-flow.cloud). L\'application Android permet d\'utiliser les droits achetés, mais ne propose aucun achat.',
        'Le prix dépend du nombre de places choisi (salariés et responsables, sans le propriétaire ni les extras), par tranches de 10 jusqu\'à 5000 ; une entreprise commence avec 10 places. Au-delà des places payées, une marge de 5 % est tolérée, puis aucun ajout n\'est possible sans acheter des places, payées comme une option ajoutée en cours d\'abonnement ; la grille en vigueur est affichée dans l\'application et sur le site. Les prix sont indiqués en euros, toutes taxes comprises.',
        'Chaque compte Google bénéficie une seule fois d\'un essai gratuit de 2 jours à la création de sa première entreprise.',
        'L\'abonnement couvre des mois civils pleins. Au premier paiement (ou après une interruption), la fin du mois en cours est payée au prorata des jours restants, arrondie au centime supérieur, puis la période choisie commence le 1er du mois suivant : 1 mois (paiement mensuel) ou 12 mois au prix de 10 (paiement annuel). Les options (« accès API », « API Pro », « sites en cascade » au-delà de trois niveaux de sites) sont facturées sans remise. L\'accès API en lecture permet 1 clé ; « API Pro » permet 1 ou 10 clés selon la formule choisie ; elle n\'est jamais incluse (ni pendant l\'essai, ni pour une entreprise offerte). Les clés API d\'une option arrêtée cessent de fonctionner, puis sont supprimées 30 jours plus tard ; le client est prévenu 7 jours avant. Une option ajoutée en cours d\'abonnement se paie seule : le mois en cours en entier, puis chaque mois jusqu\'à la fin de la période déjà payée (mois offerts de l\'année compris) ; elle est ensuite reprise dans les renouvellements. Une option peut être retirée à tout moment : elle n\'est plus renouvelée et reste active jusqu\'à la fin de la période déjà payée, sans remboursement. Le détail est affiché avant chaque paiement, et chaque paiement a sa facture.',
        'Un renouvellement prolonge la période déjà payée. Le prix est calculé avec l\'effectif au moment du paiement.',
        'Le paiement est traité par un prestataire de paiement ; Staff Flow ne reçoit jamais vos données de carte. Les factures sont disponibles au téléchargement dans l\'application.',
        'Un changement de prix est annoncé au moins 30 jours à l\'avance et s\'applique au renouvellement suivant.',
      ]],
      ['6. Fin de l\'abonnement', [
        'Si l\'abonnement n\'est pas renouvelé, l\'entreprise passe en lecture seule pendant 15 jours, avec des rappels, et ses clés API ne répondent plus ; le propriétaire peut payer à tout moment pour tout retrouver. Ensuite, l\'entreprise et ses données sont supprimées.',
        'Les factures sont conservées pendant la durée légale (10 ans) et restent téléchargeables par le dernier propriétaire. Un ancien propriétaire qui a supprimé son compte peut les demander à contact@staff-flow.cloud en justifiant qu\'il était propriétaire de l\'entreprise.',
        'Une période payée n\'est pas remboursée, sauf lorsque la loi l\'impose. Si la loi de votre pays vous accorde un droit de rétractation, vous pouvez l\'exercer dans les 14 jours suivant le paiement en écrivant à contact@staff-flow.cloud ; le service ayant commencé à votre demande, la part correspondant à la période déjà écoulée reste due.',
      ]],
      ['7. Publicité', [
        'Sur Android, une petite bannière publicitaire pourra être affichée aux personnes qui ne sont propriétaires d\'aucune entreprise ; elle pourra être retirée par un achat unique. Les plannings et annonces ne sont jamais utilisés pour la publicité.',
      ]],
      ['8. Bon usage', [
        'Vous vous engagez à utiliser Staff Flow conformément à la loi, à ne pas publier de contenus illicites ou blessants, à ne pas tenter d\'accéder aux données d\'autrui et à ne pas perturber le service. En cas de manquement grave, l\'accès peut être suspendu.',
      ]],
      ['9. Disponibilité et responsabilité', [
        'Nous faisons notre possible pour que le service soit disponible et fiable, sans pouvoir garantir l\'absence d\'interruption (maintenance, panne, réseau). Le planning déjà reçu reste consultable sans connexion.',
        'Dans les limites permises par la loi, la responsabilité de Vercane est limitée aux sommes payées au cours des 12 derniers mois et exclut les dommages indirects. Rien dans ces conditions ne limite une responsabilité que la loi interdit de limiter.',
      ]],
      ['10. Propriété intellectuelle', [
        'L\'application, sa marque et son contenu appartiennent à Vercane. Les informations que vous saisissez restent les vôtres ou celles de votre entreprise.',
      ]],
      ['11. Modifications', [
        'Ces conditions peuvent évoluer. Les changements importants sont annoncés dans l\'application au moins 30 jours avant de s\'appliquer.',
      ]],
      ['12. Droit applicable et litiges', [
        'Ces conditions sont régies par le droit ukrainien. Si vous êtes un consommateur, vous gardez la protection des règles impératives de votre pays de résidence. En cas de difficulté, écrivez d\'abord à contact@staff-flow.cloud pour trouver une solution amiable.',
      ]],
    ],
    'privacy': [
      ['1. Qui traite vos données', [
        'Vercane, éditeur de Staff Flow (contact@staff-flow.cloud), est responsable des données de votre compte.',
        'Pour les informations qu\'une entreprise saisit sur son équipe (plannings, absences, noms donnés…), l\'entreprise est responsable du traitement et Vercane agit pour son compte, comme sous-traitant.',
      ]],
      ['2. Données traitées', [
        'Compte : nom, adresse e-mail, photo, identifiant et langue de votre compte Google ; votre numéro Staff Flow (SF-…) et le nom que vous choisissez.',
        'Entreprises : nom, fuseau horaire, image, rôles, sites et postes.',
        'Planning et demandes : services, échanges, congés et indisponibilités (aucun motif médical n\'est demandé), historique des modifications.',
        'Fil d\'actualités : annonces publiées, destinataires, lectures, traductions demandées.',
        'Importation : nom, matricule et poste fournis par l\'employeur pour inviter une personne ; une invitation non utilisée est effacée au bout de 90 jours, et la personne n\'est ajoutée qu\'avec son accord. Compte sans Google : la clé de l\'application d\'authentification est gardée chiffrée, les codes de secours seulement sous forme d\'empreinte, et les essais de connexion échoués 24 heures au plus.',
        'Telegram (si vous le reliez) : identifiant de conversation et nom d\'utilisateur.',
        'Appareils : jeton de notification, plateforme et langue de l\'appareil.',
        'Facturation : nom de l\'entreprise, nom du propriétaire, montants et périodes. Nous ne recevons jamais vos données de carte bancaire.',
        'Données techniques : journaux du serveur (dont l\'adresse IP) et journal des actions, pour la sécurité.',
        'Clés API et journaux des appels : nom et droits des clés ; pour chaque appel, la date, l\'action, le résultat, la durée et l\'adresse IP du logiciel appelant ; adresses des webhooks choisies par l\'entreprise.',
      ]],
      ['3. Pourquoi', [
        'Fournir le service que vous utilisez (exécution du contrat) : planning, demandes, annonces, invitations, notifications.',
        'Sécurité, prévention des abus et vérification d\'identité (intérêt légitime).',
        'Facturation et comptabilité (obligation légale).',
        'Vos données ne sont jamais vendues et ne servent pas à la publicité.',
      ]],
      ['4. Qui y a accès', [
        'Les membres de vos entreprises voient ce que leur rôle permet : planning, noms, et votre Telegram seulement si vous choisissez de l\'afficher. Votre adresse e-mail et votre compte Google ne leur sont jamais montrés.',
        'Les logiciels et assistants que votre entreprise choisit de brancher (API, webhooks, connecteur MCP) reçoivent les données que ses clés autorisent, sous la responsabilité de l\'entreprise.',
        'Nos prestataires techniques : OVHcloud (hébergement du serveur), Google (connexion et notifications Firebase Cloud Messaging), Telegram (si vous le reliez), le prestataire de paiement lors d\'un paiement, et un prestataire de stockage (Google Drive) pour une copie des sauvegardes, chiffrée et illisible sans notre clé.',
        'La traduction des annonces se fait sur notre propre serveur : elles ne sont pas envoyées à un service de traduction extérieur.',
      ]],
      ['5. Où', [
        'Le serveur de Staff Flow est actuellement situé en Australie (OVHcloud). Pour les personnes situées dans l\'Union européenne, il s\'agit d\'un transfert de données hors de l\'Union européenne.',
      ]],
      ['6. Combien de temps', [
        'Compte : tant qu\'il existe. Supprimé « en fantôme », il est conservé pour que vous puissiez revenir ; effacé définitivement, vos données personnelles sont effacées aussitôt et il ne reste qu\'un « Ghost » anonyme dans l\'historique des entreprises.',
        'Entreprise : jusqu\'à sa suppression, au plus tard 15 jours après la fin de son abonnement.',
        'Factures : 10 ans (obligation légale).',
        'Sauvegardes chiffrées : 30 jours. Journaux des clés API : 12 mois en ligne, puis archivés, supprimés après 3 ans. Clés API d\'une option arrêtée : supprimées après 30 jours. Invitations non utilisées : 90 jours. Essais de connexion échoués : 24 heures. Journaux techniques du serveur : durée limitée, pour la sécurité.',
      ]],
      ['7. Vos droits', [
        'Vous pouvez accéder à vos données et les récupérer (« Mon profil » → « Exporter mes données »), les corriger (nom), et supprimer votre compte (« Mon profil » → « Supprimer mon compte »). Vous pouvez aussi vous opposer à un traitement ou en demander la limitation en écrivant à contact@staff-flow.cloud.',
        'Pour les données saisies par une entreprise, adressez-vous d\'abord à elle ; nous l\'aiderons à répondre.',
        'Vous pouvez saisir l\'autorité de protection des données de votre pays (en France : la CNIL ; en Ukraine : le Commissaire aux droits de l\'homme du Parlement).',
      ]],
      ['8. Sécurité', [
        'Connexions chiffrées (HTTPS), accès selon le rôle, liens de téléchargement valables quelques minutes, vérification par Telegram pour changer de compte Google, application d\'authentification (2FA) avec blocage après 3 codes erronés, secrets 2FA et clés API conservés chiffrés ou sous forme d\'empreinte, webhooks signés, nombre d\'essais et d\'appels limité, sauvegardes chiffrées.',
      ]],
      ['9. Stockage sur l\'appareil', [
        'L\'application garde sur votre appareil votre session et une copie du planning, pour fonctionner sans réseau. Sur Android, la session est gardée dans le coffre chiffré du téléphone et exclue des sauvegardes. Ni l\'application ni le site n\'utilisent de traceur publicitaire ou de mesure d\'audience.',
      ]],
      ['10. Modifications', [
        'Cette politique peut évoluer ; les changements importants sont annoncés dans l\'application.',
      ]],
    ],
  },
  'uk': {
    'terms': [
      ['1. Видавець', [
        'Staff Flow видає Vercane — комерційна назва ФОП Дютертре Ремі Ів, фізичної особи-підприємця, зареєстрованої в Україні 13 жовтня 2026 р. РНОКПП: 2938925032. Адреса: 61110, Харківська обл., м. Харків, Салтівське шосе, буд. 112А, кв. 45. Платник єдиного податку 3 групи (5 %), не є платником ПДВ.',
        'Контакт: contact@staff-flow.cloud.',
      ]],
      ['2. Сервіс', [
        'Staff Flow дає змогу компанії складати й поширювати графік своєї команди: зміни, обміни, відпустки й недоступність, стрічка новин, імпорт працівників, експорт, сповіщення. Працює на Android і в браузері (https://app.staff-flow.cloud).',
        'Опції для компаній: доступ до API для читання (1 ключ) і «API Pro» (читання й запис, 1 або 10 ключів, вебхуки, журнали викликів, конектор MCP для асистентів, як-от Claude). Компанія сама вибирає програми й асистентів, які підключає, відповідає за те, що вони роблять з її ключами, і за дані, які вони отримують, та зберігає ключі як паролі. Для стабільності сервісу кількість викликів обмежена (за хвилину й за день); чинні обмеження наведено в документації API.',
        'Запропоновані «юридичні» попередження (тривалість роботи, відпочинок тощо) мають лише орієнтовний характер: роботодавець сам відповідає за дотримання трудового законодавства, що на нього поширюється.',
      ]],
      ['3. Обліковий запис', [
        'Вхід здійснюється через обліковий запис Google або без Google — із застосунком автентифікації (2FA): ідентифікатор Staff Flow чи табельний номер, потім 6-значний код; резервні коди видаються під час активації. Для створення компанії потрібен обліковий запис Google. Кожна людина має один обліковий запис Staff Flow з номером (SF-…), чинним в усіх її компаніях. Користувачеві має бути щонайменше 16 років.',
        'Ви відповідаєте за доступ до свого облікового запису Google. Можна прив\'язати підтверджений Telegram: він слугує для підтвердження особи, зокрема щоб прив\'язати обліковий запис до іншого облікового запису Google (команда бота /changegoogle). Без Telegram власник або керівник може створити одноразове посилання для такої зміни.',
        'Кожен відповідає за безпеку свого телефона, комп\'ютера, облікового запису Google і Telegram, а також за дії, виконані з них. Vercane не несе відповідальності за шахрайське використання внаслідок їх втрати, крадіжки, передачі коду третій особі чи зламу. Проте ми зробимо все можливе, щоб допомогти: пишіть на contact@staff-flow.cloud.',
        'Будь-коли можна експортувати свої дані й видалити обліковий запис у розділі «Мій профіль». В історії компаній залишається анонімний «Ghost» (минулі зміни, заяви на відпустку тощо), щоб вони могли відстежити події.',
      ]],
      ['4. Ролі та відповідальність компанії', [
        'У кожній компанії власник і керівники організовують графік; працівники й тимчасові працівники переглядають його та подають запити.',
        'Компанія відповідає за інформацію, яку вводить про свою команду, і за її відповідність закону (зокрема GDPR для компаній у Європейському Союзі). Щодо цих даних Vercane діє від імені компанії як обробник.',
      ]],
      ['5. Ціни та підписка', [
        'Платить лише власник компанії. Працівники, керівники й тимчасові працівники користуються застосунком безкоштовно.',
        'Покупки (підписка, місця, опції) здійснюються лише у вебверсії Staff Flow (https://app.staff-flow.cloud). Застосунок Android дає змогу користуватися придбаними правами, але не пропонує покупок.',
        'Ціна залежить від обраної кількості місць (працівники й керівники, без власника та позаштатних), блоками по 10 до 5000; компанія починає з 10 місць. Понад оплачені місця допускається запас 5 %, далі додавати людей можна лише після купівлі місць, які оплачуються як опція, додана під час підписки; чинну сітку показано в застосунку й на сайті. Ціни вказано в євро з усіма податками.',
        'Кожен обліковий запис Google один раз отримує безкоштовний пробний період 2 дні під час створення першої компанії.',
        'Підписка охоплює повні календарні місяці. Під час першої оплати (або після перерви) решта поточного місяця оплачується пропорційно днями, що залишилися, з округленням до цента вгору, а вибраний період починається з 1-го числа наступного місяця: 1 місяць (щомісячна оплата) або 12 місяців за ціною 10 (річна оплата). Опції («Доступ до API», «API Pro», «Каскадні об\'єкти» понад три рівні) оплачуються без знижки. Доступ до API для читання дає 1 ключ; «API Pro» — 1 або 10 ключів залежно від обраного тарифу; вона ніколи не входить у ціну (ні під час пробного періоду, ні для безкоштовної компанії). Ключі API зупиненої опції перестають працювати, а через 30 днів видаляються; клієнта попереджають за 7 днів. Опцію, додану під час підписки, оплачують окремо: поточний місяць повністю, потім кожен місяць до кінця вже оплаченого періоду (включно з безкоштовними місяцями року); далі її включають у продовження. Опцію можна будь-коли зняти: її більше не продовжують, і вона діє до кінця вже оплаченого періоду, без повернення коштів. Деталі показано перед кожною оплатою, і на кожну оплату є рахунок.',
        'Продовження подовжує вже оплачений період. Ціна розраховується за кількістю працівників на момент оплати.',
        'Оплату обробляє платіжний провайдер; Staff Flow ніколи не отримує даних вашої картки. Рахунки можна завантажити в застосунку.',
        'Про зміну ціни повідомляється щонайменше за 30 днів; вона застосовується з наступного продовження.',
      ]],
      ['6. Завершення підписки', [
        'Якщо підписку не продовжено, компанія на 15 днів переходить у режим лише перегляду з нагадуваннями, а її ключі API більше не працюють; власник може будь-коли оплатити й усе відновити. Після цього компанію та її дані буде видалено.',
        'Рахунки зберігаються протягом встановленого законом строку (10 років) і залишаються доступними для завантаження останньому власникові. Колишній власник, який видалив обліковий запис, може запросити їх на contact@staff-flow.cloud, підтвердивши, що був власником компанії.',
        'Оплачений період не повертається, крім випадків, передбачених законом. Якщо закон вашої країни надає право на відмову від договору, ви можете скористатися ним протягом 14 днів після оплати, написавши на contact@staff-flow.cloud; оскільки сервіс почав надаватися на ваше прохання, частина за вже використаний період залишається до сплати.',
      ]],
      ['7. Реклама', [
        'На Android людям, які не є власниками жодної компанії, може показуватися невеликий рекламний банер; його можна буде прибрати разовою покупкою. Графіки й оголошення ніколи не використовуються для реклами.',
      ]],
      ['8. Добросовісне використання', [
        'Ви зобов\'язуєтеся використовувати Staff Flow відповідно до закону, не публікувати незаконного чи образливого вмісту, не намагатися отримати доступ до чужих даних і не порушувати роботу сервісу. У разі серйозного порушення доступ може бути призупинено.',
      ]],
      ['9. Доступність і відповідальність', [
        'Ми робимо все можливе, щоб сервіс був доступним і надійним, але не можемо гарантувати відсутність перерв (обслуговування, збої, мережа). Уже отриманий графік можна переглядати без зв\'язку.',
        'У межах, дозволених законом, відповідальність Vercane обмежується сумами, сплаченими за останні 12 місяців, і не охоплює непрямих збитків. Ніщо в цих умовах не обмежує відповідальності, яку закон не дозволяє обмежувати.',
      ]],
      ['10. Інтелектуальна власність', [
        'Застосунок, його торговельна марка й вміст належать Vercane. Інформація, яку ви вводите, залишається вашою або вашої компанії.',
      ]],
      ['11. Зміни', [
        'Ці умови можуть змінюватися. Про важливі зміни повідомляється в застосунку щонайменше за 30 днів до набрання ними чинності.',
      ]],
      ['12. Застосовне право та спори', [
        'Ці умови регулюються правом України. Якщо ви споживач, за вами зберігається захист імперативних норм країни вашого проживання. У разі труднощів спершу напишіть на contact@staff-flow.cloud, щоб знайти мирне рішення.',
      ]],
    ],
    'privacy': [
      ['1. Хто обробляє ваші дані', [
        'Vercane, видавець Staff Flow (contact@staff-flow.cloud), відповідає за дані вашого облікового запису.',
        'Щодо інформації, яку компанія вводить про свою команду (графіки, відсутності, надані імена тощо), розпорядником є компанія, а Vercane діє від її імені як обробник.',
      ]],
      ['2. Які дані', [
        'Обліковий запис: ім\'я, e-mail, фото, ідентифікатор і мова облікового запису Google; ваш номер Staff Flow (SF-…) та вибране вами ім\'я.',
        'Компанії: назва, часовий пояс, зображення, ролі, об\'єкти й посади.',
        'Графік і запити: зміни, обміни, відпустки й недоступність (медичні причини не запитуються), історія змін.',
        'Стрічка новин: опубліковані оголошення, одержувачі, прочитання, запитані переклади.',
        'Імпорт: ім\'я, табельний номер і посада, які надає роботодавець, щоб запросити людину; невикористане запрошення видаляється через 90 днів, а людину додають лише за її згодою. Обліковий запис без Google: ключ застосунку автентифікації зберігається зашифрованим, резервні коди — лише у вигляді відбитка, а невдалі спроби входу — щонайбільше 24 години.',
        'Telegram (якщо ви його прив\'язали): ідентифікатор чату та ім\'я користувача.',
        'Пристрої: токен сповіщень, платформа й мова пристрою.',
        'Оплата: назва компанії, ім\'я власника, суми й періоди. Ми ніколи не отримуємо даних вашої банківської картки.',
        'Технічні дані: журнали сервера (зокрема IP-адреса) і журнал дій — для безпеки.',
        'Ключі API та журнали викликів: назва й права ключів; для кожного виклику — дата, дія, результат, тривалість та IP-адреса програми; адреси вебхуків, вибрані компанією.',
      ]],
      ['3. Навіщо', [
        'Надавати сервіс, яким ви користуєтеся (виконання договору): графік, запити, оголошення, запрошення, сповіщення.',
        'Безпека, запобігання зловживанням і перевірка особи (законний інтерес).',
        'Виставлення рахунків і бухгалтерія (вимога закону).',
        'Ваші дані ніколи не продаються й не використовуються для реклами.',
      ]],
      ['4. Хто має доступ', [
        'Учасники ваших компаній бачать те, що дозволяє їхня роль: графік, імена, а ваш Telegram — лише якщо ви вирішите його показувати. Вашу електронну адресу й обліковий запис Google їм ніколи не показують.',
        'Програми й асистенти, які ваша компанія вирішить підключити (API, вебхуки, конектор MCP), отримують дані, дозволені її ключами, під відповідальність компанії.',
        'Наші технічні постачальники: OVHcloud (хостинг сервера), Google (вхід і сповіщення Firebase Cloud Messaging), Telegram (якщо ви його прив\'язали), платіжний провайдер під час оплати та постачальник сховища (Google Drive) для копії резервних копій, зашифрованої й нечитабельної без нашого ключа.',
        'Переклад оголошень виконується на нашому власному сервері: вони не надсилаються сторонньому сервісу перекладу.',
      ]],
      ['5. Де', [
        'Сервер Staff Flow зараз розташований в Австралії (OVHcloud). Для людей у Європейському Союзі це передавання даних за межі ЄС.',
      ]],
      ['6. Як довго', [
        'Обліковий запис: поки він існує. Якщо його видалено «з привидом», він зберігається, щоб ви могли повернутися; якщо стерто назавжди, ваші особисті дані стираються одразу, а в історії компаній залишається лише анонімний «Ghost».',
        'Компанія: до її видалення, не пізніше ніж через 15 днів після завершення підписки.',
        'Рахунки: 10 років (вимога закону).',
        'Зашифровані резервні копії: 30 днів. Журнали ключів API: 12 місяців онлайн, потім в архіві, видаляються через 3 роки. Ключі API зупиненої опції: видаляються через 30 днів. Невикористані запрошення: 90 днів. Невдалі спроби входу: 24 години. Технічні журнали сервера: обмежений строк, для безпеки.',
      ]],
      ['7. Ваші права', [
        'Ви можете отримати доступ до своїх даних і завантажити їх («Мій профіль» → «Експортувати мої дані»), виправити їх (ім\'я) і видалити обліковий запис («Мій профіль» → «Видалити мій обліковий запис»). Також можна заперечити проти обробки або попросити її обмежити, написавши на contact@staff-flow.cloud.',
        'Щодо даних, введених компанією, спершу зверніться до неї; ми допоможемо їй відповісти.',
        'Ви можете звернутися до органу із захисту даних своєї країни (в Україні — до Уповноваженого Верховної Ради України з прав людини; у Франції — до CNIL).',
      ]],
      ['8. Безпека', [
        'Зашифровані з\'єднання (HTTPS), доступ відповідно до ролі, застосунок автентифікації (2FA) з блокуванням після 3 помилкових кодів, секрети 2FA та ключі API зберігаються зашифрованими або у вигляді відбитка, підписані вебхуки, обмежена кількість спроб і викликів, зашифровані резервні копії, посилання на завантаження, чинні кілька хвилин, перевірка через Telegram для зміни облікового запису Google.',
      ]],
      ['9. Зберігання на пристрої', [
        'Застосунок зберігає на вашому пристрої сесію й копію графіка, щоб працювати без мережі. На Android сесія зберігається в зашифрованому сховищі телефона й не потрапляє до резервних копій. Ні застосунок, ні сайт не використовують рекламних трекерів чи вимірювання аудиторії.',
      ]],
      ['10. Зміни', [
        'Ця політика може змінюватися; про важливі зміни повідомляється в застосунку.',
      ]],
    ],
  },
  'en': {
    'terms': [
      ['1. Publisher', [
        'Staff Flow is published by Vercane, the trade name of FOP Dutertre Remy Yves (ФОП Дютертре Ремі Ів), an individual entrepreneur registered in Ukraine on 13 October 2026. Tax number (RNOKPP): 2938925032. Address: 112A Saltivske shose, apt. 45, Kharkiv, 61110, Ukraine. Single tax payer, group 3 (5%), not registered for VAT.',
        'Contact: contact@staff-flow.cloud.',
      ]],
      ['2. The service', [
        'Staff Flow lets a company build and share its team schedule: shifts, swaps, leave and unavailability, news feed, employee import, exports, notifications. It works on Android and in a browser (https://app.staff-flow.cloud).',
        'Options for companies: read API access (1 key) and “API Pro” (read and write, 1 or 10 keys, webhooks, call logs, MCP connector for assistants such as Claude). The company chooses the software and assistants it connects, remains responsible for what they do with its keys and for the data they receive, and protects its keys like passwords. For the stability of the service, the number of calls is limited (per minute and per day); the limits in force are given in the API documentation.',
        'The “legal” alerts offered (working hours, rest…) are indicative guides only: the employer remains solely responsible for complying with the labour law that applies to it.',
      ]],
      ['3. Account', [
        'Sign-in uses a Google account, or without Google an authenticator app (2FA): Staff Flow ID or employee number, then a 6-digit code; backup codes are given at activation. Creating a company requires a Google account. Each person has a single Staff Flow account, identified by a number (SF-…), valid in all their companies. You must be at least 16.',
        'You are responsible for access to your Google account. You can link a verified Telegram account: it is used to confirm your identity, in particular to attach your account to another Google account (the bot\'s /changegoogle command). Without Telegram, the owner or a manager can create a single-use link for this change.',
        'Everyone is responsible for the security of their phone, computer, Google account and Telegram account, and for what is done from them. Vercane cannot be held liable for fraudulent use resulting from their loss, theft, a code given to someone else or hacking. We will nevertheless do our best to help: write to contact@staff-flow.cloud.',
        'You can export your data and delete your account at any time from “My profile”. An anonymous “Ghost” remains in company history (past shifts, leave requests…) so companies can trace what happened.',
      ]],
      ['4. Roles and the company\'s responsibility', [
        'In each company, the owner and managers organise the schedule; employees and temps view it and make requests.',
        'The company is responsible for the information it enters about its team and for its lawfulness (in particular under the GDPR for companies in the European Union). For that data, Vercane acts on the company\'s behalf, as a processor.',
      ]],
      ['5. Prices and subscription', [
        'Only the owner of a company pays. Employees, managers and temps use the app for free.',
        'Purchases (subscription, seats, options) are made only in the web version of Staff Flow (https://app.staff-flow.cloud). The Android app lets you use the rights purchased, but offers no purchases.',
        'The price depends on the number of seats chosen (employees and managers, not the owner or temps), in blocks of 10 up to 5000; a company starts with 10 seats. Beyond the paid seats, a 5% margin is allowed, then nobody can be added without buying seats, paid like an option added during the subscription; the current grid is shown in the app and on the website. Prices are in euros, all taxes included.',
        'Each Google account gets a free 2-day trial once, when creating its first company.',
        'The subscription covers whole calendar months. At the first payment (or after an interruption), the rest of the current month is paid pro rata for the remaining days, rounded up to the cent, then the chosen period starts on the 1st of the following month: 1 month (monthly payment) or 12 months for the price of 10 (yearly payment). Options (“API access”, “API Pro”, “nested sites” beyond three levels of sites) are charged without discount. Read API access allows 1 key; “API Pro” allows 1 or 10 keys depending on the plan chosen; it is never included (not during the trial, not for a complimentary company). The API keys of a stopped option stop working, then are deleted 30 days later; the customer is warned 7 days before. An option added during a subscription is paid on its own: the whole current month, then each month until the end of the period already paid (including the free months of a year); it is then included in renewals. An option can be removed at any time: it is no longer renewed and stays active until the end of the period already paid, with no refund. The details are shown before each payment, and each payment has its invoice.',
        'A renewal extends the period already paid. The price is calculated with the headcount at the time of payment.',
        'Payment is handled by a payment provider; Staff Flow never receives your card details. Invoices can be downloaded in the app.',
        'A price change is announced at least 30 days in advance and applies from the next renewal.',
      ]],
      ['6. End of the subscription', [
        'If the subscription is not renewed, the company becomes read-only for 15 days, with reminders, and its API keys stop working; the owner can pay at any time to get everything back. After that, the company and its data are deleted.',
        'Invoices are kept for the legal period (10 years) and remain downloadable by the last owner. A former owner who deleted their account can request them at contact@staff-flow.cloud by showing they owned the company.',
        'A paid period is not refunded, except where the law requires it. If the law of your country gives you a right of withdrawal, you can exercise it within 14 days of payment by writing to contact@staff-flow.cloud; since the service started at your request, the share for the period already elapsed remains due.',
      ]],
      ['7. Advertising', [
        'On Android, a small ad banner may be shown to people who own no company; it will be removable with a one-off purchase. Schedules and announcements are never used for advertising.',
      ]],
      ['8. Proper use', [
        'You agree to use Staff Flow lawfully, not to publish unlawful or hurtful content, not to try to access other people\'s data and not to disrupt the service. In case of serious breach, access may be suspended.',
      ]],
      ['9. Availability and liability', [
        'We do our best to keep the service available and reliable, but cannot guarantee it will never be interrupted (maintenance, failures, network). A schedule already received can be read offline.',
        'To the extent permitted by law, Vercane\'s liability is limited to the amounts paid in the last 12 months and excludes indirect damage. Nothing in these terms limits liability that the law does not allow to be limited.',
      ]],
      ['10. Intellectual property', [
        'The app, its brand and its content belong to Vercane. The information you enter remains yours or your company\'s.',
      ]],
      ['11. Changes', [
        'These terms may change. Significant changes are announced in the app at least 30 days before they apply.',
      ]],
      ['12. Governing law and disputes', [
        'These terms are governed by Ukrainian law. If you are a consumer, you keep the protection of the mandatory rules of your country of residence. If there is a problem, please first write to contact@staff-flow.cloud to find an amicable solution.',
      ]],
    ],
    'privacy': [
      ['1. Who processes your data', [
        'Vercane, publisher of Staff Flow (contact@staff-flow.cloud), is responsible for your account data.',
        'For the information a company enters about its team (schedules, absences, names given…), the company is the controller and Vercane acts on its behalf, as a processor.',
      ]],
      ['2. What data', [
        'Account: name, email address, photo, ID and language of your Google account; your Staff Flow number (SF-…) and the name you choose.',
        'Companies: name, time zone, image, roles, sites and positions.',
        'Schedule and requests: shifts, swaps, leave and unavailability (no medical reason is asked), change history.',
        'News feed: announcements posted, recipients, reads, translations requested.',
        'Import: name, employee number and position provided by the employer to invite a person; an unused invitation is erased after 90 days, and the person is only added with their consent. Account without Google: the authenticator app key is stored encrypted, backup codes only as a fingerprint, and failed sign-in attempts for 24 hours at most.',
        'Telegram (if you link it): chat ID and username.',
        'Devices: notification token, platform and device language.',
        'Billing: company name, owner name, amounts and periods. We never receive your bank card details.',
        'Technical data: server logs (including IP address) and an action log, for security.',
        'API keys and call logs: name and permissions of keys; for each call, the date, action, result, duration and IP address of the calling software; webhook addresses chosen by the company.',
      ]],
      ['3. Why', [
        'To provide the service you use (performance of the contract): schedule, requests, announcements, invitations, notifications.',
        'Security, abuse prevention and identity checks (legitimate interest).',
        'Billing and accounting (legal obligation).',
        'Your data is never sold and is not used for advertising.',
      ]],
      ['4. Who has access', [
        'Members of your companies see what their role allows: the schedule, names, and your Telegram only if you choose to show it. Your email address and Google account are never shown to them.',
        'The software and assistants your company chooses to connect (API, webhooks, MCP connector) receive the data its keys allow, under the company\'s responsibility.',
        'Our technical providers: OVHcloud (server hosting), Google (sign-in and Firebase Cloud Messaging notifications), Telegram (if you link it), the payment provider when you pay, and a storage provider (Google Drive) for a copy of the backups, encrypted and unreadable without our key.',
        'Announcements are translated on our own server: they are not sent to an outside translation service.',
      ]],
      ['5. Where', [
        'The Staff Flow server is currently located in Australia (OVHcloud). For people in the European Union, this is a transfer of data outside the European Union.',
      ]],
      ['6. How long', [
        'Account: as long as it exists. Deleted “as a ghost”, it is kept so you can come back; erased permanently, your personal data is erased at once and only an anonymous “Ghost” remains in company history.',
        'Company: until it is deleted, at the latest 15 days after its subscription ends.',
        'Invoices: 10 years (legal obligation).',
        'Encrypted backups: 30 days. API key logs: 12 months online, then archived, deleted after 3 years. API keys of a stopped option: deleted after 30 days. Unused invitations: 90 days. Failed sign-in attempts: 24 hours. Server technical logs: a limited time, for security.',
      ]],
      ['7. Your rights', [
        'You can access and download your data (“My profile” → “Export my data”), correct it (name), and delete your account (“My profile” → “Delete my account”). You can also object to processing or ask for it to be restricted by writing to contact@staff-flow.cloud.',
        'For data entered by a company, please contact the company first; we will help it reply.',
        'You can complain to the data protection authority of your country (in Ukraine: the Ukrainian Parliament Commissioner for Human Rights; in France: the CNIL).',
      ]],
      ['8. Security', [
        'Encrypted connections (HTTPS), role-based access, download links valid for a few minutes, Telegram verification to change Google account, authenticator app (2FA) with lockout after 3 wrong codes, 2FA secrets and API keys stored encrypted or hashed, signed webhooks, limited attempts and calls, encrypted backups.',
      ]],
      ['9. Storage on your device', [
        'The app keeps your session and a copy of the schedule on your device, to work offline. On Android, the session is kept in the phone\'s encrypted store and excluded from backups. Neither the app nor the website uses advertising trackers or audience measurement.',
      ]],
      ['10. Changes', [
        'This policy may change; significant changes are announced in the app.',
      ]],
    ],
  },
};
