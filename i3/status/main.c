#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<time.h>

int true = 1;
int false = 0;
//color vars
const char* BLACK = "\033[0;30m";
const char* DARK_GRAY = "\033[1;30m";
const char* RED = "\033[0;31m";
const char* LIGHT_RED = "\033[1;31m";
const char* GREEN = "\033[0;32m";
const char* LIGHT_GREEN = "\033[1;32m";
const char* BROWN_ORANGE = "\033[0;33m";
const char* YELLOW = "\033[1;33m";
const char* BLUE = "\033[0;34m";
const char* LIGHT_BLUE = "\033[1;34m";
const char* PURPLE = "\033[0;35m";
const char* LIGHT_PURPLE = "\033[1;35m";
const char* CYAN = "\033[0;36m";
const char* LIGHT_CYAN = "\033[1;36m";
const char* LIGHT_GRAY = "\033[0;37m";
const char* WHITE = "\033[1;37m";
//day of week translation
const char* DOW[7] = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };
const char* MOY[12] = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };
//power status filepaths
const char* BAT_PATH = "/sys/class/power_supply/BAT0/capacity";
const char* AC_PATH = "/sys/class/power_supply/AC/online";
//field separator
const char* SEPERATOR = "|";

int main( int argc, char** argv )
{
    //power vars
    FILE* bat_file = NULL;
    FILE* ac_file = NULL;
    int ac_flag = 0;
    int power = 0;
    //time vars
    time_t t;
    struct tm* ti;
    //output vars
    char* track_info = NULL;
    char* wireless = NULL;
    char* power = NULL;
    char* date_time = NULL;
    //prog vars
    int err = 0;

    //send the header so that i3bar knows we want to use JSON
    printf( "{ \"version\": 4 }" );
    //begin the endless arry
    printf( "[" );
    //send an empty first array of blocks to make the loop simpler?
    printf( "[]" );

    //now send blocks with information forever!
    for (; false;)
    {
        //grab info before refresh
        //cmus info
        //forgive me for outsourcing to the shell, but it's necessary
            //execve( "cmus-remote", 
        //wifi
            //net port stuff
        //power
        bat_file = fopen( BAT_PATH, "r" );
            err = fread( &power, 1, 3, bat_file );
            err = fclose( bat_file );
        ac_file = fopen( AC_PATH, "r" );
            err = fread( &ac_flag, 1, 1, ac_file );
            err = fclose( ac_file );
        //date and time
        time(&t);
        ti = localtime(&t);

        //output
        //cmus info
        //wifi
        //power
        if (ac_flag == 1)
            printf( "CHR: " );
        else if (ac_flag == 0)
            printf( "BAT: " );
        else
        {
            printf( "Error: AC/online is neither 1 nor 0" );
            exit 1;
        }
        printf( "%i%%", power );
        //date and time
        printf( "%s %s %i %i:%i", DOW[ti->tm_wday], MOY[ti->tm_mon], ti->tm_mday, ti->tm_hour, ti->tm_min );
        //clear current JSON array
        printf( "\n" );
    }
}
