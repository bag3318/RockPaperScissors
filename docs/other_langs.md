---
layout: default
title: Other Langs - Play Rock Paper Scissors Game
permalink: /different_code.html
---

# Other Langs

## Python

```python
import random
import sys

def makeYourChoice():
    print "Press R for Rock"
    print "Press P for Paper"
    print "Press S for Scissors"
    print "Press Q to quit!"

    userChoice = raw_input("What do you want to choose?").lower()
    
    if userChoice == "r":
        return "Rock"
    if userChoice == "p":
        return "Paper"
    if userChoice == "s":
        return "Scissors"
    if userChoice == "q":
        sys.exit(0)
    else:
        makeYourChoice()

def computerRandom():
    options = ["Rock","Paper","Scissors"]
    randomChoice = random.randint(0,2)
    return options[randomChoice]

def comparison(humanChoice, computerChoice):
    if humanChoice == computerChoice:
        return "Draw"
    if humanChoice == "Rock" and computerChoice == "Paper":
        return "Computer Wins"
    if humanChoice == "Paper" and computerChoice == "Scissors":
        return "Computer Wins"
    if humanChoice == "Scissors" and computerChoice == "Rock":
        return "Computer Wins"
    else: return "Human Wins"

#print makeYourChoice()

while True:
    humanChoice = makeYourChoice()
    computerChoice =  computerRandom()

    print "You chose", humanChoice
    print "The computer chose", computerChoice

    result = comparison (humanChoice, computerChoice)

    if result == "Draw":
        print "Its a draw"
    elif result == "Computer Wins":
        print "Unlucky you lost!"
    else: print "Well done you won!"

    print " "
```

## Perl 

```perl
use 5.012;
use warnings;
use utf8;
use open qw(:encoding(utf-8) :std);
use Getopt::Long;
 
=pod
RPS programmed in Perl
=cut

package Game {
    use List::Util qw(shuffle first);
 
    my $turns        = 0;
    my %human_choice = ( rock => 0, paper => 0, scissors => 0, );
    my %comp_choice  = ( rock => 0, paper => 0, scissors => 0, );
    my %what_beats =
      ( rock => 'paper', paper => 'scissors', scissors => 'rock', );
    my $comp_wins  = 0;
    my $human_wins = 0;
    my $draws      = 0;
 
    sub save_human_choice {
        my $ch = lc pop;
        if ( exists $human_choice{ $ch } ) {
            ++$human_choice{ $ch };
        }
        else {
            die __PACKAGE__ . ":: wrong choice: '$ch'";
        }
    }
 
    sub get_comp_choice {
        my @keys = shuffle keys %human_choice;
        my $ch;
        my ( $prob, $rand ) = ( 0, rand );
        $ch = ( first { $rand <= ( $prob += ( $human_choice{ $_ } / $turns ) ) } @keys )
            if $turns > 0;
        $ch //= $keys[0];
        $ch = $what_beats{ $ch };
        ++$comp_choice{ $ch };
        return $ch;
    }
 
    sub make_turn {
        my ( $comp_ch, $human_ch ) = ( pop(), pop() );
        ++$turns;
        if ( $what_beats{ $human_ch } eq $comp_ch ) {
            ++$comp_wins;
            return 'I win!';
        }
        elsif ( $what_beats{ $comp_ch } eq $human_ch ) {
            ++$human_wins;
            return 'You win!';
        }
        else {
            ++$draws;
            return 'Draw!';
        }
    }
 
    sub get_final_report {
        my $report =
            "You chose:\n"
          . "  rock     = $human_choice{rock} times,\n"
          . "  paper    = $human_choice{paper} times,\n"
          . "  scissors = $human_choice{scissors} times,\n"
          . "I chose:\n"
          . "  rock     = $comp_choice{rock} times,\n"
          . "  paper    = $comp_choice{paper} times,\n"
          . "  scissors = $comp_choice{scissors} times,\n"
          . "Turns: $turns\n"
          . "I won: $comp_wins, you won: $human_wins, draws: $draws\n";
        return $report;
    }
}
 
sub main {
    GetOptions( 'quiet' => \my $quiet );
    greet() if !$quiet;
    while (1) {
        print_next_line() if !$quiet;
        my $input = get_input();
        last unless $input;
        if ( $input eq 'error' ) {
            print "I don't understand!\n" if !$quiet;
            redo;
        }
        my $comp_choice = Game::get_comp_choice();
        Game::save_human_choice($input);
        my $result = Game::make_turn( $input, $comp_choice );
        describe_turn_result( $input, $comp_choice, $result )
          if !$quiet;
    }
    print Game::get_final_report();
}
 
sub greet {
    print "Welcome to the Rock-Paper-Scissors game!\n"
      . "Choose 'rock', 'paper' or 'scissors'\n"
      . "Enter empty line or 'quit' to quit\n";
}
 
sub print_next_line {
    print 'Your choice: ';
}
 
sub get_input {
    my $input = <>;
    print "\n" and return if !$input;    # EOF
    chomp $input;
    return if !$input or $input =~ m/\A \s* q/xi;
    return 
        ( $input =~ m/\A \s* r/xi ) ? 'rock'
      : ( $input =~ m/\A \s* p/xi ) ? 'paper'
      : ( $input =~ m/\A \s* s/xi ) ? 'scissors'
      :                               'error';
}
 
sub describe_turn_result {
    my ( $human_ch, $comp_ch, $result ) = @_;
    print "You chose \u$human_ch, I chose \u$comp_ch. $result\n";
}
 
main();
```

## C\# 

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
 
namespace RockPaperScissors
{
    class Program
    {
        static void Main(string[] args)
        {
            // There is no limit on the amount of weapons supported by RPSGame. Matchups are calculated depending on the order.
            var rps = new RPSGame("scissors", "paper", "rock", "lizard", "spock");
 
            int wins = 0, losses = 0, draws = 0;
 
            while (true)
            {
                Console.WriteLine("Make your move: " + string.Join(", ", rps.Weapons) + ", quit");
 
                string weapon = Console.ReadLine().Trim().ToLower();
 
                if (weapon == "quit")
                    break;
 
                if (!rps.Weapons.Contains(weapon))
                {
                    Console.WriteLine("Invalid weapon!");
                    continue;
                }
 
                int result = rps.Next(weapon);
 
                Console.WriteLine("You chose {0} and your opponent chose {1}!", weapon, rps.LastAIWeapon);
 
                switch (result)
                {
                    case 1: Console.WriteLine("{0} pwns {1}. You're a winner!", weapon, rps.LastAIWeapon);
                        wins++;
                        break;
                    case 0: Console.WriteLine("Draw!");
                        draws++;
                        break;
                    case -1: Console.WriteLine("{0} pwns {1}. You're a loser!", rps.LastAIWeapon, weapon);
                        losses++;
                        break;
                }
 
                Console.WriteLine();
            }
 
            Console.WriteLine("\nPlayer Statistics\nWins: {0}\nLosses: {1}\nDraws: {2}", wins, losses, draws);
        }
 
        class RPSGame
        {
            public RPSGame(params string[] weapons)
            {
                Weapons = weapons;
 
                // Creates a new AI opponent, and gives it the list of weapons.
                _rpsAI = new RPSAI(weapons);
            }
 
            // Play next turn.
            public int Next(string weapon)
            {
                string aiWeapon = _rpsAI.NextMove(); // Gets the AI opponent's next move.
                LastAIWeapon = aiWeapon; // Saves the AI opponent's move in a property so the player can see it.
 
                _rpsAI.AddPlayerMove(weapon); // Let the AI know which weapon the player chose, for future predictions.
                return GetWinner(Weapons, weapon, aiWeapon); // Returns -1 if AI win, 0 if draw, and 1 if player win.
            }
 
            // Returns matchup winner.
            public static int GetWinner(string[] weapons, string weapon1, string weapon2)
            {
                if (weapon1 == weapon2)
                    return 0; // If weapons are the same, return 0 for draw.
 
                if (GetVictories(weapons, weapon1).Contains(weapon2))
                    return 1; // Returns 1 for weapon1 win.
                else if (GetVictories(weapons, weapon2).Contains(weapon1))
                    return -1; // Returns -1 for weapon2 win.
 
                throw new Exception("No winner found.");
            }
 
            /* 
             * Return weapons that the provided weapon beats.
             * The are calculated in the following way:
             * If the index of the weapon is even, then all even indices less than it,
             * and all odd indices greater than it, are victories.
             * One exception is if it is an odd index, and also the last index in the set,
             * then the first index in the set is a victory.
             */
            public static IEnumerable<string> GetVictories(string[] weapons, string weapon)
            {
                // Gets index of weapon.
                int index = Array.IndexOf(weapons, weapon);
 
                // If weapon is odd and the final index in the set, then return the first item in the set as a victory.
                if (index % 2 != 0 && index == weapons.Length - 1)
                    yield return weapons[0];
 
                for (int i = index - 2; i >= 0; i -= 2)
                    yield return weapons[i];
 
                for (int i = index + 1; i < weapons.Length; i += 2)
                    yield return weapons[i];
            }
 
            public string LastAIWeapon
            {
                private set;
                get;
            }
 
            public readonly string[] Weapons;
            private RPSAI _rpsAI;
 
            class RPSAI
            {
                public RPSAI(params string[] weapons)
                {
                    _weapons = weapons;
                    _weaponProbability = new Dictionary<string, int>();
 
                    // The AI sets the probability for each weapon to be chosen as 1.
                    foreach (string weapon in weapons)
                        _weaponProbability.Add(weapon, 1);
 
                    _random = new Random();
                }
 
                // Increases probability of selecting each weapon that beats the provided move.
                public void AddPlayerMove(string weapon)
                {
                    int index = Array.IndexOf(_weapons, weapon);
 
                    foreach (string winWeapon in _weapons.Except(GetVictories(_weapons, weapon)))
                        if (winWeapon != weapon)
                            _weaponProbability[winWeapon]++;
                }
 
                // Gets the AI's next move.
                public string NextMove()
                {
                    double r = _random.NextDouble();
 
                    double divisor = _weaponProbability.Values.Sum();
 
                    var weightedWeaponRanges = new Dictionary<double, string>();
 
                    double currentPos = 0.0;
 
                    // Maps probabilities to ranges between 0.0 and 1.0. Returns weighted random weapon.
                    foreach (var weapon in _weaponProbability)
                    {
                        double weightedRange = weapon.Value / divisor;
                        if (r <= currentPos + (weapon.Value / divisor))
                            return weapon.Key;
                        currentPos += weightedRange;
                    }
 
                    throw new Exception("Error calculating move.");
                }
 
                Random _random;
                private readonly string[] _weapons;
                private Dictionary<string, int> _weaponProbability;
            }
        }
    }
}
```

## C++

```cpp
#include <windows.h>
#include <iostream>
#include <string>
 
//-------------------------------------------------------------------------------
using namespace std;
 
//-------------------------------------------------------------------------------
enum choices { ROCK, SPOCK, PAPER, LIZARD, SCISSORS, MX_C };
enum indexes { PLAYER, COMPUTER, DRAW };
 
//-------------------------------------------------------------------------------
class stats
{
public:
    stats() : _draw( 0 )
    {
        ZeroMemory( _moves, sizeof( _moves ) );
	ZeroMemory( _win, sizeof( _win ) );
    }
    void draw()		        { _draw++; }
    void win( int p )	        { _win[p]++; }
    void move( int p, int m )   { _moves[p][m]++; }
    int getMove( int p, int m ) { return _moves[p][m]; }
    string format( int a )
    {
	char t[32];
	wsprintf( t, "%.3d", a );
	string d( t );
	return d;
    }
 
    void print()
    {
        string  d = format( _draw ),
	       pw = format( _win[PLAYER] ),		cw = format( _win[COMPUTER] ),
	       pr = format( _moves[PLAYER][ROCK] ),	cr = format( _moves[COMPUTER][ROCK] ),
               pp = format( _moves[PLAYER][PAPER] ),	cp = format( _moves[COMPUTER][PAPER] ),
	       ps = format( _moves[PLAYER][SCISSORS] ), cs = format( _moves[COMPUTER][SCISSORS] ),
	       pl = format( _moves[PLAYER][LIZARD] ),	cl = format( _moves[COMPUTER][LIZARD] ),
	       pk = format( _moves[PLAYER][SPOCK] ),	ck = format( _moves[COMPUTER][SPOCK] );
 
	system( "cls" );
	cout << endl;
	cout << "+----------+-------+--------+--------+---------+----------+--------+---------+" << endl;
	cout << "|          |  WON  |  DRAW  |  ROCK  |  PAPER  | SCISSORS | LIZARD |  SPOCK  |" << endl;
	cout << "+----------+-------+--------+--------+---------+----------+--------+---------+" << endl;
	cout << "|  PLAYER  |  "  << pw << "  |        |   " << pr << "  |   " << pp << "   |   " << ps << "    |  " << pl << "   |   " << pk << "   |" << endl;
	cout << "+----------+-------+   " << d << "  +--------+---------+----------+--------+---------+" << endl;
	cout << "| COMPUTER |  "  << cw << "  |        |   " << cr << "  |   " << cp << "   |   " << cs << "    |  " << cl << "   |   " << ck << "   |" << endl;
	cout << "+----------+-------+--------+--------+---------+----------+--------+---------+" << endl;
	cout << endl << endl;
 
	system( "pause" );
 
    }
 
private:
    int _moves[2][MX_C], _win[2], _draw;
};
//-------------------------------------------------------------------------------
class rps
{
private:
    int makeMove()
    {
	int total = 0, r, s;
	for( int i = 0; i < MX_C; total += statistics.getMove( PLAYER, i++ ) );
	r = rand() % total;
 
	for( int i = ROCK; i < SCISSORS; i++ )
	{
	    s = statistics.getMove( PLAYER, i );
	    if( r < s ) return ( i + 1 );
	    r -= s;
	}
 
	return ROCK;
    }
 
    void printMove( int p, int m )
    {
	if( p == COMPUTER ) cout << "My move: ";
	else cout << "Your move: ";
 
	switch( m )
	{
	    case ROCK: cout << "ROCK\n"; break;
	    case PAPER: cout << "PAPER\n"; break;
	    case SCISSORS: cout << "SCISSORS\n"; break;
	    case LIZARD: cout << "LIZARD\n"; break;
	    case SPOCK: cout << "SPOCK\n";
	}
    }
 
public:
    rps()
    {
	checker[ROCK][ROCK] = 2; checker[ROCK][PAPER] = 1; checker[ROCK][SCISSORS] = 0; checker[ROCK][LIZARD] = 0; checker[ROCK][SPOCK] = 1;
	checker[PAPER][ROCK] = 0; checker[PAPER][PAPER] = 2; checker[PAPER][SCISSORS] = 1; checker[PAPER][LIZARD] = 1; checker[PAPER][SPOCK] = 0;
	checker[SCISSORS][ROCK] = 1; checker[SCISSORS][PAPER] = 0; checker[SCISSORS][SCISSORS] = 2; checker[SCISSORS][LIZARD] = 0; checker[SCISSORS][SPOCK] = 1;
	checker[LIZARD][ROCK] = 1; checker[LIZARD][PAPER] = 0; checker[LIZARD][SCISSORS] = 1; checker[LIZARD][LIZARD] = 2; checker[LIZARD][SPOCK] = 0;
	checker[SPOCK][ROCK] = 0; checker[SPOCK][PAPER] = 1; checker[SPOCK][SCISSORS] = 0; checker[SPOCK][LIZARD] = 1; checker[SPOCK][SPOCK] = 2;
    }
    void play()
    {
	int p, r, m;
	while( true )
	{
	    cout << "What is your move (1)ROCK (2)SPOCK (3)PAPER (4)LIZARD (5)SCISSORS (0)Quit ? ";
	    cin >> p;
	    if( !p || p < 0 ) break;
	    if( p > 0 && p < 6 )
	    {
		p--;
		cout << endl;
		printMove( PLAYER, p );
		statistics.move( PLAYER, p );
 
		m = makeMove();
		statistics.move( COMPUTER, m );
		printMove( COMPUTER, m );
 
		r = checker[p][m];
		switch( r )
		{
		    case DRAW: 
		        cout << endl << "DRAW!" << endl << endl; 
		        statistics.draw();
		    break;
		    case COMPUTER: 
			cout << endl << "I WIN!" << endl << endl;  
			statistics.win( COMPUTER );
		    break;
		    case PLAYER: 
			cout << endl << "YOU WIN!" << endl << endl; 
			statistics.win( PLAYER );
 
		}
		system( "pause" );
	    }
	    system( "cls" );
	}
	statistics.print();
    }
 
private:
    stats statistics;
    int checker[MX_C][MX_C];
};
//-------------------------------------------------------------------------------
int main( int argc, char* argv[] )
{
    srand( GetTickCount() );
    rps game;
    game.play();
    return 0;
}
//-------------------------------------------------------------------------------
```

## Go

```go

package main
import (
    "fmt"
    "math/rand"
    "strings"
    "time"
)
 
const rps = "rps"
 
var msg = []string{
    "Rock breaks scissors",
    "Paper covers rock",
    "Scissors cut paper",
}
 
func main() {
    rand.Seed(time.Now().UnixNano())
    fmt.Println("Rock Paper Scissors")
    fmt.Println("Enter r, p, or s as your play.  Anything else ends the game.")
    fmt.Println("Running score shown as <your wins>:<my wins>")
    var pi string // player input
    var aScore, pScore int
    sl := 3               // for output alignment
    pcf := make([]int, 3) // pcf = player choice frequency
    var plays int
    aChoice := rand.Intn(3) // ai choice for first play is completely random
    for {
        // get player choice
        fmt.Print("Play: ")
        _, err := fmt.Scanln(&pi)  // lazy
        if err != nil || len(pi) != 1 {
            break
        }
        pChoice := strings.Index(rps, pi)
        if pChoice < 0 {
            break
        }
        pcf[pChoice]++
        plays++
 
        // show result of play
        fmt.Printf("My play:%s%c.  ", strings.Repeat(" ", sl-2), rps[aChoice])
        switch (aChoice - pChoice + 3) % 3 {
        case 0:
            fmt.Println("Tie.")
        case 1:
            fmt.Printf("%s.  My point.\n", msg[aChoice])
            aScore++
        case 2:
            fmt.Printf("%s.  Your point.\n", msg[pChoice])
            pScore++
        }
 
        // show score
        sl, _ = fmt.Printf("%d:%d  ", pScore, aScore)
 
        // compute ai choice for next play
        switch rn := rand.Intn(plays); {
        case rn < pcf[0]:
            aChoice = 1
        case rn < pcf[0]+pcf[1]:
            aChoice = 2
        default:
            aChoice = 0
        }
    }
}
```