import Foundation

/// Every user-facing string in the three app languages. Kept in code (not .strings files) so
/// the language can be switched at runtime and so unit tests can check all of it.
/// Wording rules live in CLAUDE.md: no em dashes, wellness wording, no detection claims.
enum S: String, CaseIterable {
    case disclaimer, staysOnPhone
    case welcomeTitle, welcomeLead, welcomePoint1, welcomePoint2, welcomePoint3, welcomeStart
    case tabCheckin, tabWeeks, tabSupport, tabAbout
    case homeTitle, homeLead, homeStart, homeDoneTitle, homeDoneBody, homeRedo, homeViewResult
    case progress, yes, no, back, skip, checkinHeading
    case qSleep, qPlanning, qEnergy, qConnection
    case noticedSleep, noticedPlanning, noticedEnergy, noticedConnection
    case resultKicker, resultNoticedHeading, resultNoneNoticed, resultAllSkipped, resultNextHeading
    case steadyNext, seeSupport, saved, backHome
    case steadyPill, steadyTitle, steadyBody
    case noticePill, noticeTitle, noticeBody
    case supportPill, supportTitle, supportBody
    case carePill, careTitle, careBody
    case historyTitle, historyEmpty, historyWeekOf, historyOpen, historySkipped
    case supportScreenTitle, supportLead, institutionHeading, institutionHelp, institutionNone
    case institutionOther, institutionOtherAdvice, institutionServices, nationalHeading, emergencyIntro
    case call, website, email, emailNote
    case aboutTitle, aboutIntro, aboutCredit, languageHeading, languageDevice
    case reminderHeading, reminderBody, reminderToggle, reminderDenied, notificationTitle, notificationBody
    case feedbackHeading, feedbackBody, feedbackButton, feedbackSubject, feedbackTemplate
    case privacyHeading, privacyBody
    case deleteHeading, deleteBody, deleteButton, deleteConfirm, deleteYes, deleteCancel, deleteDone
    case version

    func text(_ language: AppLanguage) -> String { Self.table[self]!.resolve(language) }

    private static func t(_ en: String, _ nl: String, _ fr: String) -> LocalizedText {
        LocalizedText(en: en, nl: nl, fr: fr)
    }

    static let disclaimerText = t(
        "We are students, not medical professionals. CalmCampus does not diagnose or treat. We strongly suggest talking to a doctor or your student support.",
        "Wij zijn studenten, geen medische professionals. CalmCampus stelt geen diagnoses en behandelt niet. We raden sterk aan om met een huisarts of je studentenondersteuning te praten.",
        "Nous sommes des étudiant·es, pas des professionnel·les de santé. CalmCampus ne pose pas de diagnostic et ne soigne pas. Nous te conseillons vivement d'en parler à un médecin ou au service d'aide aux étudiant·es.")

    /// The one key that may use the word "diagnose": the required disclaimer.
    static let table: [S: LocalizedText] = [
        .disclaimer: disclaimerText,
        .staysOnPhone: t("Your answers stay on this phone.", "Je antwoorden blijven op deze telefoon.",
                         "Tes réponses restent sur ce téléphone."),

        .welcomeTitle: t("Welcome", "Welkom", "Bienvenue"),
        .welcomeLead: t("CalmCampus is a short weekly check-in for students. You answer four yes or no questions about your week, and get a pointer to where you can find support.",
                        "CalmCampus is een korte wekelijkse check-in voor studenten. Je beantwoordt vier ja-of-neevragen over je week en krijgt een wegwijzer naar ondersteuning.",
                        "CalmCampus est un court bilan hebdomadaire pour les étudiant·es. Tu réponds à quatre questions par oui ou non sur ta semaine, et tu reçois une piste pour trouver du soutien."),
        .welcomePoint1: t("It takes less than a minute. Every question can be skipped.",
                          "Het duurt minder dan een minuut. Elke vraag mag je overslaan.",
                          "Cela prend moins d'une minute. Tu peux passer chaque question."),
        .welcomePoint2: t("No account, no tracking. Nothing leaves this phone.",
                          "Geen account, geen tracking. Niets verlaat deze telefoon.",
                          "Pas de compte, pas de suivi. Rien ne quitte ce téléphone."),
        .welcomePoint3: t("You can delete everything at any time in About.",
                          "Je kunt alles op elk moment wissen onder Over.",
                          "Tu peux tout supprimer à tout moment dans À propos."),
        .welcomeStart: t("Get started", "Aan de slag", "Commencer"),

        .tabCheckin: t("Check-in", "Check-in", "Bilan"),
        .tabWeeks: t("My weeks", "Mijn weken", "Mes semaines"),
        .tabSupport: t("Support", "Ondersteuning", "Soutien"),
        .tabAbout: t("About", "Over", "À propos"),

        .homeTitle: t("A quiet minute for you", "Een rustige minuut voor jou", "Une minute au calme pour toi"),
        .homeLead: t("Four yes or no questions about this past week. It takes less than a minute.",
                     "Vier ja-of-neevragen over de voorbije week. Het duurt minder dan een minuut.",
                     "Quatre questions par oui ou non sur la semaine écoulée. Cela prend moins d'une minute."),
        .homeStart: t("Start this week's check-in", "Start de check-in van deze week", "Commencer le bilan de la semaine"),
        .homeDoneTitle: t("You checked in this week", "Je hebt deze week ingecheckt", "Tu as fait ton bilan cette semaine"),
        .homeDoneBody: t("Thanks for taking a minute. You can redo it if something has changed.",
                         "Bedankt dat je even de tijd nam. Je kunt het opnieuw doen als er iets veranderd is.",
                         "Merci d'avoir pris une minute. Tu peux le refaire si quelque chose a changé."),
        .homeRedo: t("Redo the check-in", "Doe de check-in opnieuw", "Refaire le bilan"),
        .homeViewResult: t("See my result", "Bekijk mijn resultaat", "Voir mon résultat"),

        .progress: t("Question %d of %d", "Vraag %d van %d", "Question %d sur %d"),
        .yes: t("Yes", "Ja", "Oui"),
        .no: t("No", "Nee", "Non"),
        .back: t("Back", "Terug", "Retour"),
        .skip: t("Skip this question", "Sla deze vraag over", "Passer cette question"),
        .checkinHeading: t("This past week", "De voorbije week", "La semaine écoulée"),

        // Wording matches the web preview (CalmWeb quivr.json for en/nl, epfl.json for fr).
        .qSleep: t("This week, has your sleep been worse than usual?",
                   "Was je slaap deze week slechter dan gewoonlijk?",
                   "Cette semaine, ton sommeil a-t-il été moins bon que d'habitude ?"),
        .qPlanning: t("Have you struggled to plan or organise your studies?",
                      "Had je moeite om je studie te plannen of te organiseren?",
                      "As-tu eu du mal à organiser ou à planifier tes études ?"),
        .qEnergy: t("Have you found it hard to get started on things you usually manage?",
                    "Vond je het moeilijk om te beginnen aan dingen die je gewoonlijk wel lukken?",
                    "As-tu eu du mal à te mettre au travail sur ce que tu gères d'habitude ?"),
        .qConnection: t("Have you been avoiding friends, classes or plans more than usual?",
                        "Ging je vrienden, lessen of plannen meer uit de weg dan gewoonlijk?",
                        "As-tu évité tes amis, tes cours ou tes projets plus que d'habitude ?"),

        .noticedSleep: t("Sleep was worse than usual", "Slaap was slechter dan gewoonlijk", "Sommeil moins bon que d'habitude"),
        .noticedPlanning: t("Planning your studies was hard", "Je studie plannen was moeilijk", "Organiser tes études était difficile"),
        .noticedEnergy: t("Getting started was hard", "Beginnen was moeilijk", "Se mettre au travail était difficile"),
        .noticedConnection: t("Avoiding friends, classes or plans", "Vrienden, lessen of plannen uit de weg gaan", "Éviter amis, cours ou projets"),

        .resultKicker: t("Your result", "Je resultaat", "Ton résultat"),
        .resultNoticedHeading: t("What you answered yes to", "Waar je ja op antwoordde", "Ce à quoi tu as répondu oui"),
        .resultNoneNoticed: t("No yes answers this week.", "Geen ja-antwoorden deze week.", "Aucune réponse oui cette semaine."),
        .resultAllSkipped: t("You skipped every question this week. That is fine. You can still look at the support options whenever you like.",
                             "Je sloeg deze week alle vragen over. Dat is prima. Je kunt de ondersteuning altijd bekijken wanneer je wilt.",
                             "Tu as passé toutes les questions cette semaine. Ce n'est pas un problème. Tu peux consulter les soutiens quand tu veux."),
        .resultNextHeading: t("One next step", "Eén volgende stap", "Une prochaine étape"),
        .steadyNext: t("If something changes, support is there whenever you want it.",
                       "Als er iets verandert, is er ondersteuning wanneer je die wilt.",
                       "Si quelque chose change, du soutien est là, quand tu en as besoin."),
        .seeSupport: t("See support options", "Bekijk waar je terechtkunt", "Voir les soutiens possibles"),
        .saved: t("Saved on this phone only.", "Alleen op deze telefoon bewaard.", "Enregistré uniquement sur ce téléphone."),
        .backHome: t("Back to check-in", "Terug naar de check-in", "Retour au bilan"),

        .steadyPill: t("Steady", "Stabiel", "Stable"),
        .steadyTitle: t("Things look steady this week", "Het ziet er deze week stabiel uit", "Tout semble stable cette semaine"),
        .steadyBody: t("You did not answer yes to any question. A quick check-in each week gives you a moment to pause.",
                       "Je antwoordde op geen enkele vraag ja. Een korte check-in per week geeft je even een moment om stil te staan.",
                       "Tu n'as répondu oui à aucune question. Un bilan rapide chaque semaine te donne un moment pour faire une pause."),
        .noticePill: t("Worth a pause", "Even stilstaan", "Une pause utile"),
        .noticeTitle: t("One thing stood out", "Eén ding viel op", "Une chose ressort"),
        .noticeBody: t("You answered yes to one question. That is common, and worth a small pause. Talking it through often makes it lighter.",
                       "Je antwoordde op één vraag ja. Dat komt vaak voor en is een korte pauze waard. Erover praten maakt het vaak lichter.",
                       "Tu as répondu oui à une question. C'est courant, et cela mérite une petite pause. En parler allège souvent les choses."),
        .supportPill: t("Worth a conversation", "Een gesprek waard", "Une conversation utile"),
        .supportTitle: t("A few things stood out", "Een paar dingen vielen op", "Quelques choses ressortent"),
        .supportBody: t("You answered yes to more than one question. This could be a good moment to talk to someone before things build up. One conversation can help you sort out what to do first.",
                        "Je antwoordde op meer dan één vraag ja. Dit kan een goed moment zijn om met iemand te praten voor het zich opstapelt. Eén gesprek kan je helpen om te bepalen wat je eerst doet.",
                        "Tu as répondu oui à plus d'une question. Ce pourrait être un bon moment pour parler à quelqu'un avant que les choses ne s'accumulent. Une conversation peut aider à voir par quoi commencer."),
        .carePill: t("Take care", "Zorg goed voor jezelf", "Prends soin de toi"),
        .careTitle: t("This week sounds heavy", "Deze week klinkt zwaar", "Cette semaine semble lourde"),
        .careBody: t("Several of your answers were yes. You do not have to carry that alone. A doctor or your student support can look at the whole picture with you, and asking for help is a normal thing to do.",
                     "Meerdere van je antwoorden waren ja. Je hoeft dat niet alleen te dragen. Een huisarts of je studentenondersteuning kan samen met jou naar het geheel kijken, en hulp vragen is heel normaal.",
                     "Plusieurs de tes réponses étaient oui. Tu n'as pas à porter cela seul·e. Un médecin ou le service d'aide aux étudiant·es peut regarder l'ensemble avec toi, et demander de l'aide est tout à fait normal."),

        .historyTitle: t("My weeks", "Mijn weken", "Mes semaines"),
        .historyEmpty: t("No check-ins yet. Your weeks will show up here after the first one.",
                         "Nog geen check-ins. Je weken verschijnen hier na de eerste.",
                         "Pas encore de bilan. Tes semaines apparaîtront ici après le premier."),
        .historyWeekOf: t("Week of %@", "Week van %@", "Semaine du %@"),
        .historyOpen: t("Open result", "Open resultaat", "Ouvrir le résultat"),
        .historySkipped: t("All questions skipped", "Alle vragen overgeslagen", "Toutes les questions passées"),

        .supportScreenTitle: t("Support", "Ondersteuning", "Soutien"),
        .supportLead: t("You can contact any of these at any time. You do not need a result first.",
                        "Je kunt hen op elk moment contacteren. Je hebt daarvoor geen resultaat nodig.",
                        "Tu peux les contacter à tout moment. Tu n'as pas besoin d'un résultat."),
        .institutionHeading: t("Your institution (optional)", "Je instelling (optioneel)", "Ton établissement (facultatif)"),
        .institutionHelp: t("Pick one to see its student services. The check-in works without this.",
                            "Kies er een om de studentendiensten te zien. De check-in werkt ook zonder.",
                            "Choisis-en un pour voir ses services aux étudiant·es. Le bilan fonctionne aussi sans cela."),
        .institutionNone: t("Not chosen", "Niet gekozen", "Non choisi"),
        .institutionOther: t("Other", "Andere", "Autre"),
        .institutionOtherAdvice: t("Your institution's student services can tell you who to talk to. The numbers below are open to everyone in Belgium.",
                                   "De studentendienst van je eigen instelling kan je zeggen bij wie je terechtkunt. De nummers hieronder zijn er voor iedereen in België.",
                                   "Le service aux étudiant·es de ton établissement peut te dire à qui t'adresser. Les numéros ci-dessous sont ouverts à tous en Belgique."),
        .institutionServices: t("Student services", "Studentendiensten", "Services aux étudiant·es"),
        .nationalHeading: t("Anyone in Belgium", "Voor iedereen in België", "Pour tous en Belgique"),
        .emergencyIntro: t("If you or someone else is in danger or needs help right now, call 112.",
                           "Ben jij of iemand anders in gevaar, of is er nu meteen hulp nodig? Bel 112.",
                           "Si toi ou quelqu'un d'autre est en danger ou a besoin d'aide tout de suite, appelle le 112."),
        .call: t("Call", "Bel", "Appeler"),
        .website: t("Open website", "Open website", "Ouvrir le site web"),
        .email: t("Send an email", "Stuur een e-mail", "Envoyer un e-mail"),
        .emailNote: t("This opens your mail app. Nothing from CalmCampus is attached.",
                      "Dit opent je mailapp. Er wordt niets van CalmCampus bijgevoegd.",
                      "Cela ouvre ton application de messagerie. Rien de CalmCampus n'y est joint."),

        .aboutTitle: t("About", "Over", "À propos"),
        .aboutIntro: t("CalmCampus is a weekly check-in made by students, for students. It is a moment to pause and a pointer to support. It does not give advice, a grade or a verdict on you.",
                       "CalmCampus is een wekelijkse check-in, gemaakt door studenten, voor studenten. Het is een moment om stil te staan en een wegwijzer naar ondersteuning. Het geeft geen advies, geen punt en geen oordeel over jou.",
                       "CalmCampus est un bilan hebdomadaire fait par des étudiant·es, pour des étudiant·es. C'est un moment de pause et une piste vers du soutien. Il ne donne ni conseil, ni note, ni verdict sur toi."),
        .aboutCredit: t("Made by Florian Braùn and Hélène David.", "Gemaakt door Florian Braùn en Hélène David.",
                        "Réalisé par Florian Braùn et Hélène David."),
        .languageHeading: t("Language", "Taal", "Langue"),
        .languageDevice: t("Device language", "Taal van het toestel", "Langue de l'appareil"),
        .reminderHeading: t("Weekly reminder", "Wekelijkse herinnering", "Rappel hebdomadaire"),
        .reminderBody: t("A notification once a week, on Sunday evening. It is scheduled on this phone only. Off by default.",
                         "Eén melding per week, op zondagavond. Ze wordt alleen op deze telefoon ingepland. Standaard uit.",
                         "Une notification par semaine, le dimanche soir. Elle est programmée uniquement sur ce téléphone. Désactivée par défaut."),
        .reminderToggle: t("Remind me weekly", "Herinner me wekelijks", "Me rappeler chaque semaine"),
        .reminderDenied: t("Notifications are turned off for CalmCampus. You can allow them in the iPhone Settings app.",
                           "Meldingen staan uit voor CalmCampus. Je kunt ze toestaan in de app Instellingen van je iPhone.",
                           "Les notifications sont désactivées pour CalmCampus. Tu peux les autoriser dans l'app Réglages de ton iPhone."),
        .notificationTitle: t("Your weekly check-in", "Je wekelijkse check-in", "Ton bilan de la semaine"),
        .notificationBody: t("Take a quiet minute for yourself.", "Neem even een rustige minuut voor jezelf.",
                             "Prends une minute au calme pour toi."),
        .feedbackHeading: t("Send feedback", "Stuur feedback", "Envoyer un retour"),
        .feedbackBody: t("Opens an email draft to the CalmCampus team. Nothing from the app is attached and nothing is sent until you press send.",
                         "Opent een e-mailconcept naar het CalmCampus-team. Er wordt niets uit de app bijgevoegd en er wordt niets verstuurd tot jij op verzenden drukt.",
                         "Ouvre un brouillon d'e-mail à l'équipe CalmCampus. Rien de l'application n'y est joint et rien n'est envoyé tant que tu n'appuies pas sur envoyer."),
        .feedbackButton: t("Send feedback", "Stuur feedback", "Envoyer un retour"),
        .feedbackSubject: t("Feedback on the CalmCampus app", "Feedback op de CalmCampus-app", "Retour sur l'application CalmCampus"),
        .feedbackTemplate: t("What worked well:\n\n\nWhat was unclear:\n\n\nAnything else:\n",
                             "Wat goed werkte:\n\n\nWat onduidelijk was:\n\n\nIets anders:\n",
                             "Ce qui a bien fonctionné :\n\n\nCe qui n'était pas clair :\n\n\nAutre chose :\n"),
        .privacyHeading: t("Your data", "Je gegevens", "Tes données"),
        .privacyBody: t("Your answers are saved on this phone only. There are no accounts, no analytics and no tracking, and the app makes no network calls. It only opens a support link or an email draft when you tap one.",
                        "Je antwoorden worden alleen op deze telefoon bewaard. Er zijn geen accounts, geen analyses en geen tracking, en de app maakt geen netwerkverbindingen. Ze opent alleen een ondersteuningslink of een e-mailconcept als jij daarop tikt.",
                        "Tes réponses sont enregistrées uniquement sur ce téléphone. Il n'y a ni compte, ni statistiques, ni suivi, et l'application n'établit aucune connexion réseau. Elle n'ouvre un lien de soutien ou un brouillon d'e-mail que si tu touches l'un d'eux."),
        .deleteHeading: t("Delete my data", "Wis mijn gegevens", "Supprimer mes données"),
        .deleteBody: t("Removes every answer and setting stored on this phone. It cannot be undone.",
                       "Verwijdert elk antwoord en elke instelling die op deze telefoon staat. Dit kan niet ongedaan gemaakt worden.",
                       "Efface toutes les réponses et tous les réglages stockés sur ce téléphone. Cette action est définitive."),
        .deleteButton: t("Delete my data", "Wis mijn gegevens", "Supprimer mes données"),
        .deleteConfirm: t("Delete everything on this phone?", "Alles op deze telefoon wissen?", "Tout supprimer sur ce téléphone ?"),
        .deleteYes: t("Yes, delete", "Ja, wissen", "Oui, supprimer"),
        .deleteCancel: t("Keep my data", "Bewaar mijn gegevens", "Garder mes données"),
        .deleteDone: t("Done. Everything stored on this phone has been deleted.",
                       "Klaar. Alles wat op deze telefoon stond, is gewist.",
                       "C'est fait. Tout ce qui était stocké sur ce téléphone a été supprimé."),
        .version: t("Version %@", "Versie %@", "Version %@"),
    ]
}

extension ResultLevel {
    var pill: S { switch self { case .steady: .steadyPill; case .notice: .noticePill; case .support: .supportPill; case .care: .carePill } }
    var title: S { switch self { case .steady: .steadyTitle; case .notice: .noticeTitle; case .support: .supportTitle; case .care: .careTitle } }
    var body: S { switch self { case .steady: .steadyBody; case .notice: .noticeBody; case .support: .supportBody; case .care: .careBody } }
}

extension WeeklyQuestions {
    static func prompt(_ id: String) -> S {
        switch id {
        case "sleep": .qSleep
        case "planning": .qPlanning
        case "energy": .qEnergy
        default: .qConnection
        }
    }

    static func noticed(_ id: String) -> S {
        switch id {
        case "sleep": .noticedSleep
        case "planning": .noticedPlanning
        case "energy": .noticedEnergy
        default: .noticedConnection
        }
    }
}
