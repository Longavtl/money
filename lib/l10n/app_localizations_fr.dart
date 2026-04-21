// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Money Wave';

  @override
  String get appTagline => 'Calculez votre avenir';

  @override
  String get home => 'Accueil';

  @override
  String get saved => 'Enregistré';

  @override
  String get history => 'Historique';

  @override
  String get settings => 'Paramètres';

  @override
  String get compare => 'Comparer';

  @override
  String get simulate => 'Simuler';

  @override
  String get mainTools => 'Outils principaux';

  @override
  String categories(int count) {
    return '$count CATÉGORIES';
  }

  @override
  String get loanCalc => 'Prêt';

  @override
  String get loanCalcSubtitle => 'Mensualités';

  @override
  String get interestCalc => 'Intérêts';

  @override
  String get interestCalcSubtitle => 'Simple et composé';

  @override
  String get vault => 'Coffre';

  @override
  String get vaultSubtitle => 'Planifiez votre avenir';

  @override
  String get historySubtitle => 'Calculs précédents';

  @override
  String get proAccess => 'ACCÈS PRO';

  @override
  String get upgradeToPremium => 'Passer à Premium';

  @override
  String get premiumBannerDesc =>
      'Débloquez les graphiques avancés\net l\'expérience sans pub.';

  @override
  String get marketPulse => 'POULS DU MARCHÉ';

  @override
  String get currentRates => 'Taux actuels';

  @override
  String get homeLoan => 'Prêt immobilier';

  @override
  String get savingsApy => 'APY épargne';

  @override
  String get calculatorSimpleInterest => 'Intérêt Simple';

  @override
  String get calculatorCompoundInterest => 'Intérêt Composé';

  @override
  String get calculatorLoan => 'Calculateur de Prêt';

  @override
  String get calculatorSavings => 'Calculateur d\'Épargne';

  @override
  String get principal => 'Capital';

  @override
  String get interestRate => 'Taux d\'Intérêt';

  @override
  String get annualInterestRate => 'Taux d\'Intérêt (Annuel)';

  @override
  String get term => 'Durée';

  @override
  String get termMonths => 'Durée (mois)';

  @override
  String get termYears => 'Durée (années)';

  @override
  String get monthlyPayment => 'Mensualité';

  @override
  String get firstMonthPayment => 'Premier mois';

  @override
  String get lastMonthPayment => 'Dernier mois';

  @override
  String get totalInterest => 'Intérêt Total';

  @override
  String get totalPayment => 'Paiement Total';

  @override
  String get interest => 'Intérêt';

  @override
  String get totalAmount => 'Montant Total';

  @override
  String get interestPrincipalRatio => 'Ratio Intérêt/Capital';

  @override
  String get loanAmount => 'Montant du prêt';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get loanTypeFixed => 'Mensualité Fixe';

  @override
  String get loanTypeReducing => 'Capital Dégressif';

  @override
  String get savingsTypeReinvest => 'Réinvestir';

  @override
  String get savingsTypeWithdraw => 'Retirer';

  @override
  String get results => 'Résultats';

  @override
  String get paymentStructure => 'Structure de paiement';

  @override
  String get amortizationSchedule => 'Tableau d\'Amortissement';

  @override
  String get month => 'Mois';

  @override
  String get year => 'Année';

  @override
  String get years => 'ans';

  @override
  String get payment => 'Paiement';

  @override
  String get principalPaid => 'Capital';

  @override
  String get interestPaid => 'Intérêt';

  @override
  String get balance => 'Solde';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get share => 'Partager';

  @override
  String get exportPdf => 'Exporter PDF';

  @override
  String get calculate => 'Calculer';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get close => 'Fermer';

  @override
  String get add => 'Ajouter';

  @override
  String get storageLimitTitle => 'Limite de stockage';

  @override
  String storageLimitLoans(int count) {
    return 'Vous avez enregistré le maximum de $count prêts. Passez à Premium pour des sauvegardes illimitées!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'Vous avez enregistré le maximum de $count épargnes. Passez à Premium pour des sauvegardes illimitées!';
  }

  @override
  String get saveLoan => 'Enregistrer le prêt';

  @override
  String get loanNameHint => 'Nom du prêt (optionnel)';

  @override
  String get amount => 'Montant';

  @override
  String get rate => 'Taux';

  @override
  String get loanSaved => 'Prêt enregistré';

  @override
  String get saveSavings => 'Enregistrer l\'épargne';

  @override
  String get savingsNameHint => 'Nom de l\'épargne (optionnel)';

  @override
  String get savingsSaved => 'Épargne enregistrée';

  @override
  String get savedLoans => 'Prêts Enregistrés';

  @override
  String get savedSavings => 'Épargnes Enregistrées';

  @override
  String loansCount(int count) {
    return 'Prêts ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'Épargnes ($count)';
  }

  @override
  String get noSavedItems => 'Aucun élément enregistré';

  @override
  String get noSavedLoans => 'Aucun prêt enregistré';

  @override
  String get noSavedLoansSubtitle =>
      'Calculez et enregistrez des prêts pour les consulter plus tard';

  @override
  String get noSavedSavings => 'Aucune épargne enregistrée';

  @override
  String get noSavedSavingsSubtitle =>
      'Calculez et enregistrez des épargnes pour les consulter plus tard';

  @override
  String errorLoading(String error) {
    return 'Erreur: $error';
  }

  @override
  String get compoundingFrequency => 'Fréquence de capitalisation';

  @override
  String get daily => 'Quotidien';

  @override
  String get monthly => 'Mensuel';

  @override
  String get quarterly => 'Trimestriel';

  @override
  String get yearly => 'Annuel';

  @override
  String get calculationResults => 'Résultats du calcul';

  @override
  String get totalReceived => 'Total reçu';

  @override
  String get interestEarned => 'Intérêts gagnés';

  @override
  String get effectiveAnnualRate => 'Taux effectif annuel';

  @override
  String get compoundingPeriods => 'Périodes de capitalisation';

  @override
  String get compareWithSimple => 'Comparer avec l\'intérêt simple';

  @override
  String get simpleInterest => 'Intérêt simple';

  @override
  String get compoundInterest => 'Intérêt composé';

  @override
  String compoundBenefit(String amount) {
    return 'L\'intérêt composé vous rapporte $amount de plus';
  }

  @override
  String get savingsType => 'Type d\'épargne';

  @override
  String get initialDeposit => 'Dépôt initial';

  @override
  String get monthlyDeposit => 'Dépôt mensuel';

  @override
  String get annualRate => 'Taux annuel';

  @override
  String get finalBalance => 'Solde final';

  @override
  String get totalDeposited => 'Total déposé';

  @override
  String get returnRate => 'Taux de rendement';

  @override
  String get avgMonthlyInterest => 'Intérêt mensuel moyen';

  @override
  String get detailedAnalysis => 'Analyse détaillée';

  @override
  String get deposits => 'Dépôts';

  @override
  String get reinvestInfo => 'Les intérêts sont capitalisés mensuellement';

  @override
  String get withdrawInfo =>
      'Les intérêts sont versés mensuellement, non capitalisés';

  @override
  String get averageMonthlyInterest => 'Intérêt moyen/mois';

  @override
  String get totalStructure => 'Structure totale';

  @override
  String get premium => 'Passer à Premium';

  @override
  String get premiumActivated => 'Vous êtes Premium!';

  @override
  String get premiumMember => 'Membre Premium';

  @override
  String get premiumThanks => 'Merci pour votre soutien!';

  @override
  String get premiumDescription => 'Débloquer toutes les fonctionnalités';

  @override
  String get premiumFeature1 => 'Sauvegardes illimitées';

  @override
  String get premiumFeature1Desc => 'Stockez tous vos prêts et épargnes';

  @override
  String get premiumFeature2 => 'Graphiques complets';

  @override
  String get premiumFeature2Desc =>
      'Voir les détails avec tous les types de graphiques';

  @override
  String get premiumFeature3 => 'Comparaison de scénarios';

  @override
  String get premiumFeature3Desc => 'Comparez plusieurs options côte à côte';

  @override
  String get premiumFeature4 => 'Export PDF';

  @override
  String get premiumFeature4Desc =>
      'Créez des rapports détaillés à imprimer ou partager';

  @override
  String get premiumFeature5 => 'Soutenir le développement';

  @override
  String get premiumFeature5Desc => 'Aidez-nous à améliorer l\'application';

  @override
  String get premiumFeatures => 'Fonctionnalités Premium';

  @override
  String get lifetime => 'À vie';

  @override
  String get oneTimePurchase => 'Payez une fois, utilisez pour toujours';

  @override
  String get upgradeNow => 'Mettre à niveau';

  @override
  String get restorePurchase => 'Restaurer l\'Achat';

  @override
  String purchaseDate(String date) {
    return 'Date d\'achat: $date';
  }

  @override
  String get premiumRequired => 'Premium requis';

  @override
  String get premiumMonthlyTitle => 'Premium Monthly Subscription';

  @override
  String get premiumYearlyTitle => 'Premium Yearly Subscription';

  @override
  String get premiumLifetimeTitle => 'Premium Lifetime Access';

  @override
  String get billedMonthly => 'Billed monthly';

  @override
  String get billedAnnually => 'Billed annually';

  @override
  String get payOnceOwnForever => 'Pay once, own forever';

  @override
  String get perMonth => 'per month';

  @override
  String get perYear => 'per year';

  @override
  String get oneTime => 'one-time';

  @override
  String get subscriptionPaymentInfo =>
      'Payment will be charged to your Apple ID account at confirmation of purchase.';

  @override
  String get subscriptionAutoRenewInfo =>
      'Subscriptions automatically renew unless auto-renew is turned off at least 24 hours before the end of the current period. You can manage and cancel subscriptions in your App Store account settings.';

  @override
  String upgradeTo(String feature) {
    return 'Passer à $feature';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => 'Activé';

  @override
  String get unlockAllFeatures => 'Débloquer toutes les fonctionnalités';

  @override
  String get theme => 'Thème';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get language => 'Langue';

  @override
  String get about => 'À propos';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get error => 'Erreur';

  @override
  String get errorGeneric => 'Une erreur s\'est produite';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get ok => 'OK';

  @override
  String get upgrade => 'Mettre à niveau';

  @override
  String get compareScenarios => 'Comparer les scénarios';

  @override
  String get upgradeToCompare => 'Passez à Premium pour comparer';

  @override
  String get loanSettings => 'Paramètres du prêt';

  @override
  String get scenarioA => 'Scénario A';

  @override
  String get scenarioB => 'Scénario B';

  @override
  String get comparison => 'Comparaison';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'Le scénario $scenario économise $amount';
  }

  @override
  String get simulation => 'Simulation';

  @override
  String get noScenariosYet => 'Aucun scénario pour l\'instant';

  @override
  String get addScenariosSubtitle =>
      'Ajoutez des prêts ou épargnes pour\nsimuler vos finances';

  @override
  String get addLoan => 'Ajouter un prêt';

  @override
  String get addSavings => 'Ajouter une épargne';

  @override
  String get loans => 'Prêts';

  @override
  String get savings => 'Épargnes';

  @override
  String get timeline => 'Chronologie';

  @override
  String monthNumber(int number) {
    return 'Mois $number';
  }

  @override
  String get netWorth => 'Patrimoine net';

  @override
  String get positive => 'Positif';

  @override
  String get negativeDebt => 'Négatif (dette)';

  @override
  String get now => 'Maintenant';

  @override
  String yearsCount(int count) {
    return '$count ans';
  }

  @override
  String get debt => 'Dette';

  @override
  String get remaining => 'Restant';

  @override
  String get clearAll => 'Tout effacer?';

  @override
  String get allScenariosDeleted => 'Tous les scénarios seront supprimés.';

  @override
  String get loanNameHintExample => 'Nom du prêt (ex. Immobilier)';

  @override
  String get savingsNameHintExample => 'Nom (ex. Retraite)';

  @override
  String get deposit => 'Dépôt';

  @override
  String get loan => 'Prêt';

  @override
  String get selectThemeDescription =>
      'Choisissez un thème pour votre application';

  @override
  String get selectLanguageDescription => 'Choisissez votre langue préférée';

  @override
  String get apply => 'Appliquer';

  @override
  String get financialTools => 'Outils financiers';

  @override
  String get reminders => 'Rappels';

  @override
  String get paymentRemindersSubtitle => 'Suivre les échéances';

  @override
  String get savingsGoalsSubtitle => 'Atteindre vos objectifs';

  @override
  String get calendar => 'Calendrier';

  @override
  String get calendarSubtitle => 'Voir tous les événements';

  @override
  String get achievementsSubtitle => 'Votre progression';

  @override
  String get reportsSubtitle => 'Voir les statistiques';

  @override
  String get rateAlertsSubtitle => 'Surveiller les taux';

  @override
  String get paymentReminders => 'Rappels de paiement';

  @override
  String get noRemindersYet => 'Aucun rappel pour l\'instant';

  @override
  String get addRemindersSubtitle => 'Ajoutez des rappels de paiement';

  @override
  String get addReminder => 'Ajouter un rappel';

  @override
  String get editReminder => 'Modifier le rappel';

  @override
  String get reminderNameHint => 'Nom du rappel (ex. Carte de crédit)';

  @override
  String get dueDate => 'Date d\'échéance';

  @override
  String get remindBefore => 'Rappeler avant';

  @override
  String get days => 'jours';

  @override
  String get recurring => 'Récurrent';

  @override
  String get totalDue => 'Total dû';

  @override
  String get overdue => 'En retard';

  @override
  String get upcoming => 'À venir';

  @override
  String get completed => 'Terminé';

  @override
  String get markAsPaid => 'Marquer comme payé';

  @override
  String get markAsPaidConfirm => 'Voulez-vous vraiment marquer comme payé?';

  @override
  String get pending => 'En attente';

  @override
  String get paid => 'Payé';

  @override
  String get skipped => 'Ignoré';

  @override
  String get markPaid => 'Marquer payé';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get biWeekly => 'Bihebdomadaire';

  @override
  String get dueToday => 'Dû aujourd\'hui';

  @override
  String get dueTomorrow => 'Dû demain';

  @override
  String dueInDays(int days) {
    return 'Dû dans $days jours';
  }

  @override
  String get pleaseEnterName => 'Veuillez entrer un nom';

  @override
  String get savingsGoals => 'Objectifs d\'épargne';

  @override
  String get noGoalsYet => 'Aucun objectif pour l\'instant';

  @override
  String get addGoalsSubtitle =>
      'Définissez des objectifs et suivez votre progression';

  @override
  String get addGoal => 'Ajouter un objectif';

  @override
  String get editGoal => 'Modifier l\'objectif';

  @override
  String get goalNameHint => 'Nom de l\'objectif (ex. Vacances)';

  @override
  String get targetAmount => 'Montant cible';

  @override
  String get initialAmount => 'Montant initial';

  @override
  String get deadline => 'Date limite';

  @override
  String get suggestedMonthly => 'Mensualité suggérée';

  @override
  String get activeGoals => 'Objectifs actifs';

  @override
  String get completedGoals => 'Objectifs atteints';

  @override
  String get totalSaved => 'Total épargné';

  @override
  String get totalTarget => 'Objectif total';

  @override
  String get ofTotalTarget => 'de l\'objectif total';

  @override
  String get milestones => 'Jalons';

  @override
  String get addMoney => 'Ajouter de l\'argent';

  @override
  String get withdraw => 'Retirer';

  @override
  String get addContribution => 'Ajouter une contribution';

  @override
  String get notesOptional => 'Notes (optionnel)';

  @override
  String get withdrawReason => 'Raison du retrait';

  @override
  String get noContributionsYet => 'Aucune contribution pour l\'instant';

  @override
  String get pauseGoal => 'Mettre en pause';

  @override
  String get deleteGoal => 'Supprimer l\'objectif';

  @override
  String get deleteGoalConfirm =>
      'Voulez-vous vraiment supprimer cet objectif?';

  @override
  String get target => 'Cible';

  @override
  String get goals => 'Objectifs';

  @override
  String savePerMonth(String amount) {
    return 'Épargnez $amount/mois pour atteindre l\'objectif';
  }

  @override
  String get pleaseEnterGoalName => 'Veuillez entrer un nom d\'objectif';

  @override
  String get withdrawal => 'Retrait';

  @override
  String get start => 'Début';

  @override
  String get goalReached => 'Objectif atteint!';

  @override
  String get progress => 'Progression';

  @override
  String get achievements => 'Réussites';

  @override
  String get financialHealthScore => 'Score de santé financière';

  @override
  String get financialHealth => 'Santé financière';

  @override
  String get points => 'points';

  @override
  String get healthExcellent => 'Excellent! Continuez comme ça!';

  @override
  String get healthGood => 'Bonne progression! Vous êtes sur la bonne voie.';

  @override
  String get healthFair => 'Passable. Il y a des améliorations possibles.';

  @override
  String get healthNeedsWork => 'Nécessite attention. Améliorons ensemble!';

  @override
  String get paymentStreak => 'Série de paiements';

  @override
  String get dayStreak => 'jours consécutifs';

  @override
  String get keepItUp => 'Continuez!';

  @override
  String get longest => 'Plus longue';

  @override
  String get unlocked => 'Débloqué';

  @override
  String get locked => 'Verrouillé';

  @override
  String get financialCalendar => 'Calendrier financier';

  @override
  String get monthView => 'Vue mensuelle';

  @override
  String get weekView => 'Vue hebdomadaire';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get noEventsForDay => 'Aucun événement ce jour';

  @override
  String get goalDeadline => 'Échéance de l\'objectif';

  @override
  String get contribution => 'Contribution';

  @override
  String get reports => 'Rapports';

  @override
  String get week => 'Semaine';

  @override
  String get quarter => 'Trimestre';

  @override
  String get allTime => 'Tout le temps';

  @override
  String get totalPaid => 'Total payé';

  @override
  String get totalDebt => 'Dette totale';

  @override
  String get debtVsPaid => 'Dette vs Payé';

  @override
  String get outstanding => 'En cours';

  @override
  String get noDataYet => 'Aucune donnée pour l\'instant';

  @override
  String get monthlyOverview => 'Aperçu mensuel';

  @override
  String get due => 'Dû';

  @override
  String get paymentPerformance => 'Performance de paiement';

  @override
  String get onTime => 'À temps';

  @override
  String get late => 'En retard';

  @override
  String get onTimeRate => 'Taux de ponctualité';

  @override
  String get rateAlerts => 'Alertes de taux';

  @override
  String get currentMarketRates => 'Taux du marché actuels';

  @override
  String get edit => 'Modifier';

  @override
  String get triggeredAlerts => 'Alertes déclenchées';

  @override
  String get activeAlerts => 'Alertes actives';

  @override
  String get inactiveAlerts => 'Alertes inactives';

  @override
  String get noAlertsYet => 'Aucune alerte pour l\'instant';

  @override
  String get addAlertsSubtitle =>
      'Ajoutez des alertes pour suivre les changements de taux';

  @override
  String get addAlert => 'Ajouter une alerte';

  @override
  String get alertNameHint => 'Nom de l\'alerte (ex. Taux immobilier)';

  @override
  String get loanType => 'Type de prêt';

  @override
  String get alertWhen => 'Alerter quand';

  @override
  String get rateDrops => 'Le taux baisse';

  @override
  String get rateRises => 'Le taux monte';

  @override
  String get targetRate => 'Taux cible';

  @override
  String get when => 'Quand';

  @override
  String get current => 'Actuel';

  @override
  String get triggered => 'Déclenchée';

  @override
  String get editMarketRates => 'Modifier les taux du marché';

  @override
  String get personalLoan => 'Prêt personnel';

  @override
  String get carLoan => 'Prêt auto';

  @override
  String get savingsRate => 'Taux d\'épargne';

  @override
  String get homeShort => 'Immobilier';

  @override
  String get personalShort => 'Personnel';

  @override
  String get carShort => 'Auto';

  @override
  String get savingsShort => 'Épargne';

  @override
  String get rateDropAlert => 'Alerte de baisse de taux!';

  @override
  String get rateIncreaseAlert => 'Alerte de hausse de taux!';

  @override
  String get updated => 'Mis à jour';

  @override
  String get newUpdateAvailable => 'Mise à jour disponible';

  @override
  String get updateAppMessage =>
      'Une nouvelle version est disponible. Mettez à jour pour obtenir les dernières fonctionnalités et améliorations.';

  @override
  String get updateNow => 'Mettre à jour';

  @override
  String get later => 'Plus tard';

  @override
  String get qrTools => 'Outils QR';

  @override
  String get createQRCode => 'Créer un code QR';

  @override
  String get createQRSubtitle => 'Générer des codes QR';

  @override
  String get scanQRCode => 'Scanner un code QR';

  @override
  String get scanQRSubtitle => 'Scanner n\'importe quel code QR';

  @override
  String get selectQRType => 'Sélectionner le type de QR';

  @override
  String get qrLink => 'Lien';

  @override
  String get qrText => 'Texte';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => 'Contact';

  @override
  String get qrCode => 'Code QR';

  @override
  String get websiteAddress => 'Adresse du site web';

  @override
  String get textContent => 'Contenu texte';

  @override
  String get enterContent => 'Entrez votre contenu ici';

  @override
  String get networkNameSSID => 'Nom du réseau (SSID)';

  @override
  String get wifiPasswordLabel => 'Mot de passe';

  @override
  String get encryptionType => 'Type de chiffrement';

  @override
  String get noEncryption => 'Sans chiffrement';

  @override
  String get contactName => 'Nom du contact';

  @override
  String get contactNameHint => 'Jean Dupont';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get generateQRButton => 'Générer le code QR';

  @override
  String get qrGeneratedOnDevice => 'Le code QR est généré sur votre appareil';

  @override
  String get qrLinkInfo =>
      'Entrez une URL pour créer un code QR qui ouvre le lien lors du scan.';

  @override
  String get qrWifiInfo =>
      'Créez un code QR qui permet de se connecter rapidement à votre réseau WiFi.';

  @override
  String get pleaseEnterWebsite => 'Veuillez entrer une adresse web';

  @override
  String get pleaseEnterTextContent => 'Veuillez entrer du contenu texte';

  @override
  String get pleaseEnterWifiName => 'Veuillez entrer le nom du réseau WiFi';

  @override
  String get pleaseEnterContactName => 'Veuillez entrer le nom du contact';

  @override
  String get copy => 'Copier';

  @override
  String get copyData => 'Copier les données';

  @override
  String get dataCopied => 'Données copiées dans le presse-papiers';

  @override
  String get saveToGallery => 'Enregistrer dans la galerie';

  @override
  String get qrPrivacyNote =>
      'Ce code QR est généré localement sur votre appareil et n\'est pas envoyé à un serveur.';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return 'Contact: $name';
  }

  @override
  String get cannotCreateQRImage => 'Impossible de créer l\'image QR';

  @override
  String get cannotSaveQR => 'Impossible d\'enregistrer le code QR';

  @override
  String get qrSavedToGallerySuccess => 'Code QR enregistré dans la galerie';

  @override
  String errorWithMessage(String message) {
    return 'Erreur: $message';
  }

  @override
  String get scanAgain => 'Scanner à nouveau';

  @override
  String get openLink => 'Ouvrir le lien';

  @override
  String get copyPassword => 'Copier le mot de passe';

  @override
  String get passwordCopied => 'Mot de passe copié dans le presse-papiers';

  @override
  String get noQRCodeFound => 'Aucun code QR trouvé dans l\'image';

  @override
  String get pointCameraAtQR => 'Pointez la caméra vers le code QR';

  @override
  String get scanFromGallery => 'Scanner depuis la galerie';

  @override
  String get websiteLink => 'Lien web';

  @override
  String get wifiNetworkLabel => 'Réseau WiFi';

  @override
  String get openInBrowser => 'Ouvrir dans le navigateur';

  @override
  String get wifiCredentials => 'Identifiants WiFi';

  @override
  String get contactInformation => 'Informations de contact';

  @override
  String get plainTextContent => 'Contenu texte brut';

  @override
  String get reportIssue => 'Signaler un problème';

  @override
  String get reportIssueSubtitle => 'Envoyez-nous vos commentaires';

  @override
  String get earlyWithdrawal => 'Retrait Anticipé';

  @override
  String get earlyWithdrawalSubtitle => 'Calculer la perte de retrait';

  @override
  String get depositAmount => 'Montant du dépôt';

  @override
  String get termDepositRate => 'Taux de dépôt à terme';

  @override
  String get demandDepositRate => 'Taux de dépôt à vue';

  @override
  String get originalTerm => 'Durée initiale';

  @override
  String get actualHoldingPeriod => 'Période de détention réelle';

  @override
  String get withdrawalResult => 'Résultat du retrait';

  @override
  String get amountReceived => 'Montant reçu';

  @override
  String get actualInterestReceived => 'Intérêts réels reçus';

  @override
  String get interestLost => 'Intérêts perdus';

  @override
  String get lossPercentage => 'Pourcentage de perte';

  @override
  String get ifHeldToMaturity => 'Si maintenu jusqu\'à l\'échéance';

  @override
  String get youWillLose => 'Vous perdrez';

  @override
  String get earlyWithdrawalWarning => 'Avertissement de retrait anticipé';

  @override
  String get earlyWithdrawalWarningDesc =>
      'Le retrait anticipé applique le taux à vue au lieu du taux à terme.';
}
