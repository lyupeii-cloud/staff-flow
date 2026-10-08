/// Traductions des messages d'erreur de l'API. La clé est le texte français ;
/// `{nom}` marque une valeur insérée. Un test vérifie que chaque message
/// levé dans le code a sa traduction.
const supportedLanguages = ['en', 'fr', 'uk'];

/// Langue de réponse d'après l'en-tête `Accept-Language` (`uk-UA,uk;q=0.9,en;q=0.8`).
/// Par défaut : anglais.
String negotiateLanguage(String? acceptLanguage) {
  if (acceptLanguage == null) return 'en';
  final ranked = <(String, double)>[];
  for (final part in acceptLanguage.split(',')) {
    final pieces = part.trim().split(';');
    final lang = pieces.first.trim().toLowerCase().split(RegExp('[-_]')).first;
    var q = 1.0;
    for (final p in pieces.skip(1)) {
      final kv = p.trim().split('=');
      if (kv.length == 2 && kv[0] == 'q') q = double.tryParse(kv[1]) ?? 0;
    }
    if (lang.isNotEmpty) ranked.add((lang, q));
  }
  ranked.sort((a, b) => b.$2.compareTo(a.$2));
  for (final (lang, q) in ranked) {
    if (q > 0 && supportedLanguages.contains(lang)) return lang;
  }
  return 'en';
}

String translate(String french, String lang, [Map<String, String> args = const {}]) {
  var text = lang == 'fr' ? french : (messages[french]?[lang] ?? french);
  args.forEach((k, v) => text = text.replaceAll('{$k}', v));
  return text;
}

const messages = <String, Map<String, String>>{
  // Connexion et session
  'Connexion requise.': {'en': 'Please sign in.', 'uk': 'Потрібно увійти.'},
  'Session expirée, reconnectez-vous.': {
    'en': 'Your session has expired, please sign in again.',
    'uk': 'Сеанс завершився, увійдіть знову.',
  },
  'Session invalide.': {'en': 'Invalid session.', 'uk': 'Недійсний сеанс.'},
  'Compte introuvable.': {'en': 'Account not found.', 'uk': 'Обліковий запис не знайдено.'},
  'Jeton Google invalide.': {'en': 'Invalid Google token.', 'uk': 'Недійсний токен Google.'},
  'Jeton Google émis pour une autre application.': {
    'en': 'This Google token was issued for another application.',
    'uk': 'Цей токен Google видано для іншого застосунку.',
  },
  'Adresse Google non vérifiée.': {
    'en': 'Your Google address is not verified.',
    'uk': 'Адресу Google не підтверджено.',
  },
  'idToken manquant.': {'en': 'Missing idToken.', 'uk': 'Відсутній idToken.'},
  'email manquant.': {'en': 'Missing email.', 'uk': 'Відсутня електронна адреса.'},

  // Généraux
  'Action non autorisée.': {'en': 'You are not allowed to do this.', 'uk': 'Цю дію заборонено.'},
  'Introuvable.': {'en': 'Not found.', 'uk': 'Не знайдено.'},
  'Route inconnue.': {'en': 'Unknown route.', 'uk': 'Невідомий маршрут.'},
  'Corps JSON attendu.': {'en': 'A JSON body is expected.', 'uk': 'Очікується тіло запиту у форматі JSON.'},
  'Champ « {field} » manquant.': {
    'en': 'Missing field “{field}”.',
    'uk': 'Відсутнє поле «{field}».',
  },
  'Champ manquant ou de mauvais type.': {
    'en': 'A field is missing or has the wrong type.',
    'uk': 'Поле відсутнє або має неправильний тип.',
  },
  'Date invalide : {value}': {'en': 'Invalid date: {value}', 'uk': 'Недійсна дата: {value}'},
  'Fuseau horaire invalide : {value}': {
    'en': 'Invalid time zone: {value}',
    'uk': 'Недійсний часовий пояс: {value}',
  },
  'Rôle inconnu : {value}': {'en': 'Unknown role: {value}', 'uk': 'Невідома роль: {value}'},

  // Entreprises et membres
  'Entreprise introuvable.': {'en': 'Company not found.', 'uk': 'Компанію не знайдено.'},
  'Cette entreprise est en lecture seule.': {
    'en': 'This company is read-only.',
    'uk': 'Ця компанія доступна лише для перегляду.',
  },
  'Le nom doit faire entre 1 et 120 caractères.': {
    'en': 'The name must be 1 to 120 characters long.',
    'uk': 'Назва має містити від 1 до 120 символів.',
  },
  'Membre introuvable.': {'en': 'Member not found.', 'uk': 'Учасника не знайдено.'},
  'La propriété se change par un transfert.': {
    'en': 'Ownership can only change through a transfer.',
    'uk': 'Власника можна змінити лише через передачу.',
  },
  'Le propriétaire doit transférer l\'entreprise avant de la quitter.': {
    'en': 'The owner must transfer the company before leaving it.',
    'uk': 'Власник має передати компанію, перш ніж її залишити.',
  },
  'Seul le propriétaire peut transférer.': {
    'en': 'Only the owner can transfer the company.',
    'uk': 'Лише власник може передати компанію.',
  },
  'Le nouveau propriétaire doit être responsable de l\'entreprise.': {
    'en': 'The new owner must be a manager of the company.',
    'uk': 'Новий власник має бути керівником компанії.',
  },
  'Un transfert est déjà en attente.': {
    'en': 'A transfer is already pending.',
    'uk': 'Передача вже очікує підтвердження.',
  },
  'Aucun transfert en attente.': {'en': 'No pending transfer.', 'uk': 'Немає передачі, що очікує.'},
  'Transfert introuvable.': {'en': 'Transfer not found.', 'uk': 'Передачу не знайдено.'},
  'Ce transfert n\'est plus valable.': {
    'en': 'This transfer is no longer valid.',
    'uk': 'Ця передача вже недійсна.',
  },

  // Code à 6 chiffres
  'Rôle attendu : salarié ou extra.': {
    'en': 'Expected role: employee or extra.',
    'uk': 'Очікувана роль: працівник або тимчасовий працівник.',
  },
  'Trop de codes erronés : réessayez dans 2 minutes.': {
    'en': 'Too many wrong codes: try again in 2 minutes.',
    'uk': 'Забагато неправильних кодів: спробуйте через 2 хвилини.',
  },
  'Code invalide ou expiré.': {'en': 'Invalid or expired code.', 'uk': 'Недійсний або прострочений код.'},
  '{name} fait déjà partie de l\'entreprise.': {
    'en': '{name} is already a member of the company.',
    'uk': '{name} вже є учасником компанії.',
  },
  'Invitation introuvable.': {'en': 'Invitation not found.', 'uk': 'Запрошення не знайдено.'},

  // Planning
  'Site introuvable.': {'en': 'Site not found.', 'uk': 'Об’єкт не знайдено.'},
  'Poste introuvable.': {'en': 'Position not found.', 'uk': 'Посаду не знайдено.'},
  'Site inconnu ou archivé.': {
    'en': 'Unknown or archived site.',
    'uk': 'Невідомий або архівований об’єкт.',
  },
  'Poste inconnu ou archivé.': {
    'en': 'Unknown or archived position.',
    'uk': 'Невідома або архівована посада.',
  },
  'Nom entre 1 et 80 caractères.': {
    'en': 'Name must be 1 to 80 characters long.',
    'uk': 'Назва має містити від 1 до 80 символів.',
  },
  'Période invalide (62 jours au plus).': {
    'en': 'Invalid period (62 days at most).',
    'uk': 'Недійсний період (не більше 62 днів).',
  },
  'Paramètres from et to requis.': {
    'en': 'The from and to parameters are required.',
    'uk': 'Потрібні параметри from і to.',
  },
  'Champ « days » : liste de dates attendue.': {
    'en': 'Field “days”: a list of dates is expected.',
    'uk': 'Поле «days»: очікується список дат.',
  },
  'Choisissez au moins un jour.': {'en': 'Choose at least one day.', 'uk': 'Виберіть принаймні один день.'},
  'Trop de services d\'un coup (400 au plus).': {
    'en': 'Too many shifts at once (400 at most).',
    'uk': 'Забагато змін за один раз (не більше 400).',
  },
  'Heures invalides.': {'en': 'Invalid times.', 'uk': 'Недійсний час.'},
  'Répétition inconnue.': {'en': 'Unknown repetition.', 'uk': 'Невідоме повторення.'},
  'Indiquez une date de fin ou un nombre de répétitions.': {
    'en': 'Give an end date or a number of repetitions.',
    'uk': 'Вкажіть дату завершення або кількість повторень.',
  },
  'Nombre de répétitions entre 1 et 366.': {
    'en': 'Number of repetitions between 1 and 366.',
    'uk': 'Кількість повторень — від 1 до 366.',
  },
  'Jour de semaine invalide.': {'en': 'Invalid day of the week.', 'uk': 'Недійсний день тижня.'},
  'Le jour se change service par service.': {
    'en': 'The day can only be changed one shift at a time.',
    'uk': 'День можна змінювати лише для окремої зміни.',
  },
  'Service introuvable.': {'en': 'Shift not found.', 'uk': 'Зміну не знайдено.'},
  'Cette personne ne fait pas partie de l\'entreprise.': {
    'en': 'This person is not a member of the company.',
    'uk': 'Ця особа не є учасником компанії.',
  },
  'Le remplaçant ne fait pas partie de l\'entreprise.': {
    'en': 'The replacement is not a member of the company.',
    'uk': 'Заміна не є учасником компанії.',
  },
};
