Original plan was to create a front-end on my already existing website (kirstenmayland.me); however, after nearly 4 hours of attempting to connect my database to my website and encountering countless errors (a few detailed below), I gave up and decided to just host it on the local host.

2 hr general researching and fiddling around with html and php

+ 30-45 min on XAMPP (also threw an error)

![Screenshot (34)](https://github.com/KirstenMayland/cs61databases/assets/102620915/ed4e3faa-262b-42b8-9f0d-4e75e10c67cf)
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/924eea3f-4e8a-4a50-b5e6-8384a9b8ad6d)

^ another hour of errors later, I gave up


FINALLY 4.5 hrs in, got XAMPP to work
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/4d1769f5-6866-4f23-a9a8-b72b5b299a43)

https://www.geeksforgeeks.org/how-to-fetch-data-from-localserver-database-and-display-on-html-table-using-php/#

[https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-20-04](https://radu.link/fix-cannot-validate-php-vs-code/)https://radu.link/fix-cannot-validate-php-vs-code/

![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/cf918039-3a13-499a-bc1d-d3542a8719d7)
^ progress finally, 5 hrs in


![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/b1d2a7f9-6caf-4a34-a430-507fb9504f9e)
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/4d7dfb3b-693a-41bf-b7af-42956ac1783e)

^ got it to work for the local host (yay!) so I thought I could just convert the idea over to my website. No, did not work, it just downloaded it :/


Now that I have gotten the local host into a place where I can access my database I can actually plan what I'm trying to do:  
Thoughts-  
1) form to query database based on day + what's being lost; returns two values: the cumulative losses at that date and the losses in that specific day (https://www.w3schools.com/php/php_mysql_select.asp)

5.5 hrs in, first successful query, that took too long, I know we did some of this as a classlab, but understanding XAMPP and VSCode was a much bigger hurdle than anticipated

![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/99faf8e8-107f-471c-a20c-ea6df456b4b8)

6 hrs in, got cumulative loss query to work:
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/9177a0a6-ca07-4d98-9bd3-1a52ae74a7bc)

6.5 hrs in, got daily loss query up and running:
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/dc9a314d-0101-4810-a8e1-51cdb131f799)

At this point, things are starting to pick up speed because I have finally gotten a handle on php, but there are still a couple more things I want to add in terms of formatting and performance before I move on.  
Things on the list:  
1) make it so that you can query any attribute, not just equip_loss attributes
2) better error handling if a non valid attribute or day is entered
3) try and get it to load the page automatically reset, or maybe defaulting to most recent day?
4) Add a -day 1, all 0's- to the equip_loss table so ppl can query day 2 daily loss
5) create a list of possible query options, maybe a click instead of type?
6) change to prepared statements to prevent injection
7) better format the output
8) add option to query by date instead of day
9) add over + about option if personnel is queried

2 hrs doing #1, 2, 3
