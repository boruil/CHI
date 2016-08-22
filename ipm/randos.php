<?php

// Generate a random username for the connecting client
function randomUsername() {
    $ADJECTIVES = array(
        'Abrasive', 'Brash', 'Callous', 'Daft', 'Eccentric', 'Fiesty', 'Golden',
        'Holy', 'Ignominious', 'Joltin', 'Killer', 'Luscious', 'Mushy', 'Nasty',
        'OldSchool', 'Pompous', 'Quiet', 'Rowdy', 'Sneaky', 'Tawdry',
        'Unique', 'Vivacious', 'Wicked', 'Xenophobic', 'Yawning', 'Zesty',
    );

    $FIRST_NAMES = array(
        'Anna', 'Bobby', 'Cameron', 'Danny', 'Emmett', 'Frida', 'Gracie', 'Hannah',
        'Isaac', 'Jenova', 'Kendra', 'Lando', 'Mufasa', 'Nate', 'Owen', 'Penny',
        'Quincy', 'Roddy', 'Samantha', 'Tammy', 'Ulysses', 'Victoria', 'Wendy',
        'Xander', 'Yolanda', 'Zelda',
    );

    $LAST_NAMES = array(
        'Anchorage', 'Berlin', 'Cucamonga', 'Davenport', 'Essex', 'Fresno',
        'Gunsight', 'Hanover', 'Indianapolis', 'Jamestown', 'Kane', 'Liberty',
        'Minneapolis', 'Nevis', 'Oakland', 'Portland', 'Quantico', 'Raleigh',
        'SaintPaul', 'Tulsa', 'Utica', 'Vail', 'Warsaw', 'XiaoJin', 'Yale',
        'Zimmerman',
    );

    $NAMES = array(
        'USER1', 'USER2', 'USER3', 'USER4', 'USER5', 'USER6',
        'USER7', 'USER11', 'USER14', 'USER17', 'USER20', 'USER23',
        'USER8', 'USER12', 'USER15', 'USER18', 'USER21', 'USER24',
        'USER9', 'USER13', 'USER16', 'USER19', 'USER22', 'USER25', 'USER26',
        'USER10',
    );

    // Choose random components of username and return it
    $adj = $ADJECTIVES[array_rand($ADJECTIVES)];
    $fn = $FIRST_NAMES[array_rand($FIRST_NAMES)];
    $ln = $LAST_NAMES[array_rand($LAST_NAMES)];
    $nm = $NAMES[array_rand($NAMES)];

    return $nm;
}