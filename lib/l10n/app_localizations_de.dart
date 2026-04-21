// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Money Wave';

  @override
  String get appTagline => 'Berechnen Sie Ihre Zukunft';

  @override
  String get home => 'Startseite';

  @override
  String get saved => 'Gespeichert';

  @override
  String get history => 'Verlauf';

  @override
  String get settings => 'Einstellungen';

  @override
  String get compare => 'Vergleichen';

  @override
  String get simulate => 'Simulieren';

  @override
  String get mainTools => 'Hauptfunktionen';

  @override
  String categories(int count) {
    return '$count KATEGORIEN';
  }

  @override
  String get loanCalc => 'Kredit';

  @override
  String get loanCalcSubtitle => 'Monatliche Raten';

  @override
  String get interestCalc => 'Zinsen';

  @override
  String get interestCalcSubtitle => 'Einfach & Zinseszins';

  @override
  String get vault => 'Tresor';

  @override
  String get vaultSubtitle => 'Planen Sie Ihre Zukunft';

  @override
  String get historySubtitle => 'Frühere Berechnungen';

  @override
  String get proAccess => 'PRO ZUGANG';

  @override
  String get upgradeToPremium => 'Premium Upgrade';

  @override
  String get premiumBannerDesc =>
      'Erweiterte Diagramme und\nwerbefreies Erlebnis freischalten.';

  @override
  String get marketPulse => 'MARKTÜBERSICHT';

  @override
  String get currentRates => 'Aktuelle Zinssätze';

  @override
  String get homeLoan => 'Immobilienkredit';

  @override
  String get savingsApy => 'Sparzins APY';

  @override
  String get calculatorSimpleInterest => 'Einfacher Zins';

  @override
  String get calculatorCompoundInterest => 'Zinseszins';

  @override
  String get calculatorLoan => 'Kreditrechner';

  @override
  String get calculatorSavings => 'Sparrechner';

  @override
  String get principal => 'Kapital';

  @override
  String get interestRate => 'Zinssatz';

  @override
  String get annualInterestRate => 'Zinssatz (Jährlich)';

  @override
  String get term => 'Laufzeit';

  @override
  String get termMonths => 'Laufzeit (Monate)';

  @override
  String get termYears => 'Laufzeit (Jahre)';

  @override
  String get monthlyPayment => 'Monatliche Rate';

  @override
  String get firstMonthPayment => 'Erste Monatsrate';

  @override
  String get lastMonthPayment => 'Letzte Monatsrate';

  @override
  String get totalInterest => 'Gesamtzinsen';

  @override
  String get totalPayment => 'Gesamtzahlung';

  @override
  String get interest => 'Zinsen';

  @override
  String get totalAmount => 'Gesamtbetrag';

  @override
  String get interestPrincipalRatio => 'Zins/Kapital-Verhältnis';

  @override
  String get loanAmount => 'Kreditbetrag';

  @override
  String get paymentMethod => 'Zahlungsmethode';

  @override
  String get loanTypeFixed => 'Annuitätendarlehen';

  @override
  String get loanTypeReducing => 'Tilgungsdarlehen';

  @override
  String get savingsTypeReinvest => 'Reinvestieren';

  @override
  String get savingsTypeWithdraw => 'Auszahlen';

  @override
  String get results => 'Ergebnisse';

  @override
  String get paymentStructure => 'Zahlungsstruktur';

  @override
  String get amortizationSchedule => 'Tilgungsplan';

  @override
  String get month => 'Monat';

  @override
  String get year => 'Jahr';

  @override
  String get years => 'Jahre';

  @override
  String get payment => 'Zahlung';

  @override
  String get principalPaid => 'Tilgung';

  @override
  String get interestPaid => 'Zinsen';

  @override
  String get balance => 'Restschuld';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get share => 'Teilen';

  @override
  String get exportPdf => 'PDF Exportieren';

  @override
  String get calculate => 'Berechnen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get close => 'Schließen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get storageLimitTitle => 'Speicherlimit';

  @override
  String storageLimitLoans(int count) {
    return 'Sie haben maximal $count Kredite gespeichert. Upgraden Sie auf Premium für unbegrenzte Speicherung!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'Sie haben maximal $count Sparpläne gespeichert. Upgraden Sie auf Premium für unbegrenzte Speicherung!';
  }

  @override
  String get saveLoan => 'Kredit speichern';

  @override
  String get loanNameHint => 'Kreditname (optional)';

  @override
  String get amount => 'Betrag';

  @override
  String get rate => 'Zinssatz';

  @override
  String get loanSaved => 'Kredit gespeichert';

  @override
  String get saveSavings => 'Sparplan speichern';

  @override
  String get savingsNameHint => 'Sparplanname (optional)';

  @override
  String get savingsSaved => 'Sparplan gespeichert';

  @override
  String get savedLoans => 'Gespeicherte Kredite';

  @override
  String get savedSavings => 'Gespeicherte Sparpläne';

  @override
  String loansCount(int count) {
    return 'Kredite ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'Sparpläne ($count)';
  }

  @override
  String get noSavedItems => 'Keine gespeicherten Einträge';

  @override
  String get noSavedLoans => 'Keine gespeicherten Kredite';

  @override
  String get noSavedLoansSubtitle =>
      'Berechnen und speichern Sie Kredite zur späteren Ansicht';

  @override
  String get noSavedSavings => 'Keine gespeicherten Sparpläne';

  @override
  String get noSavedSavingsSubtitle =>
      'Berechnen und speichern Sie Sparpläne zur späteren Ansicht';

  @override
  String errorLoading(String error) {
    return 'Fehler: $error';
  }

  @override
  String get compoundingFrequency => 'Zinseszinshäufigkeit';

  @override
  String get daily => 'Täglich';

  @override
  String get monthly => 'Monatlich';

  @override
  String get quarterly => 'Vierteljährlich';

  @override
  String get yearly => 'Jährlich';

  @override
  String get calculationResults => 'Berechnungsergebnisse';

  @override
  String get totalReceived => 'Gesamterhalt';

  @override
  String get interestEarned => 'Verdiente Zinsen';

  @override
  String get effectiveAnnualRate => 'Effektiver Jahreszins';

  @override
  String get compoundingPeriods => 'Zinseszinsperioden';

  @override
  String get compareWithSimple => 'Mit einfachem Zins vergleichen';

  @override
  String get simpleInterest => 'Einfacher Zins';

  @override
  String get compoundInterest => 'Zinseszins';

  @override
  String compoundBenefit(String amount) {
    return 'Zinseszins bringt Ihnen $amount mehr';
  }

  @override
  String get savingsType => 'Sparart';

  @override
  String get initialDeposit => 'Ersteinlage';

  @override
  String get monthlyDeposit => 'Monatliche Einlage';

  @override
  String get annualRate => 'Jahreszins';

  @override
  String get finalBalance => 'Endguthaben';

  @override
  String get totalDeposited => 'Gesamteinzahlung';

  @override
  String get returnRate => 'Rendite';

  @override
  String get avgMonthlyInterest => 'Durchschn. Monatszins';

  @override
  String get detailedAnalysis => 'Detaillierte Analyse';

  @override
  String get deposits => 'Einlagen';

  @override
  String get reinvestInfo => 'Zinsen werden monatlich verzinst';

  @override
  String get withdrawInfo =>
      'Zinsen werden monatlich ausgezahlt, nicht verzinst';

  @override
  String get averageMonthlyInterest => 'Durchschn. Zins/Monat';

  @override
  String get totalStructure => 'Gesamtstruktur';

  @override
  String get premium => 'Premium Upgrade';

  @override
  String get premiumActivated => 'Sie sind Premium!';

  @override
  String get premiumMember => 'Premium-Mitglied';

  @override
  String get premiumThanks => 'Vielen Dank für Ihre Unterstützung!';

  @override
  String get premiumDescription => 'Alle Funktionen freischalten';

  @override
  String get premiumFeature1 => 'Unbegrenzt speichern';

  @override
  String get premiumFeature1Desc =>
      'Speichern Sie alle Ihre Kredite und Sparpläne';

  @override
  String get premiumFeature2 => 'Vollständige Diagramme';

  @override
  String get premiumFeature2Desc => 'Details mit allen Diagrammtypen anzeigen';

  @override
  String get premiumFeature3 => 'Szenariovergleich';

  @override
  String get premiumFeature3Desc =>
      'Mehrere Optionen nebeneinander vergleichen';

  @override
  String get premiumFeature4 => 'PDF Export';

  @override
  String get premiumFeature4Desc =>
      'Detaillierte Berichte zum Drucken oder Teilen erstellen';

  @override
  String get premiumFeature5 => 'Entwicklung unterstützen';

  @override
  String get premiumFeature5Desc => 'Helfen Sie uns, die App zu verbessern';

  @override
  String get premiumFeatures => 'Premium-Funktionen';

  @override
  String get lifetime => 'Lebenslang';

  @override
  String get oneTimePurchase => 'Einmal zahlen, für immer nutzen';

  @override
  String get upgradeNow => 'Jetzt upgraden';

  @override
  String get restorePurchase => 'Kauf wiederherstellen';

  @override
  String purchaseDate(String date) {
    return 'Kaufdatum: $date';
  }

  @override
  String get premiumRequired => 'Premium erforderlich';

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
    return 'Upgrade auf $feature';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => 'Aktiviert';

  @override
  String get unlockAllFeatures => 'Alle Funktionen freischalten';

  @override
  String get theme => 'Design';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeSystem => 'System';

  @override
  String get language => 'Sprache';

  @override
  String get about => 'Über';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get error => 'Fehler';

  @override
  String get errorGeneric => 'Etwas ist schiefgelaufen';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get ok => 'OK';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get compareScenarios => 'Szenarien vergleichen';

  @override
  String get upgradeToCompare => 'Upgrade zum Vergleichen von Szenarien';

  @override
  String get loanSettings => 'Krediteinstellungen';

  @override
  String get scenarioA => 'Szenario A';

  @override
  String get scenarioB => 'Szenario B';

  @override
  String get comparison => 'Vergleich';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'Szenario $scenario spart $amount';
  }

  @override
  String get simulation => 'Simulation';

  @override
  String get noScenariosYet => 'Noch keine Szenarien';

  @override
  String get addScenariosSubtitle =>
      'Fügen Sie Kredite oder Sparpläne hinzu,\num Ihre Finanzen zu simulieren';

  @override
  String get addLoan => 'Kredit hinzufügen';

  @override
  String get addSavings => 'Sparplan hinzufügen';

  @override
  String get loans => 'Kredite';

  @override
  String get savings => 'Sparpläne';

  @override
  String get timeline => 'Zeitachse';

  @override
  String monthNumber(int number) {
    return 'Monat $number';
  }

  @override
  String get netWorth => 'Nettovermögen';

  @override
  String get positive => 'Positiv';

  @override
  String get negativeDebt => 'Negativ (Schulden)';

  @override
  String get now => 'Jetzt';

  @override
  String yearsCount(int count) {
    return '$count Jahre';
  }

  @override
  String get debt => 'Schulden';

  @override
  String get remaining => 'Verbleibend';

  @override
  String get clearAll => 'Alles löschen?';

  @override
  String get allScenariosDeleted => 'Alle Szenarien werden gelöscht.';

  @override
  String get loanNameHintExample => 'Kreditname (z.B. Immobilienkredit)';

  @override
  String get savingsNameHintExample => 'Name (z.B. Altersvorsorge)';

  @override
  String get deposit => 'Einlage';

  @override
  String get loan => 'Kredit';

  @override
  String get selectThemeDescription => 'Wählen Sie ein Design für Ihre App';

  @override
  String get selectLanguageDescription => 'Wählen Sie Ihre bevorzugte Sprache';

  @override
  String get apply => 'Anwenden';

  @override
  String get financialTools => 'Finanztools';

  @override
  String get reminders => 'Erinnerungen';

  @override
  String get paymentRemindersSubtitle => 'Fälligkeiten verfolgen';

  @override
  String get savingsGoalsSubtitle => 'Ihre Ziele erreichen';

  @override
  String get calendar => 'Kalender';

  @override
  String get calendarSubtitle => 'Alle Ereignisse anzeigen';

  @override
  String get achievementsSubtitle => 'Ihr Fortschritt';

  @override
  String get reportsSubtitle => 'Statistiken anzeigen';

  @override
  String get rateAlertsSubtitle => 'Zinssätze überwachen';

  @override
  String get paymentReminders => 'Zahlungserinnerungen';

  @override
  String get noRemindersYet => 'Noch keine Erinnerungen';

  @override
  String get addRemindersSubtitle => 'Fügen Sie Zahlungserinnerungen hinzu';

  @override
  String get addReminder => 'Erinnerung hinzufügen';

  @override
  String get editReminder => 'Erinnerung bearbeiten';

  @override
  String get reminderNameHint => 'Erinnerungsname (z.B. Kreditkarte)';

  @override
  String get dueDate => 'Fälligkeitsdatum';

  @override
  String get remindBefore => 'Vorher erinnern';

  @override
  String get days => 'Tage';

  @override
  String get recurring => 'Wiederkehrend';

  @override
  String get totalDue => 'Gesamtbetrag fällig';

  @override
  String get overdue => 'Überfällig';

  @override
  String get upcoming => 'Bevorstehend';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get markAsPaid => 'Als bezahlt markieren';

  @override
  String get markAsPaidConfirm =>
      'Möchten Sie dies wirklich als bezahlt markieren?';

  @override
  String get pending => 'Ausstehend';

  @override
  String get paid => 'Bezahlt';

  @override
  String get skipped => 'Übersprungen';

  @override
  String get markPaid => 'Bezahlt markieren';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get biWeekly => 'Alle zwei Wochen';

  @override
  String get dueToday => 'Heute fällig';

  @override
  String get dueTomorrow => 'Morgen fällig';

  @override
  String dueInDays(int days) {
    return 'Fällig in $days Tagen';
  }

  @override
  String get pleaseEnterName => 'Bitte geben Sie einen Namen ein';

  @override
  String get savingsGoals => 'Sparziele';

  @override
  String get noGoalsYet => 'Noch keine Ziele';

  @override
  String get addGoalsSubtitle =>
      'Setzen Sie Sparziele und verfolgen Sie Ihren Fortschritt';

  @override
  String get addGoal => 'Ziel hinzufügen';

  @override
  String get editGoal => 'Ziel bearbeiten';

  @override
  String get goalNameHint => 'Zielname (z.B. Urlaub)';

  @override
  String get targetAmount => 'Zielbetrag';

  @override
  String get initialAmount => 'Anfangsbetrag';

  @override
  String get deadline => 'Frist';

  @override
  String get suggestedMonthly => 'Empfohlener Monatsbetrag';

  @override
  String get activeGoals => 'Aktive Ziele';

  @override
  String get completedGoals => 'Abgeschlossene Ziele';

  @override
  String get totalSaved => 'Gesamt gespart';

  @override
  String get totalTarget => 'Gesamtziel';

  @override
  String get ofTotalTarget => 'des Gesamtziels';

  @override
  String get milestones => 'Meilensteine';

  @override
  String get addMoney => 'Geld hinzufügen';

  @override
  String get withdraw => 'Abheben';

  @override
  String get addContribution => 'Beitrag hinzufügen';

  @override
  String get notesOptional => 'Notizen (optional)';

  @override
  String get withdrawReason => 'Grund der Abhebung';

  @override
  String get noContributionsYet => 'Noch keine Beiträge';

  @override
  String get pauseGoal => 'Ziel pausieren';

  @override
  String get deleteGoal => 'Ziel löschen';

  @override
  String get deleteGoalConfirm => 'Möchten Sie dieses Ziel wirklich löschen?';

  @override
  String get target => 'Ziel';

  @override
  String get goals => 'Ziele';

  @override
  String savePerMonth(String amount) {
    return 'Sparen Sie $amount/Monat, um das Ziel zu erreichen';
  }

  @override
  String get pleaseEnterGoalName => 'Bitte geben Sie einen Zielnamen ein';

  @override
  String get withdrawal => 'Abhebung';

  @override
  String get start => 'Start';

  @override
  String get goalReached => 'Ziel erreicht!';

  @override
  String get progress => 'Fortschritt';

  @override
  String get achievements => 'Erfolge';

  @override
  String get financialHealthScore => 'Finanzielle Gesundheitsbewertung';

  @override
  String get financialHealth => 'Finanzielle Gesundheit';

  @override
  String get points => 'Punkte';

  @override
  String get healthExcellent => 'Ausgezeichnet! Weiter so!';

  @override
  String get healthGood => 'Guter Fortschritt! Sie sind auf dem richtigen Weg.';

  @override
  String get healthFair => 'Befriedigend. Es gibt Verbesserungspotenzial.';

  @override
  String get healthNeedsWork =>
      'Verbesserungsbedarf. Lassen Sie uns gemeinsam verbessern!';

  @override
  String get paymentStreak => 'Zahlungsserie';

  @override
  String get dayStreak => 'Tage-Serie';

  @override
  String get keepItUp => 'Weiter so!';

  @override
  String get longest => 'Längste';

  @override
  String get unlocked => 'Freigeschaltet';

  @override
  String get locked => 'Gesperrt';

  @override
  String get financialCalendar => 'Finanzkalender';

  @override
  String get monthView => 'Monatsansicht';

  @override
  String get weekView => 'Wochenansicht';

  @override
  String get today => 'Heute';

  @override
  String get noEventsForDay => 'Keine Ereignisse für diesen Tag';

  @override
  String get goalDeadline => 'Zielfrist';

  @override
  String get contribution => 'Beitrag';

  @override
  String get reports => 'Berichte';

  @override
  String get week => 'Woche';

  @override
  String get quarter => 'Quartal';

  @override
  String get allTime => 'Gesamt';

  @override
  String get totalPaid => 'Gesamt bezahlt';

  @override
  String get totalDebt => 'Gesamtschulden';

  @override
  String get debtVsPaid => 'Schulden vs. Bezahlt';

  @override
  String get outstanding => 'Ausstehend';

  @override
  String get noDataYet => 'Noch keine Daten';

  @override
  String get monthlyOverview => 'Monatsübersicht';

  @override
  String get due => 'Fällig';

  @override
  String get paymentPerformance => 'Zahlungsleistung';

  @override
  String get onTime => 'Pünktlich';

  @override
  String get late => 'Verspätet';

  @override
  String get onTimeRate => 'Pünktlichkeitsrate';

  @override
  String get rateAlerts => 'Zinsalarme';

  @override
  String get currentMarketRates => 'Aktuelle Marktzinsen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get triggeredAlerts => 'Ausgelöste Alarme';

  @override
  String get activeAlerts => 'Aktive Alarme';

  @override
  String get inactiveAlerts => 'Inaktive Alarme';

  @override
  String get noAlertsYet => 'Noch keine Alarme';

  @override
  String get addAlertsSubtitle =>
      'Alarme hinzufügen, um Zinsänderungen zu verfolgen';

  @override
  String get addAlert => 'Alarm hinzufügen';

  @override
  String get alertNameHint => 'Alarmname (z.B. Immobilienkredit-Zins)';

  @override
  String get loanType => 'Kreditart';

  @override
  String get alertWhen => 'Alarm wenn';

  @override
  String get rateDrops => 'Zinssatz sinkt';

  @override
  String get rateRises => 'Zinssatz steigt';

  @override
  String get targetRate => 'Zielzinssatz';

  @override
  String get when => 'Wann';

  @override
  String get current => 'Aktuell';

  @override
  String get triggered => 'Ausgelöst';

  @override
  String get editMarketRates => 'Marktzinsen bearbeiten';

  @override
  String get personalLoan => 'Privatkredit';

  @override
  String get carLoan => 'Autokredit';

  @override
  String get savingsRate => 'Sparzins';

  @override
  String get homeShort => 'Immobilien';

  @override
  String get personalShort => 'Privat';

  @override
  String get carShort => 'Auto';

  @override
  String get savingsShort => 'Sparen';

  @override
  String get rateDropAlert => 'Zinssenkungsalarm!';

  @override
  String get rateIncreaseAlert => 'Zinserhöhungsalarm!';

  @override
  String get updated => 'Aktualisiert';

  @override
  String get newUpdateAvailable => 'Update verfügbar';

  @override
  String get updateAppMessage =>
      'Eine neue Version ist verfügbar. Aktualisieren Sie, um die neuesten Funktionen und Verbesserungen zu erhalten.';

  @override
  String get updateNow => 'Jetzt aktualisieren';

  @override
  String get later => 'Später';

  @override
  String get qrTools => 'QR-Tools';

  @override
  String get createQRCode => 'QR-Code erstellen';

  @override
  String get createQRSubtitle => 'QR-Codes generieren';

  @override
  String get scanQRCode => 'QR-Code scannen';

  @override
  String get scanQRSubtitle => 'Jeden QR-Code scannen';

  @override
  String get selectQRType => 'QR-Typ auswählen';

  @override
  String get qrLink => 'Link';

  @override
  String get qrText => 'Text';

  @override
  String get qrWifi => 'WLAN';

  @override
  String get qrContact => 'Kontakt';

  @override
  String get qrCode => 'QR-Code';

  @override
  String get websiteAddress => 'Website-Adresse';

  @override
  String get textContent => 'Textinhalt';

  @override
  String get enterContent => 'Geben Sie Ihren Inhalt hier ein';

  @override
  String get networkNameSSID => 'Netzwerkname (SSID)';

  @override
  String get wifiPasswordLabel => 'Passwort';

  @override
  String get encryptionType => 'Verschlüsselungstyp';

  @override
  String get noEncryption => 'Keine Verschlüsselung';

  @override
  String get contactName => 'Kontaktname';

  @override
  String get contactNameHint => 'Max Mustermann';

  @override
  String get phoneNumber => 'Telefonnummer';

  @override
  String get generateQRButton => 'QR-Code generieren';

  @override
  String get qrGeneratedOnDevice => 'QR-Code wird auf Ihrem Gerät generiert';

  @override
  String get qrLinkInfo =>
      'Geben Sie eine Website-URL ein, um einen QR-Code zu erstellen, der den Link beim Scannen öffnet.';

  @override
  String get qrWifiInfo =>
      'Erstellen Sie einen QR-Code, mit dem andere schnell eine Verbindung zu Ihrem WLAN herstellen können.';

  @override
  String get pleaseEnterWebsite => 'Bitte geben Sie eine Website-Adresse ein';

  @override
  String get pleaseEnterTextContent => 'Bitte geben Sie Textinhalt ein';

  @override
  String get pleaseEnterWifiName =>
      'Bitte geben Sie den WLAN-Netzwerknamen ein';

  @override
  String get pleaseEnterContactName => 'Bitte geben Sie den Kontaktnamen ein';

  @override
  String get copy => 'Kopieren';

  @override
  String get copyData => 'Daten kopieren';

  @override
  String get dataCopied => 'Daten in die Zwischenablage kopiert';

  @override
  String get saveToGallery => 'In Galerie speichern';

  @override
  String get qrPrivacyNote =>
      'Dieser QR-Code wird lokal auf Ihrem Gerät generiert und nicht an einen Server gesendet.';

  @override
  String wifiNetwork(String name) {
    return 'WLAN: $name';
  }

  @override
  String contactInfo(String name) {
    return 'Kontakt: $name';
  }

  @override
  String get cannotCreateQRImage => 'QR-Bild kann nicht erstellt werden';

  @override
  String get cannotSaveQR => 'QR-Code kann nicht gespeichert werden';

  @override
  String get qrSavedToGallerySuccess => 'QR-Code in Galerie gespeichert';

  @override
  String errorWithMessage(String message) {
    return 'Fehler: $message';
  }

  @override
  String get scanAgain => 'Erneut scannen';

  @override
  String get openLink => 'Link öffnen';

  @override
  String get copyPassword => 'Passwort kopieren';

  @override
  String get passwordCopied => 'Passwort in die Zwischenablage kopiert';

  @override
  String get noQRCodeFound => 'Kein QR-Code im Bild gefunden';

  @override
  String get pointCameraAtQR => 'Kamera auf QR-Code richten';

  @override
  String get scanFromGallery => 'Aus Galerie scannen';

  @override
  String get websiteLink => 'Website-Link';

  @override
  String get wifiNetworkLabel => 'WLAN-Netzwerk';

  @override
  String get openInBrowser => 'Im Browser öffnen';

  @override
  String get wifiCredentials => 'WLAN-Anmeldedaten';

  @override
  String get contactInformation => 'Kontaktinformationen';

  @override
  String get plainTextContent => 'Einfacher Textinhalt';

  @override
  String get reportIssue => 'Problem melden';

  @override
  String get reportIssueSubtitle => 'Feedback senden';

  @override
  String get earlyWithdrawal => 'Vorzeitige Abhebung';

  @override
  String get earlyWithdrawalSubtitle => 'Verlust bei vorzeitiger Kündigung';

  @override
  String get depositAmount => 'Einlagebetrag';

  @override
  String get termDepositRate => 'Festgeldzins';

  @override
  String get demandDepositRate => 'Sichtzins';

  @override
  String get originalTerm => 'Ursprüngliche Laufzeit';

  @override
  String get actualHoldingPeriod => 'Tatsächliche Haltedauer';

  @override
  String get withdrawalResult => 'Abhebungsergebnis';

  @override
  String get amountReceived => 'Erhaltener Betrag';

  @override
  String get actualInterestReceived => 'Tatsächlich erhaltene Zinsen';

  @override
  String get interestLost => 'Verlorene Zinsen';

  @override
  String get lossPercentage => 'Verlustprozentsatz';

  @override
  String get ifHeldToMaturity => 'Bei Halten bis Fälligkeit';

  @override
  String get youWillLose => 'Sie verlieren';

  @override
  String get earlyWithdrawalWarning => 'Warnung vor vorzeitiger Abhebung';

  @override
  String get earlyWithdrawalWarningDesc =>
      'Bei vorzeitiger Abhebung gilt der Sichtzins statt des Festgeldzinses.';
}
