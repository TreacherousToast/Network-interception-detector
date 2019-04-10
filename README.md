# Network-interception-detector
A program that detects if your network traffic is being intercepted by comparing ping times.

This is a very simple program that I mostly made to practice shell scripting. It is definitely not the best program for this task. If you actually need a program like this, this program is not the best option. 

It works by pinging Google 10 times, and storing that time in a variable. If the network hasn't been tested before, it writes that time to a file (stored in the home directory) with the network name. If the network has been tested before, it compares the time in the file for the network, and if the ping that was just tested is greater than the ping in the file by more than 2 milliseconds, the program says that your connection may be comprimised. If not, it says that your connection is probably safe.

Dependencies (may not be installed on your computer): iwconfig and perl.
