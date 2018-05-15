#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>

int true = 1;
int false = 0;

int main( int argc, char** argv )
{
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
        execve( "cmus-remote", 
        //wifi
        //power
        //date and time

        //output
        //cmus info
        //wifi
        //power
        //date and time
    }
}
