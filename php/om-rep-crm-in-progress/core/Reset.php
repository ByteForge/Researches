<?php
require_once 'Core.php';

/*
const FIRST_NAME = "firstName";
const LAST_NAME = "lastName";

const ROLE = "role";
    const ADMINISTRATOR = "Administrator";
const ADDRESS = "address";
const CONTACT = "contact";
const LANGUAGE = "language";
*/

class Reset {
    use singletonTrait;

    //private static $__development = Configuration::DEVELOPMENT;

    /*
    public static function initialize(array $options = null) {
        if( !is_null($options) ) {
            if( isset($options[PRODUCTION]) ) {
                self::$__development = false;
            }
            if( isset($options[DEVELOPMENT]) ) {
                self::$__development = true;
            }
        }
    }
    */

    public static $connection = null;

    public static function resetAll() {
        // Reset core
        $pdo = self::$connection->getPDO();
        $path = Configuration::getRootPath();
        $coreSQL = file_get_contents($path . "/core/Core.sql");
        //$pdo->exec($coreSQL);

        // Add users

        /*
        $core = Database::getCoreLink();
        $query = 'INSERT INTO `user` (`active`, `uid`, `hash`, `salt`, `type`, `firstName`, `lastName`, `signedUp`) VALUES (:active, :uid, :hash, :salt, :type, :firstName, :lastName, :signedUp);';
        $bindings = [
            ':active' => 1,
            ':uid' => 'dfsdf',
            ':hash' => 'ggergrg',
            ':salt' => '8dgdf',
            ':type' => 2,
            ':firstName' => 'dcvdfgdsf',
            ':lastName' => 'sdfsdsd',
            ':signedUp' => 0
        ];
        $core->query($query, $bindings);
        */
        //return;

        $emailSuffix = 'fmhifi.com';
        /*
        // Add organisations
        Organisation::addOrganisation([
            // Own company
            [   NAME => 'Felix Martin Hi-Fi & Movie Studio',
                DESCRIPTION => 'Specialist retailer for high-quality entertainment equipment with a distribution area in and around Vienna.',
                ADDRESS => [ [1170, 'Wien', 'Neubaugasse', '55', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "{$emailSuffix}", PRIMARY],
                    [Contact::EMAIL_WORK, "contact@{$emailSuffix}", PRIMARY],
                    [Contact::PHONE_WORK, '+43 660 120 2040'],
                    [Contact::SOCIAL_GOOGLE, 'plus.google.com/+felixhifi'],
                    [Contact::SOCIAL_FACEBOOK, 'facebook.com/felixhifi']
                ]
            ],
            // Additional organisations
            [   NAME => 'Audio Exclusive',
                DESCRIPTION => 'Distributes Clearaudio, Audioplan, Dragster, Dynaudio, Kicker, Lovan, Morel Acoustics, Soundstream Technologies, Supra Cables and WBT.',
                ADDRESS => [ [4070, 'Eferding', 'Oberrudling', '2', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "audio-exclusive.at ", PRIMARY],
                    [Contact::EMAIL_WORK, "office@audio-exclusive.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 676 707 2202']
                ]
            ],
            [   NAME => 'Audiophil Handelsvertretungen',
                DESCRIPTION => 'Distributes Adam Audio, Cayin, Electrocompaniet, HMS Elektronik, Music Hall Audio, Phonar and all the Precide brands including Ergo, Oskar, Heil and Jenklin Float.',
                ADDRESS => [ [1050, 'Wien', 'Audiophil', 'Handelsvertretungen', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "audiophil.at", PRIMARY],
                    [Contact::EMAIL_WORK, "info@audiophil.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 699 1 335 73 63'],
                    [Contact::FAX_WORK, '+43 1 929 1256']
                ]
            ],
            [   NAME => 'Audio Tuning',
                DESCRIPTION => 'Distributes EuroAudioTeam (EAT), Imerge, Musical Fidelity, Ortofon (hi-fi products only), Pro-Ject, Russound, Snell Acoustics and Solid Steel amongst other brands.',
                ADDRESS => [ [1050, 'Wien', 'Margaretenstrasse', '98', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "audiotuning.com", PRIMARY],
                    [Contact::EMAIL_WORK, "at.info@audiotuning.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 1 544 8580'],
                    [Contact::FAX_WORK, '+43 1 5448580-33']
                ]
            ],
            [   NAME => 'Digital Professional Audio Vertriebsgesellschaft',
                DESCRIPTION => 'Distributes Denon.',
                ADDRESS => [ [1160, 'Wien', 'Seeborkgasse', '59', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::PHONE_WORK, '+43 1 480 1006', PRIMARY],
                    [Contact::FAX_WORK, '+43 1 485 7679']
                ]
            ],
            [   NAME => 'Disco Store',
                DESCRIPTION => 'Handles Glorius DJ, JB Systems, Numark, Ortofon professional audio products, Synq.',
                ADDRESS => [ [1150, 'Wien', 'Weiglgasse', '16', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "disco-store.at", PRIMARY],
                    [Contact::EMAIL_WORK, "disco-store@disco-store.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 1 895 63 55'],
                    [Contact::FAX_WORK, '+43 1 895 635 520']
                ]
            ],
            [   NAME => 'Fricco Referenz Audio',
                DESCRIPTION => 'Austrian company that is primarily a high end audio dealer with emphasis on analogue and valve based products. Also handles the Austrian distribution of Almarro, Manley Labs, Nordic Concept, Orpheus, Red Wine Audio and Wiener Lautsprecher Manufaktur.',
                ADDRESS => [ [6832, 'Sulz', 'Treietstraße', '56', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "fricco.com", PRIMARY],
                    [Contact::EMAIL_WORK, "info@fricco.com", PRIMARY],
                    [Contact::PHONE_WORK, '+43 5522 44 641'],
                    [Contact::FAX_WORK, '+43 5522 44 641-74']
                ]
            ],
            [   NAME => 'Hans Lurf GmbH',
                DESCRIPTION => 'Distributes Aurum Phonologue, Pioneer and Quadral.',
                ADDRESS => [ [1230, 'Wien', 'Gorskistrasse', '3', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "pioneer.at", PRIMARY],
                    [Contact::EMAIL_WORK, "info@pioneer.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 1616 4580'],
                    [Contact::FAX_WORK, '+43 1616 4580-59']
                ]
            ],
            [   NAME => 'Helmut Eichlinger GmbH',
                DESCRIPTION => 'Austrian company that is primarily a high end retailer that operates under the Akustische Systeme name but does also distribute or act as a sole Austrian dealership for a few brands including Abacus Electronics, Acoustic Plan, AHP, Audionet, Consensus Audio Engineering, Fadel Art, Fast Audio, LUA, Music Tools, New Audio Frontiers, Padis and TMR Elektronik.',
                ADDRESS => [ [1160, 'Wien', 'Stöberplatz', '5', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "akustischesysteme.at", PRIMARY],
                    [Contact::EMAIL_WORK, "eichlinger@akustischesysteme.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 1 485 4008']
                ]
            ],
            [   NAME => 'HK-Electronics',
                DESCRIPTION => 'Distributes ASW.',
                ADDRESS => [ [5081, 'Anif', 'Schulweg', '4', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::PHONE_WORK, '+43 6246 76874', PRIMARY],
                    [Contact::FAX_WORK, '+43 6246 76874']
                ]
            ],
            [   NAME => 'Ing. Gert Weber Handelsvertretung',
                DESCRIPTION => 'Austrian company that handles the local distribution of Eagle Cable, ELAC, In-Akustik and Onkyo.',
                ADDRESS => [ [2524, 'Teesdorf', 'Triesting Wohnpark', '33', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::EMAIL_WORK, "gert.weber@aon.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 2253 80320', PRIMARY],
                    [Contact::FAX_WORK, '+43 6991 0168 919']
                ]
            ],
            [   NAME => 'Inntal Audio',
                DESCRIPTION => 'Distributes Rega.',
                ADDRESS => [ [6170, 'Zirl', 'Hechenbergweg', '7', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::EMAIL_WORK, "inntal-audio@utanet.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 5125 63258'],
                    [Contact::FAX_WORK, '+43 5238 53224']
                ]
            ],
            [   NAME => 'Longtone Hi-Fi',
                DESCRIPTION => 'Handles the distribution of Dezorel for Austria and Croatia in addition to distributing QED, Ringmat Developments and Soundstyle in Austia only.',
                ADDRESS => [ [1070, 'Wien', 'Burggasse', '114', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "longtone.at", PRIMARY],
                    [Contact::EMAIL_WORK, "hifi@longtone.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 1 523 7025'],
                    [Contact::FAX_WORK, '+43 1 523 7025-55']
                ]
            ],
            [   NAME => 'Roland Koller Home Cinemas',
                DESCRIPTION => 'Distributes Genesis Advanced Technologies.',
                ADDRESS => [ [1060, 'Wien', 'Hofmühlgasse', '23', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "homecinemas.at", PRIMARY],
                    [Contact::EMAIL_WORK, "office@homecinemas.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 15 976 976']
                ]
            ],
            [   NAME => 'Styria HiFi HmbH',
                DESCRIPTION => 'Austrian high end dealer and audiophile record store that acts as the local distributor for Advance Acoustic, Amazon, Artora, Audio Physic, Geneva, Finite Elemente, Horizontal 51, Modul, Tivoli Audio and Wireworld Audio.',
                ADDRESS => [ [2320, 'Schwechat', 'Mischekgasse', '3', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "styriahifi.at", PRIMARY],
                    [Contact::EMAIL_WORK, "office@styriahifi.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 1 409 8787'],
                    [Contact::FAX_WORK, '+43 1 409 8788']
                ]
            ],
            [   NAME => 'The Source Audiosysteme',
                DESCRIPTION => 'Distributes Boston Audio Design and Leben.',
                ADDRESS => [ [1060, 'Schwechat', 'Stumpergasse', '38/17', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "thesource.co.at ", PRIMARY],
                    [Contact::EMAIL_WORK, "r_b@gmx.at.", PRIMARY],
                    [Contact::PHONE_WORK, '+43 676 355 6235', PRIMARY]
                ]
            ],
            [   NAME => 'Vienna Audiophiles & HiFi',
                DESCRIPTION => 'Distributes Agile and Manger.',
                ADDRESS => [ [1040, 'Wien', 'Kettenbrückengasse', '18', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "audiophiles.at", PRIMARY],
                    [Contact::EMAIL_WORK, "office@audiophiles.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 1 865 33 1724'],
                    [Contact::FAX_WORK, '+43 1 865 33 1714']
                ]
            ],
            [   NAME => 'Vogrin Datenprojektion',
                DESCRIPTION => 'Distributes Soundmatters.',
                ADDRESS => [ [6830, 'Rankweil', 'Langgasse', '114', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "av-vogrin.at", PRIMARY],
                    [Contact::EMAIL_WORK, "verkauf@datenprojektion.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 5522 46119-0']
                ]
            ],
            [   NAME => 'Wolfgang Spatt Handelsagentur',
                DESCRIPTION => 'Distributes Canton.',
                ADDRESS => [ [9073, 'Klagenfurt-Viktring', 'Siebenbürgengasse', '53', 'AU', PRIMARY ] ],
                CONTACT =>[
                    [Contact::WEB_WORK, "spattgmbh.at", PRIMARY],
                    [Contact::EMAIL_WORK, "office@spattgmbh.at", PRIMARY],
                    [Contact::PHONE_WORK, '+43 664 3 52 34 23'],
                    [Contact::PHONE_WORK, '+43 522 34 42 46']
                ]
            ]
        ]);
        */

        $orgFelixMartin = Organisation::getOrganisationIDByName('%felix%');

        // Add users
        User::addUser([
            // Employers & employees
                // Employers
                    // Felix Martin - CEO
                    [   ROLE => Role::ADMINISTRATOR, TYPE => Type::MANAGER,
                        UID  => 'felix',
                        PASS => 'felix',
                        FIRST_NAME => 'Felix', LAST_NAME => 'Martin', ORGANISATION => [$orgFelixMartin],
                        LANGUAGE => [ ['DE', PRIMARY], ['EN'], ['FR'] ],
                        CONTACT => [
                            [Contact::EMAIL_WORK, "felix@{$emailSuffix}", PRIMARY],
                            [Contact::PHONE_WORK, '+43 660 488 2089']
                        ]
                    ],
                    // Maria Martin - Consultant - 1st relative
                    [   ROLE => Role::MANAGER, TYPE => Type::MANAGER,
                        UID  => 'maria',
                        PASS => 'maria',
                        FIRST_NAME => 'Maria', LAST_NAME => 'Martin', ORGANISATION => [$orgFelixMartin],
                        LANGUAGE => [ ['DE', PRIMARY], ['EN'] ],
                        CONTACT => [
                            [Contact::EMAIL_WORK, "maria@{$emailSuffix}", PRIMARY],
                            [Contact::PHONE_WORK, '+43 664 520 1326']
                        ]
                    ],
                    // Heike Martin - Consultant - 2nd relative
                    [   ROLE => Role::MANAGER, TYPE => Type::MANAGER,
                        UID  => 'heike',
                        PASS => 'heike',
                        FIRST_NAME => 'Heike', LAST_NAME => 'Martin', ORGANISATION => [$orgFelixMartin],
                        LANGUAGE => [ ['DE', PRIMARY], ['EN'], ['ES'], ['FR'] ],
                        CONTACT => [
                            [Contact::EMAIL_WORK, "heike@{$emailSuffix}", PRIMARY],
                            [Contact::PHONE_WORK, '+43 676 650 5688']
                        ]
                    ],
                    // David Martin - Consultant - 3rd relative
                    [   ROLE => Role::MANAGER, TYPE => Type::MANAGER,
                        UID  => 'david',
                        PASS => 'david',
                        FIRST_NAME => 'David', LAST_NAME => 'Martin', ORGANISATION => [$orgFelixMartin],
                        LANGUAGE => [ ['DE', PRIMARY], ['EN'], ['HR'] ],
                        CONTACT => [
                            [Contact::EMAIL_WORK, "david@{$emailSuffix}", PRIMARY],
                            [Contact::PHONE_WORK, '+43 660 515 6072']
                        ]
                    ]
                // Employees

            // Suppliers
            // Customers
        ]);

    }

    /*
    private static $pdo = null;

    public static function setConnection( $connection ) {
        self::$pdo = $connection->getPDO();
    }
    public static function resetDatabase() {
        if( !is_null(self::$pdo) ) {
            $coreSQL = file_get_contents("sql/Core.sql");
            self::$pdo->exec($coreSQL);
        }
    }
    */
}

/*
$v1 = new Connection(\crm\Configuration\Configuration::getLocalCoreAccess());
$v2 = new Connection(\crm\Configuration\Configuration::getLocalOMAccess());
$v3 = new Connection(\crm\Configuration\Configuration::getLocalREPAccess());
$v4 = new Connection(\crm\Configuration\Configuration::getLocalCRMAccess());
*/

System::initialize([
    DEVELOPMENT => ON_LOCAL,
    MAIN_SERVER => CRM
]);

Reset::$connection = new Connection(\crm\Configuration\Configuration::getLocalCoreAccess());
//Reset::resetAll();

User::getUserByID(1001);

LogSystem::echoErrors();

STOP_HERE;

/*
$connection = new Connection( \crm\Configuration\Configuration::getServerAccess() );
Reset::setConnection($connection);
Reset::resetDatabase();
*/

/*
function Reset() {

    $user = User::getCurrentUser();
    $user->can("editPost"); // string
    $user->can(EDIT_POST); // string

    // Delete tables
    // Recreate tables

    // Add roles and privileges
        // Roles
        $administrator = Role::addRole("admin", "Administrator");
        $manager = Role::addRole("man", "Manager");
        $employee = Role::addRole("emp", "Employee");
        $customer = Role::addRole("cus", "Customer");

        // Privileges
        $canSignIn = Privilege::addPrivilege("signIn", "Can Sign In");
        $viewTopic = Privilege::addPrivilege("viewTopic", "Can View Topic");

        // Assign privileges to roles
        $administrator->addPrivilege( $canSignIn );
        $administrator->addPrivilege( $viewTopic );


    // Add languages and countries
    $eng = Language::addLanguage("EN", "English");

    $austria = Country::addCountry("AT", "Austria");

    //$administrator = Role::getRoleIDByShortName("admin");

    // Add users
    User::signUpUser([
        FIRST_NAME => "",
        LAST_NAME => "",
        ROLE => $administrator,
        LANGUAGE => [$eng],
        //ADDRESS => [new Address()]
        ADDRESS => ["line1", "line2", "1200", "Wien"]
    ]);

}
*/