// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'Money Wave';

  @override
  String get appTagline => 'あなたの未来を計算';

  @override
  String get home => 'ホーム';

  @override
  String get saved => '保存済み';

  @override
  String get history => '履歴';

  @override
  String get settings => '設定';

  @override
  String get compare => '比較';

  @override
  String get simulate => 'シミュレーション';

  @override
  String get mainTools => 'メインツール';

  @override
  String categories(int count) {
    return '$count カテゴリー';
  }

  @override
  String get loanCalc => 'ローン';

  @override
  String get loanCalcSubtitle => '月々の支払い';

  @override
  String get interestCalc => '利息';

  @override
  String get interestCalcSubtitle => '単利と複利';

  @override
  String get vault => '金庫';

  @override
  String get vaultSubtitle => '未来を計画';

  @override
  String get historySubtitle => '過去の計算';

  @override
  String get proAccess => 'PRO アクセス';

  @override
  String get upgradeToPremium => 'プレミアムにアップグレード';

  @override
  String get premiumBannerDesc => '高度なチャートと\n広告なしの体験をアンロック。';

  @override
  String get marketPulse => 'マーケット動向';

  @override
  String get currentRates => '現在の金利';

  @override
  String get homeLoan => '住宅ローン';

  @override
  String get savingsApy => '貯蓄APY';

  @override
  String get calculatorSimpleInterest => '単利計算';

  @override
  String get calculatorCompoundInterest => '複利計算';

  @override
  String get calculatorLoan => 'ローン計算機';

  @override
  String get calculatorSavings => '貯蓄計算機';

  @override
  String get principal => '元本';

  @override
  String get interestRate => '金利';

  @override
  String get annualInterestRate => '年利';

  @override
  String get term => '期間';

  @override
  String get termMonths => '期間（月）';

  @override
  String get termYears => '期間（年）';

  @override
  String get monthlyPayment => '月々の支払い';

  @override
  String get firstMonthPayment => '初月の支払い';

  @override
  String get lastMonthPayment => '最終月の支払い';

  @override
  String get totalInterest => '総利息';

  @override
  String get totalPayment => '総支払額';

  @override
  String get interest => '利息';

  @override
  String get totalAmount => '合計金額';

  @override
  String get interestPrincipalRatio => '利息/元本比';

  @override
  String get loanAmount => 'ローン金額';

  @override
  String get paymentMethod => '支払方法';

  @override
  String get loanTypeFixed => '元利均等';

  @override
  String get loanTypeReducing => '元金均等';

  @override
  String get savingsTypeReinvest => '再投資';

  @override
  String get savingsTypeWithdraw => '引き出し';

  @override
  String get results => '結果';

  @override
  String get paymentStructure => '支払い構造';

  @override
  String get amortizationSchedule => '返済スケジュール';

  @override
  String get month => '月';

  @override
  String get year => '年';

  @override
  String get years => '年';

  @override
  String get payment => '支払い';

  @override
  String get principalPaid => '元本';

  @override
  String get interestPaid => '利息';

  @override
  String get balance => '残高';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get share => '共有';

  @override
  String get exportPdf => 'PDF出力';

  @override
  String get calculate => '計算';

  @override
  String get reset => 'リセット';

  @override
  String get close => '閉じる';

  @override
  String get add => '追加';

  @override
  String get storageLimitTitle => '保存制限';

  @override
  String storageLimitLoans(int count) {
    return '最大$count件のローンを保存しました。無制限に保存するにはプレミアムにアップグレードしてください！';
  }

  @override
  String storageLimitSavings(int count) {
    return '最大$count件の貯蓄を保存しました。無制限に保存するにはプレミアムにアップグレードしてください！';
  }

  @override
  String get saveLoan => 'ローンを保存';

  @override
  String get loanNameHint => 'ローン名（任意）';

  @override
  String get amount => '金額';

  @override
  String get rate => '金利';

  @override
  String get loanSaved => 'ローンを保存しました';

  @override
  String get saveSavings => '貯蓄を保存';

  @override
  String get savingsNameHint => '貯蓄名（任意）';

  @override
  String get savingsSaved => '貯蓄を保存しました';

  @override
  String get savedLoans => '保存済みローン';

  @override
  String get savedSavings => '保存済み貯蓄';

  @override
  String loansCount(int count) {
    return 'ローン ($count)';
  }

  @override
  String savingsCount(int count) {
    return '貯蓄 ($count)';
  }

  @override
  String get noSavedItems => '保存された項目はありません';

  @override
  String get noSavedLoans => '保存されたローンはありません';

  @override
  String get noSavedLoansSubtitle => 'ローンを計算して保存すると後で確認できます';

  @override
  String get noSavedSavings => '保存された貯蓄はありません';

  @override
  String get noSavedSavingsSubtitle => '貯蓄を計算して保存すると後で確認できます';

  @override
  String errorLoading(String error) {
    return 'エラー: $error';
  }

  @override
  String get compoundingFrequency => '複利の頻度';

  @override
  String get daily => '毎日';

  @override
  String get monthly => '毎月';

  @override
  String get quarterly => '四半期ごと';

  @override
  String get yearly => '毎年';

  @override
  String get calculationResults => '計算結果';

  @override
  String get totalReceived => '受取総額';

  @override
  String get interestEarned => '利息収入';

  @override
  String get effectiveAnnualRate => '実効年利';

  @override
  String get compoundingPeriods => '複利期間';

  @override
  String get compareWithSimple => '単利と比較';

  @override
  String get simpleInterest => '単利';

  @override
  String get compoundInterest => '複利';

  @override
  String compoundBenefit(String amount) {
    return '複利により $amount 多く獲得';
  }

  @override
  String get savingsType => '貯蓄タイプ';

  @override
  String get initialDeposit => '初期預金';

  @override
  String get monthlyDeposit => '毎月の預金';

  @override
  String get annualRate => '年利';

  @override
  String get finalBalance => '最終残高';

  @override
  String get totalDeposited => '預金総額';

  @override
  String get returnRate => '収益率';

  @override
  String get avgMonthlyInterest => '平均月利';

  @override
  String get detailedAnalysis => '詳細分析';

  @override
  String get deposits => '預金';

  @override
  String get reinvestInfo => '利息は毎月複利で計算されます';

  @override
  String get withdrawInfo => '利息は毎月支払われ、複利なし';

  @override
  String get averageMonthlyInterest => '平均月利';

  @override
  String get totalStructure => '全体構造';

  @override
  String get premium => 'プレミアムにアップグレード';

  @override
  String get premiumActivated => 'プレミアム会員です！';

  @override
  String get premiumMember => 'プレミアム会員';

  @override
  String get premiumThanks => 'ご支援ありがとうございます！';

  @override
  String get premiumDescription => 'すべての機能をアンロック';

  @override
  String get premiumFeature1 => '無制限の保存';

  @override
  String get premiumFeature1Desc => 'すべてのローンと貯蓄を保存';

  @override
  String get premiumFeature2 => '完全なチャート';

  @override
  String get premiumFeature2Desc => 'すべてのチャートタイプで詳細を確認';

  @override
  String get premiumFeature3 => 'シナリオ比較';

  @override
  String get premiumFeature3Desc => '複数のオプションを並べて比較';

  @override
  String get premiumFeature4 => 'PDF出力';

  @override
  String get premiumFeature4Desc => '印刷や共有用の詳細レポートを作成';

  @override
  String get premiumFeature5 => '開発をサポート';

  @override
  String get premiumFeature5Desc => 'アプリの改善にご協力ください';

  @override
  String get premiumFeatures => 'プレミアム機能';

  @override
  String get lifetime => '永久';

  @override
  String get oneTimePurchase => '一度の支払いで永久に使用';

  @override
  String get upgradeNow => '今すぐアップグレード';

  @override
  String get restorePurchase => '購入を復元';

  @override
  String purchaseDate(String date) {
    return '購入日: $date';
  }

  @override
  String get premiumRequired => 'プレミアムが必要';

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
    return '$featureにアップグレード';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => '有効';

  @override
  String get unlockAllFeatures => 'すべての機能をアンロック';

  @override
  String get theme => 'テーマ';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeSystem => 'システム';

  @override
  String get language => '言語';

  @override
  String get about => 'このアプリについて';

  @override
  String version(String version) {
    return 'バージョン $version';
  }

  @override
  String get termsOfService => '利用規約';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get error => 'エラー';

  @override
  String get errorGeneric => '問題が発生しました';

  @override
  String get tryAgain => '再試行';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get ok => 'OK';

  @override
  String get upgrade => 'アップグレード';

  @override
  String get compareScenarios => 'シナリオを比較';

  @override
  String get upgradeToCompare => '比較するにはアップグレード';

  @override
  String get loanSettings => 'ローン設定';

  @override
  String get scenarioA => 'シナリオ A';

  @override
  String get scenarioB => 'シナリオ B';

  @override
  String get comparison => '比較';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'シナリオ $scenario は $amount 節約';
  }

  @override
  String get simulation => 'シミュレーション';

  @override
  String get noScenariosYet => 'シナリオはまだありません';

  @override
  String get addScenariosSubtitle => 'ローンや貯蓄を追加して\n財務をシミュレーション';

  @override
  String get addLoan => 'ローンを追加';

  @override
  String get addSavings => '貯蓄を追加';

  @override
  String get loans => 'ローン';

  @override
  String get savings => '貯蓄';

  @override
  String get timeline => 'タイムライン';

  @override
  String monthNumber(int number) {
    return '$numberヶ月目';
  }

  @override
  String get netWorth => '純資産';

  @override
  String get positive => 'プラス';

  @override
  String get negativeDebt => 'マイナス（負債）';

  @override
  String get now => '現在';

  @override
  String yearsCount(int count) {
    return '$count年';
  }

  @override
  String get debt => '負債';

  @override
  String get remaining => '残り';

  @override
  String get clearAll => 'すべてクリア？';

  @override
  String get allScenariosDeleted => 'すべてのシナリオが削除されます。';

  @override
  String get loanNameHintExample => 'ローン名（例：住宅ローン）';

  @override
  String get savingsNameHintExample => '名前（例：退職金）';

  @override
  String get deposit => '預金';

  @override
  String get loan => 'ローン';

  @override
  String get selectThemeDescription => 'アプリのテーマを選択';

  @override
  String get selectLanguageDescription => '言語を選択';

  @override
  String get apply => '適用';

  @override
  String get financialTools => '財務ツール';

  @override
  String get reminders => 'リマインダー';

  @override
  String get paymentRemindersSubtitle => '支払日を追跡';

  @override
  String get savingsGoalsSubtitle => '目標を達成';

  @override
  String get calendar => 'カレンダー';

  @override
  String get calendarSubtitle => 'すべてのイベントを表示';

  @override
  String get achievementsSubtitle => 'あなたの進捗';

  @override
  String get reportsSubtitle => '統計を表示';

  @override
  String get rateAlertsSubtitle => '金利を監視';

  @override
  String get paymentReminders => '支払いリマインダー';

  @override
  String get noRemindersYet => 'リマインダーはまだありません';

  @override
  String get addRemindersSubtitle => '支払いリマインダーを追加';

  @override
  String get addReminder => 'リマインダーを追加';

  @override
  String get editReminder => 'リマインダーを編集';

  @override
  String get reminderNameHint => 'リマインダー名（例：クレジットカード）';

  @override
  String get dueDate => '期日';

  @override
  String get remindBefore => '事前に通知';

  @override
  String get days => '日';

  @override
  String get recurring => '繰り返し';

  @override
  String get totalDue => '合計支払額';

  @override
  String get overdue => '期限超過';

  @override
  String get upcoming => '近日中';

  @override
  String get completed => '完了';

  @override
  String get markAsPaid => '支払い済みにする';

  @override
  String get markAsPaidConfirm => '支払い済みにしますか？';

  @override
  String get pending => '保留中';

  @override
  String get paid => '支払い済み';

  @override
  String get skipped => 'スキップ';

  @override
  String get markPaid => '支払い済み';

  @override
  String get weekly => '毎週';

  @override
  String get biWeekly => '隔週';

  @override
  String get dueToday => '今日が期日';

  @override
  String get dueTomorrow => '明日が期日';

  @override
  String dueInDays(int days) {
    return '$days日後が期日';
  }

  @override
  String get pleaseEnterName => '名前を入力してください';

  @override
  String get savingsGoals => '貯蓄目標';

  @override
  String get noGoalsYet => '目標はまだありません';

  @override
  String get addGoalsSubtitle => '貯蓄目標を設定して進捗を追跡';

  @override
  String get addGoal => '目標を追加';

  @override
  String get editGoal => '目標を編集';

  @override
  String get goalNameHint => '目標名（例：旅行）';

  @override
  String get targetAmount => '目標金額';

  @override
  String get initialAmount => '初期金額';

  @override
  String get deadline => '期限';

  @override
  String get suggestedMonthly => '推奨月額';

  @override
  String get activeGoals => '進行中の目標';

  @override
  String get completedGoals => '達成した目標';

  @override
  String get totalSaved => '総貯蓄額';

  @override
  String get totalTarget => '総目標額';

  @override
  String get ofTotalTarget => '総目標の';

  @override
  String get milestones => 'マイルストーン';

  @override
  String get addMoney => '入金';

  @override
  String get withdraw => '引き出し';

  @override
  String get addContribution => '貢献を追加';

  @override
  String get notesOptional => 'メモ（任意）';

  @override
  String get withdrawReason => '引き出しの理由';

  @override
  String get noContributionsYet => '貢献はまだありません';

  @override
  String get pauseGoal => '目標を一時停止';

  @override
  String get deleteGoal => '目標を削除';

  @override
  String get deleteGoalConfirm => 'この目標を削除しますか？';

  @override
  String get target => '目標';

  @override
  String get goals => '目標';

  @override
  String savePerMonth(String amount) {
    return '目標達成のため月々 $amount を貯蓄';
  }

  @override
  String get pleaseEnterGoalName => '目標名を入力してください';

  @override
  String get withdrawal => '引き出し';

  @override
  String get start => '開始';

  @override
  String get goalReached => '目標達成！';

  @override
  String get progress => '進捗';

  @override
  String get achievements => '実績';

  @override
  String get financialHealthScore => '財務健全性スコア';

  @override
  String get financialHealth => '財務健全性';

  @override
  String get points => 'ポイント';

  @override
  String get healthExcellent => '素晴らしい！この調子で！';

  @override
  String get healthGood => '順調です！正しい道を進んでいます。';

  @override
  String get healthFair => 'まあまあ。改善の余地があります。';

  @override
  String get healthNeedsWork => '注意が必要。一緒に改善しましょう！';

  @override
  String get paymentStreak => '連続支払い';

  @override
  String get dayStreak => '日連続';

  @override
  String get keepItUp => 'この調子で！';

  @override
  String get longest => '最長';

  @override
  String get unlocked => 'アンロック済み';

  @override
  String get locked => 'ロック中';

  @override
  String get financialCalendar => '財務カレンダー';

  @override
  String get monthView => '月表示';

  @override
  String get weekView => '週表示';

  @override
  String get today => '今日';

  @override
  String get noEventsForDay => 'この日のイベントはありません';

  @override
  String get goalDeadline => '目標期限';

  @override
  String get contribution => '貢献';

  @override
  String get reports => 'レポート';

  @override
  String get week => '週';

  @override
  String get quarter => '四半期';

  @override
  String get allTime => 'すべて';

  @override
  String get totalPaid => '支払い総額';

  @override
  String get totalDebt => '負債総額';

  @override
  String get debtVsPaid => '負債 vs 支払い';

  @override
  String get outstanding => '未払い';

  @override
  String get noDataYet => 'データはまだありません';

  @override
  String get monthlyOverview => '月次概要';

  @override
  String get due => '期日';

  @override
  String get paymentPerformance => '支払いパフォーマンス';

  @override
  String get onTime => '期限内';

  @override
  String get late => '遅延';

  @override
  String get onTimeRate => '期限内率';

  @override
  String get rateAlerts => '金利アラート';

  @override
  String get currentMarketRates => '現在の市場金利';

  @override
  String get edit => '編集';

  @override
  String get triggeredAlerts => '発動したアラート';

  @override
  String get activeAlerts => 'アクティブなアラート';

  @override
  String get inactiveAlerts => '非アクティブなアラート';

  @override
  String get noAlertsYet => 'アラートはまだありません';

  @override
  String get addAlertsSubtitle => '金利変動を追跡するアラートを追加';

  @override
  String get addAlert => 'アラートを追加';

  @override
  String get alertNameHint => 'アラート名（例：住宅ローン金利）';

  @override
  String get loanType => 'ローンタイプ';

  @override
  String get alertWhen => 'アラート条件';

  @override
  String get rateDrops => '金利が下がったら';

  @override
  String get rateRises => '金利が上がったら';

  @override
  String get targetRate => '目標金利';

  @override
  String get when => 'いつ';

  @override
  String get current => '現在';

  @override
  String get triggered => '発動済み';

  @override
  String get editMarketRates => '市場金利を編集';

  @override
  String get personalLoan => '個人ローン';

  @override
  String get carLoan => '自動車ローン';

  @override
  String get savingsRate => '貯蓄金利';

  @override
  String get homeShort => '住宅';

  @override
  String get personalShort => '個人';

  @override
  String get carShort => '自動車';

  @override
  String get savingsShort => '貯蓄';

  @override
  String get rateDropAlert => '金利下落アラート！';

  @override
  String get rateIncreaseAlert => '金利上昇アラート！';

  @override
  String get updated => '更新済み';

  @override
  String get newUpdateAvailable => 'アップデートがあります';

  @override
  String get updateAppMessage => '新しいバージョンがあります。最新の機能と改善を入手するには更新してください。';

  @override
  String get updateNow => '今すぐ更新';

  @override
  String get later => '後で';

  @override
  String get qrTools => 'QRツール';

  @override
  String get createQRCode => 'QRコードを作成';

  @override
  String get createQRSubtitle => 'QRコードを生成';

  @override
  String get scanQRCode => 'QRコードをスキャン';

  @override
  String get scanQRSubtitle => '任意のQRコードをスキャン';

  @override
  String get selectQRType => 'QRタイプを選択';

  @override
  String get qrLink => 'リンク';

  @override
  String get qrText => 'テキスト';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => '連絡先';

  @override
  String get qrCode => 'QRコード';

  @override
  String get websiteAddress => 'ウェブサイトアドレス';

  @override
  String get textContent => 'テキスト内容';

  @override
  String get enterContent => 'ここに内容を入力';

  @override
  String get networkNameSSID => 'ネットワーク名（SSID）';

  @override
  String get wifiPasswordLabel => 'パスワード';

  @override
  String get encryptionType => '暗号化タイプ';

  @override
  String get noEncryption => '暗号化なし';

  @override
  String get contactName => '連絡先名';

  @override
  String get contactNameHint => '山田太郎';

  @override
  String get phoneNumber => '電話番号';

  @override
  String get generateQRButton => 'QRコードを生成';

  @override
  String get qrGeneratedOnDevice => 'QRコードはデバイス上で生成されます';

  @override
  String get qrLinkInfo => 'ウェブサイトURLを入力して、スキャン時にリンクを開くQRコードを作成します。';

  @override
  String get qrWifiInfo => 'WiFiネットワークに素早く接続できるQRコードを作成します。';

  @override
  String get pleaseEnterWebsite => 'ウェブサイトアドレスを入力してください';

  @override
  String get pleaseEnterTextContent => 'テキスト内容を入力してください';

  @override
  String get pleaseEnterWifiName => 'WiFiネットワーク名を入力してください';

  @override
  String get pleaseEnterContactName => '連絡先名を入力してください';

  @override
  String get copy => 'コピー';

  @override
  String get copyData => 'データをコピー';

  @override
  String get dataCopied => 'データをクリップボードにコピーしました';

  @override
  String get saveToGallery => 'ギャラリーに保存';

  @override
  String get qrPrivacyNote => 'このQRコードはデバイス上でローカルに生成され、サーバーには送信されません。';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return '連絡先: $name';
  }

  @override
  String get cannotCreateQRImage => 'QR画像を作成できません';

  @override
  String get cannotSaveQR => 'QRコードを保存できません';

  @override
  String get qrSavedToGallerySuccess => 'QRコードをギャラリーに保存しました';

  @override
  String errorWithMessage(String message) {
    return 'エラー: $message';
  }

  @override
  String get scanAgain => '再スキャン';

  @override
  String get openLink => 'リンクを開く';

  @override
  String get copyPassword => 'パスワードをコピー';

  @override
  String get passwordCopied => 'パスワードをクリップボードにコピーしました';

  @override
  String get noQRCodeFound => '画像にQRコードが見つかりません';

  @override
  String get pointCameraAtQR => 'カメラをQRコードに向けてください';

  @override
  String get scanFromGallery => 'ギャラリーからスキャン';

  @override
  String get websiteLink => 'ウェブサイトリンク';

  @override
  String get wifiNetworkLabel => 'WiFiネットワーク';

  @override
  String get openInBrowser => 'ブラウザで開く';

  @override
  String get wifiCredentials => 'WiFi認証情報';

  @override
  String get contactInformation => '連絡先情報';

  @override
  String get plainTextContent => 'プレーンテキスト';

  @override
  String get reportIssue => '問題を報告';

  @override
  String get reportIssueSubtitle => 'フィードバックを送信';
}
