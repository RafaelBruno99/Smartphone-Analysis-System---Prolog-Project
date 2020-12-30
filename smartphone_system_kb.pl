cls :- write('\e[2J').


/* Rafael Bruno & Luke Earle */


/*------------------*/
/* INFERENCE ENGINE */
/*------------------*/

begin:-

	initialise,
	collect_sex,
	collect_age,
	collect_geral,
	rule(Number,Smartphone, Advice),
	reply(Smartphone,Reply),
	write('According to your answers the phone that you should buy is:'),nl,nl,
	write(Reply),nl,nl,
	write('Justification of Conclusion'),nl,nl,
	write('The rule used was number '),
	write(Number),
	write(': '),
	write(Advice), nl,
	retractall(information(_)).

begin:-
write('Sorry cannot help'),nl,nl,
retractall(information(_)).

initialise:-
	nl,nl,nl,nl,
	tab(40),write('******************************************'),nl,
	tab(40),write('*** Smartphone Analysis System ***'),nl,
	tab(40),write('******************************************'),nl,nl.


/* Processing of data */

collect_sex:-
  questionsex(Quest, Answer),
	write(Quest),nl,
	getsex(Value),nl,
	assertz(information(Answer));
collect_sex.

getsex(X):-
	repeat,
	write('Please answer M/F'),nl,
	read(Z),nl,
	check(Z),
	X=Z,!.

	check('M'). %Check a valid answer
	check('m').
	check('F').
	check('f').

collect_age:-
	questionage(Quest, Answer),
	write(Quest),nl,
	getage(0, 100,Value),nl,
	assertz(information(Answer)).

collect_age.

getage(X, Y, A):-
	read(Z),nl,
	between(X, Y, Z),!. %Between function in order to valitade the age of the user

collect_geral:-
	question(Quest, Answer),
	write(Quest),nl,
	getyesno(Yesno),nl,
	(Yesno='yes';Yesno='y'),
	assertz(information(Answer)),
	(Yesno='no';Yesno='n'),
	retract(information(Answer)),
	fail.

collect_geral.

getyesno(X):-
	repeat,
	write('Please answer y or n:'),nl,
	read(Z),nl,
	check(Z),
	X=Z,!.

	check('yes').
	check('y').
	check('no').
	check('n').



/* Questions */

questionsex('What your sex?',sex).
questionage('What is your age?',age).
question('Do you have any experience with Smartphone?', experience).
question('Do you currently own an Apple device?', own_apple).
question('Do you currently own an Android device?', own_android).
question('Do you need a good camera on your device?', pictures).
question('Do you activilely download mobile applications?', apps).
question('Do you speed more then 4 hours a day on your mobile device?', batterylife).
question('do you have/want a wireless charger?', wireless).
question('Do you need a device with fast processing power?', power).
question('Do you frequently play mobile games?', mobilegames).
question('Do you want a bigger screen?', bigscreen).
question(‘do you want a fingerprint sensor?’, fingerprint).

/* Rules (Different devices that can be presented to the user depending on the answers provided) */

rule(1, samsung_a21s, 'The best phone for you is Samsung A21s.'):-
	information(experience), information(own_android), information(pictures), information(batterylife), information(bigscreen), information(apps), information(fingerprint).

rule(2, samsung_a71, 'The best phone for you is Samsung A71.'):-
	information(experience), information(own_android), information(pictures), information(batterylife), information(bigscreen), information(apps), information(mobilegames), information(power),information(fingerprint).

rule(3, samsung_s10, 'The best phone for you is Samsung S10.'):-
	information(experience), information(own_android), information(pictures), information(batterylife),information(wireless), information(apps), information(mobilegames), information(power),information(fingerprint).

rule(4, samsung_a41, 'The best phone for you is Samsung A41.'):-
	information(experience), information(own_android), information(pictures), information(batterylife), information(apps), information(power),information(fingerprint).

rule(5, apple_11, 'The best phone for you is Apple 11.'):-
	information(experience), information(own_apple), information(pictures), information(batterylife), information(wireless), information(bigscreen), information(apps), information(mobilegames), information(power).

rule(6, apple_7, 'The best phone for you is Apple 7.'):-
	information(experience), information(own_apple), information(batterylife), information(wireless), information(mobilegames), information(apps), information(power),information(fingerprint).

rule(7, apple_8plus, 'The best phone for you is Apple 8 Plus.'):-
	information(experience), information(own_apple), information(batterylife), information(apps), information(mobilegames), information(bigscreen),information(fingerprint).

rule(8, apple_se2020, 'The best phone for you is Apple SE 2020.'):-
	information(experience), information(own_apple), information(batterylife), information(wireless), information(apps), information(mobilegames), information(fingerprint).

rule(9,unknown).


/* Reply (Provide the user with the price for that particular device.) */

reply(samsung_a21s,'You can get this device for £149.').
reply(samsung_a71,'You can get this device for £400.').
reply(samsung_a41, 'You can get this device for £250.').
reply(samsung_s10,'You can get this device for £500.').
reply(apple_8plus, 'You can get this device for £450.').
reply(apple_7, 'You can get this device for £300.').
reply(apple_11, 'You can get this device for £600.').
reply(apple_se2020, 'You can get this device for £400.').
reply(unknown, 'Sorry but currently we have no information.').
