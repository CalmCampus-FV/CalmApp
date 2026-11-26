import Foundation

// Generated once from CalmWeb docs/quivr/config/universities/quivr.json (verified dates are in the source).
// Text there exists in Dutch and English only; French falls back to English for these service details.
// Re-check every number and link before each release.

enum SupportData {
    static let institutions: [Institution] = [
        Institution(
            id: "kuleuven",
            name: LocalizedText(en: "KU Leuven", nl: "KU Leuven"),
            hint: LocalizedText(en: "KU Leuven Stuvo services in Leuven", nl: "Diensten van KU Leuven Stuvo in Leuven"),
            advice: nil,
            services: [
                SupportService(
                    id: "firstline",
                    name: LocalizedText(en: "First-line psychologist (KU Leuven Stuvo)", nl: "Eerstelijnspsycholoog (KU Leuven Stuvo)"),
                    purpose: LocalizedText(en: "A short track of 1 to at most 5 sessions to look at what is going on together and take steps. All sessions are free.", nl: "Een kort traject van 1 tot maximaal 5 sessies om samen te bekijken wat er speelt en stappen te zetten. Alle sessies zijn gratis."),
                    note: LocalizedText(en: "Book through the GGZ portal (link on the website).", nl: "Afspraak maken via het GGZ-portaal (link op de website)."),
                    link: LocalizedText(en: "https://www.kuleuven.be/stuvo/english/stuvo/health/mental-health/psychologists-and-psychiatrists/index.html", nl: "https://www.kuleuven.be/stuvo/gezondheid/mentaal-welzijn/psycholoog/index.html"),
                    email: nil,
                    phone: "016 32 43 43",
                    hours: LocalizedText(en: "Reception (phone): 8:00 to 17:30 in teaching weeks, 8:00 to 17:00 in weeks without classes.", nl: "Onthaal (telefoon): lesweken van 8 tot 17.30 uur, lesvrije weken van 8 tot 17 uur.")),
                SupportService(
                    id: "psychotherapy",
                    name: LocalizedText(en: "Psychologist-psychotherapist (KU Leuven Stuvo)", nl: "Psycholoog-psychotherapeut (KU Leuven Stuvo)"),
                    purpose: LocalizedText(en: "Longer support, one to one or in a group, for emotional and psychological difficulties that need more time and depth.", nl: "Langere begeleiding, individueel of in groep, bij emotionele en psychische moeilijkheden die meer tijd en verdieping vragen."),
                    note: LocalizedText(en: "Book through the GGZ portal. The price depends on your student profile.", nl: "Afspraak maken via het GGZ-portaal. De prijs hangt af van je studentenprofiel."),
                    link: LocalizedText(en: "https://www.kuleuven.be/stuvo/english/stuvo/health/mental-health/psychologists-and-psychiatrists/index.html", nl: "https://www.kuleuven.be/stuvo/gezondheid/mentaal-welzijn/psycholoog/index.html"),
                    email: nil,
                    phone: "016 32 43 43",
                    hours: LocalizedText(en: "Reception (phone): 8:00 to 17:30 in teaching weeks, 8:00 to 17:00 in weeks without classes.", nl: "Onthaal (telefoon): lesweken van 8 tot 17.30 uur, lesvrije weken van 8 tot 17 uur.")),
            ],
            serviceForLevel: ["notice": "firstline", "support": "firstline", "care": "psychotherapy"],
            campusLines: [
                EmergencyLine(id: "campus", number: "016 32 22 22", tel: "016322222", label: LocalizedText(en: "KU Leuven emergency line, 24/7", nl: "Noodlijn KU Leuven, 24/7"), detail: LocalizedText(en: "For emergencies on campus. From a KU Leuven landline: 2222.", nl: "Voor noodsituaties op de campus. Vanaf een vast toestel van KU Leuven: 2222.")),
            ]),
        Institution(
            id: "kulak",
            name: LocalizedText(en: "KU Leuven Kulak (Kortrijk)", nl: "KU Leuven Kulak (Kortrijk)"),
            hint: LocalizedText(en: "Kortrijk campus", nl: "Campus Kortrijk"),
            advice: nil,
            services: [
                SupportService(
                    id: "wellbeing",
                    name: LocalizedText(en: "Studentenwelzijn en gezondheid: student wellbeing (Stuvo Kulak)", nl: "Studentenwelzijn en gezondheid (Stuvo Kulak)"),
                    purpose: LocalizedText(en: "For personal problems, or when you worry about a fellow student: the student psychologist and the psychosocial counsellor are there for you.", nl: "Worstel je met persoonlijke problemen of maak je je zorgen om een medestudent? De studentenpsycholoog en psychosociaal begeleider staan voor jou klaar."),
                    note: LocalizedText(en: "Book through the links on the website. The number below is Stuvo Kulak's general line.", nl: "Afspraak maken via de boekingslinks op de website. Algemeen nummer van Stuvo Kulak hieronder."),
                    link: LocalizedText(en: "https://kulak.kuleuven.be/nl/studeren/studentenvoorzieningen/studentenzorgen", nl: "https://kulak.kuleuven.be/nl/studeren/studentenvoorzieningen/studentenzorgen"),
                    email: nil,
                    phone: "056 24 61 38",
                    hours: nil),
            ],
            serviceForLevel: ["notice": "wellbeing", "support": "wellbeing", "care": "wellbeing"],
            campusLines: [
                EmergencyLine(id: "campus", number: "016 32 22 22", tel: "016322222", label: LocalizedText(en: "KU Leuven emergency line, 24/7", nl: "Noodlijn KU Leuven, 24/7"), detail: LocalizedText(en: "For emergencies on campus. From a KU Leuven landline: 2222.", nl: "Voor noodsituaties op de campus. Vanaf een vast toestel van KU Leuven: 2222.")),
            ]),
        Institution(
            id: "ugent",
            name: LocalizedText(en: "Ghent University (UGent)", nl: "UGent"),
            hint: nil,
            advice: nil,
            services: [
                SupportService(
                    id: "psychologists",
                    name: LocalizedText(en: "Student psychologists (UGent)", nl: "Studentenpsychologen (UGent)"),
                    purpose: LocalizedText(en: "For study-related or personal problems: solution-focused, short-term support. Free for every UGent student, and bound by professional confidentiality.", nl: "Voor studiegerelateerde of persoonlijke problemen. Gratis voor elke UGent-student, en gebonden aan het beroepsgeheim."),
                    note: LocalizedText(en: "Book online on the website. Not sure it is for you? The Student Centre helps (email and phone below).", nl: "Afspraak maken online via de website. Twijfel je? Het Studentencentrum helpt je verder (e-mail en telefoon hieronder)."),
                    link: LocalizedText(en: "https://www.ugent.be/student/en/study-support/student-psychologists/overview.htm", nl: "https://www.ugent.be/student/nl/welzijn-gezondheid/wel-in-je-vel/studentenpsychologen"),
                    email: "studentencentrum@ugent.be",
                    phone: "09 331 00 31",
                    hours: nil),
            ],
            serviceForLevel: ["notice": "psychologists", "support": "psychologists", "care": "psychologists"],
            campusLines: [
                EmergencyLine(id: "campus", number: "09 264 88 88", tel: "092648888", label: LocalizedText(en: "UGent emergency service (Permanentie), 24/7", nl: "Permanentie UGent, 24/7"), detail: LocalizedText(en: "UGent's security service, reachable day and night.", nl: "De veiligheidsdienst van UGent, dag en nacht bereikbaar.")),
            ]),
        Institution(
            id: "uantwerpen",
            name: LocalizedText(en: "University of Antwerp (UAntwerpen)", nl: "UAntwerpen"),
            hint: nil,
            advice: nil,
            services: [
                SupportService(
                    id: "stip",
                    name: LocalizedText(en: "Student psychologists (STIP, UAntwerpen)", nl: "Studentenpsychologen (STIP, UAntwerpen)"),
                    purpose: LocalizedText(en: "At the Student Information Point (STIP), a team of student psychologists and study coaches is there for you. A free first conversation follows at short notice.", nl: "Bij het StudentenInformatiePunt (STIP) staat een team studentenpsychologen en studiecoaches klaar. Op korte termijn volgt een gratis oriënterend gesprek."),
                    note: LocalizedText(en: "Book by phone or at the STIP desk. From age 24, an individual session costs 11 euros.", nl: "Een afspraak maak je telefonisch of aan de balie van STIP. Vanaf 24 jaar betaal je 11 euro per individuele sessie."),
                    link: LocalizedText(en: "https://www.uantwerpen.be/en/study/student-support-advice/counselling/psychological-support/", nl: "https://www.uantwerpen.be/nl/studeren/hulp-bij-studentenvragen/stip/"),
                    email: "stip@uantwerpen.be",
                    phone: "03 265 48 72",
                    hours: nil),
                SupportService(
                    id: "psynet",
                    name: LocalizedText(en: "PSY-NET: psychological support at a reduced rate", nl: "PSY-NET: psychologische ondersteuning aan verlaagd tarief"),
                    purpose: LocalizedText(en: "A network of psychologists and psychotherapists in Antwerp at a reduced rate. STIP's student psychologists refer you.", nl: "Een netwerk van psychologen en psychotherapeuten in Antwerpen, aan een verlaagd tarief. De studentenpsychologen van STIP verwijzen je door."),
                    note: nil,
                    link: LocalizedText(en: "https://www.uantwerpen.be/en/study/student-support-advice/counselling/psychological-support/psy-net/", nl: "https://www.uantwerpen.be/nl/studeren/studiebegeleiding-ondersteuning/psychologische-ondersteuning/psy-net/"),
                    email: nil,
                    phone: nil,
                    hours: nil),
            ],
            serviceForLevel: ["notice": "stip", "support": "stip", "care": "stip"],
            campusLines: [
            ]),
        Institution(
            id: "vub",
            name: LocalizedText(en: "Vrije Universiteit Brussel (VUB)", nl: "VUB"),
            hint: nil,
            advice: nil,
            services: [
                SupportService(
                    id: "psychologists",
                    name: LocalizedText(en: "Student psychologists (VUB Study Guidance)", nl: "Studentenpsychologen (VUB Studiebegeleiding)"),
                    purpose: LocalizedText(en: "Talk for free and in confidence about what is difficult during your studies, such as study stress, fear of failure or procrastination.", nl: "Praat gratis en in vertrouwen over wat moeilijk loopt tijdens je studie, zoals studiestress, faalangst of uitstelgedrag."),
                    note: LocalizedText(en: "Any working day you can drop by the Study Guidance Meeting Point without an appointment (VUB Main Campus Etterbeek, building F).", nl: "Elke werkdag kun je zonder afspraak langs bij het Meeting Point van Studiebegeleiding (VUB Main Campus Etterbeek, gebouw F)."),
                    link: LocalizedText(en: "https://www.vub.be/en/studying-vub/praktisch/welzijn-aan-de-vub/contact-student-psychologists", nl: "https://www.vub.be/nl/contact/organisatie/studentenpsychologen"),
                    email: "begeleiding@vub.be",
                    phone: "02 629 23 06",
                    hours: nil),
                SupportService(
                    id: "brucc",
                    name: LocalizedText(en: "BRUCC (Brussels University Consultation Centre)", nl: "BRUCC (Brussels University Consultation Centre)"),
                    purpose: LocalizedText(en: "VUB's psychological consultation centre, also open to students. For study-related questions it works with the student psychologists.", nl: "Het psychologisch consultatiecentrum van de VUB, ook voor studenten. Voor studievragen werkt het samen met de studentenpsychologen."),
                    note: nil,
                    link: LocalizedText(en: "https://www.vub.be/en/news/brucc-vub-offers-psychological-support", nl: "https://www.vub.be/nl/nieuws/brucc-vub-voor-psychologische-hulp"),
                    email: nil,
                    phone: nil,
                    hours: nil),
            ],
            serviceForLevel: ["notice": "psychologists", "support": "psychologists", "care": "psychologists"],
            campusLines: [
                EmergencyLine(id: "campus", number: "02 629 11 11", tel: "026291111", label: LocalizedText(en: "VUB security, Etterbeek campus, 24/7", nl: "Bewaking VUB Campus Etterbeek, 24/7"), detail: LocalizedText(en: "The campus security service's emergency number.", nl: "Noodnummer van de bewakingsdienst op de campus.")),
            ]),
        Institution(
            id: "uhasselt",
            name: LocalizedText(en: "UHasselt", nl: "UHasselt"),
            hint: nil,
            advice: nil,
            services: [
                SupportService(
                    id: "psychologist",
                    name: LocalizedText(en: "Student psychologist (UHasselt)", nl: "Studentenpsycholoog (UHasselt)"),
                    purpose: LocalizedText(en: "The student psychologist helps you with personal or interpersonal problems. One-to-one and group sessions are free, with no waiting list.", nl: "De studentenpsycholoog ondersteunt je bij persoonlijke of relationele problemen. Individuele en groepssessies zijn gratis, zonder wachtlijst."),
                    note: LocalizedText(en: "Book through the psychologists' online calendars on the website: on the Hasselt or Diepenbeek campus, or online.", nl: "Afspraak maken via de online agenda's van de psychologen op de website, op campus Hasselt, Diepenbeek of online."),
                    link: LocalizedText(en: "https://uhasselt.be/en/info-for/current-students/guidance-and-support/student-psychologist", nl: "https://uhasselt.be/nl/info-voor/studenten/begeleiding-en-ondersteuning-tijdens-je-studie/studentenpsycholoog"),
                    email: "studentenpsycholoog@uhasselt.be",
                    phone: nil,
                    hours: nil),
                SupportService(
                    id: "studentpoint",
                    name: LocalizedText(en: "Student Point (UHasselt)", nl: "Student Point (UHasselt)"),
                    purpose: LocalizedText(en: "Have a question and don't know who to contact? Student Point helps you or directs you to the right person.", nl: "Heb je een vraag en weet je niet bij wie je terechtkunt? Student Point helpt je of brengt je bij de juiste persoon."),
                    note: nil,
                    link: LocalizedText(en: "https://uhasselt.be/en/info-for/current-students/guidance-and-support/student-point", nl: "https://uhasselt.be/en/info-for/current-students/guidance-and-support/student-point"),
                    email: "studentpoint@uhasselt.be",
                    phone: "011 26 81 19",
                    hours: LocalizedText(en: "No appointment needed. Diepenbeek, building D (Agora): 10:00 to 14:00. Hasselt, Old Prison: Monday and Thursday, 10:00 to 14:00.", nl: "Zonder afspraak. Diepenbeek, gebouw D (Agora): van 10 tot 14 uur. Hasselt, Oude Gevangenis: maandag en donderdag van 10 tot 14 uur.")),
            ],
            serviceForLevel: ["notice": "psychologist", "support": "psychologist", "care": "psychologist"],
            campusLines: [
                EmergencyLine(id: "campus", number: "011 26 88 88", tel: "011268888", label: LocalizedText(en: "Fire or accident on a UHasselt campus", nl: "Brand of ongeval op de campus van UHasselt"), detail: LocalizedText(en: "From a mobile phone. From a campus landline: 8888.", nl: "Vanaf een gsm. Vanaf een vast toestel op de campus: 8888.")),
            ]),
        Institution(
            id: "other",
            name: LocalizedText(en: "Other institution", nl: "Andere instelling"),
            hint: LocalizedText(en: "Only the national numbers and general advice", nl: "Alleen de nationale nummers en algemeen advies"),
            advice: LocalizedText(en: "Your institution's student services can tell you who to talk to. The numbers below are open to everyone in Belgium.", nl: "De studentendienst van je eigen instelling (vaak studentenvoorzieningen of Stuvo genoemd) kan je zeggen bij wie je terechtkunt. De nummers hieronder zijn er voor iedereen in België."),
            services: [
            ],
            serviceForLevel: [:],
            campusLines: [
            ]),
    ]

    static let nationalLines: [EmergencyLine] = [
        EmergencyLine(id: "general", number: "112", tel: "112", label: LocalizedText(en: "Emergency: ambulance and fire brigade", nl: "Noodnummer: ziekenwagen en brandweer", fr: "Urgences : ambulance et pompiers"), detail: LocalizedText(en: "Free, anywhere in Europe.", nl: "Gratis, in heel Europa.", fr: "Gratuit, partout en Europe.")),
        EmergencyLine(id: "zelfmoordlijn", number: "1813", tel: "1813", label: LocalizedText(en: "Zelfmoordlijn 1813 (suicide line), 24/7", nl: "Zelfmoordlijn 1813, 24/7", fr: "Zelfmoordlijn 1813, 24h/24 (en néerlandais)"), detail: LocalizedText(en: "Anonymous and free, in Dutch. Chat every day from 17:00 to midnight, Wednesdays from 12:00.", nl: "Anoniem en gratis. Chat elke dag van 17 tot 24 uur, op woensdag vanaf 12 uur.", fr: "Anonyme et gratuit, en néerlandais.")),
        EmergencyLine(id: "tele-onthaal", number: "106", tel: "106", label: LocalizedText(en: "Tele-Onthaal 106 (listening line), 24/7", nl: "Tele-Onthaal 106, 24/7", fr: "Tele-Onthaal 106, 24h/24 (en néerlandais)"), detail: LocalizedText(en: "Someone to talk to about anything. Free and anonymous, in Dutch.", nl: "Praten helpt. Gratis en anoniem.", fr: "Quelqu'un à qui parler de tout. Gratuit et anonyme, en néerlandais.")),
        EmergencyLine(id: "tele-accueil", number: "107", tel: "107", label: LocalizedText(en: "Télé-Accueil 107 (listening line), 24/7", nl: "Télé-Accueil 107, 24/7 (Frans)", fr: "Télé-Accueil 107, 24h/24"), detail: LocalizedText(en: "A listening line in French. Free.", nl: "Een luisterlijn in het Frans. Gratis.", fr: "Une ligne d'écoute en français. Gratuite.")),
        EmergencyLine(id: "prevention-suicide", number: "0800 32 123", tel: "080032123", label: LocalizedText(en: "Centre de Prévention du Suicide (suicide line), 24/7", nl: "Centre de Prévention du Suicide, 24/7 (Frans)", fr: "Centre de Prévention du Suicide, 24h/24"), detail: LocalizedText(en: "A specialised listening line in French. Anonymous and free.", nl: "Een gespecialiseerde luisterlijn in het Frans. Anoniem en gratis.", fr: "Une ligne d'écoute spécialisée en français. Anonyme et gratuite.")),
    ]
}
