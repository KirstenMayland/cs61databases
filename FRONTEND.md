## Front-End
- [README.md](README.md)
- [DESIGN.md](DESIGN.md)
- [IMPLEMENTATION.md](IMPLEMENTATION.md)
- [ANALYSIS.md](ANALYSIS.md)
- [FRONTEND.md](FRONTEND.md)
### Goal
To create a working frontend to the `russia_losses` database that allows you to query it from the web, or at least the localhost, and to learn more about servers and frontend-backend interaction in the process

### Final Result
When you open the page you are met with this screen, where you are prompted to input a day and loss type.  If you do not want to input a loss type yourself, you can click one of the buttons which will write the value written on the button onto the 'Loss Type: ' submission box (i.e. click 'drone' and "drone" will be written)  
&nbsp;\
<img width="960" alt="Screenshot 2023-08-29 015005" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/f1327783-a756-4b02-b5bb-649593163145">

  
&nbsp;\
Some features are:
- in order to submit, one can either click the 'submit' button or click 'enter'
- clicking on the word "Database" in the upper right will refresh the page
- <img width="171" alt="Screenshot 2023-08-29 013010" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/430608e2-97bc-4845-8a0e-c47028c84ea1">
- if you input a day that is out of range or a loss type that is not in either the `equip_loss` or `personnel_loss` tables, you get this response
- <img width="228" alt="Screenshot 2023-08-29 014757" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/fff2b0af-b26c-4666-8909-c3603fcc0ff7">
- a correct prompt results in response of this type (eg. if day=197 and loss type=helicopter was inputted)
- <img width="418" alt="Screenshot 2023-08-29 013838" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/fa3e9508-2f93-4c95-b04a-6a67ce04e452">





### Resources Used
-  [GeeksForGeeks: Connecting Localserver Database and HTML/PHP](https://www.geeksforgeeks.org/how-to-fetch-data-from-localserver-database-and-display-on-html-table-using-php/#)
- [Radu: Fix, 'Cannot Validate PHP VSCode'](https://radu.link/fix-cannot-validate-php-vs-code/)
- [W3Schools: PHP MySQL select](https://www.w3schools.com/php/php_mysql_select.asp)
- \+ numerous visits to [StackOverflow](https://stackoverflow.com/), [GeeksForGeeks](https://www.geeksforgeeks.org/), [W3Schools](https://www.w3schools.com/), and [Mozilla Developer](https://developer.mozilla.org/en-US/) for all variety of minor questions and errors pertaining to documentation and syntax

### Timeline of Process
###### (Note, hour details when the below text was completed, NOT started)
#### Hour 0.75
General researching into how to establish a frontend

#### Hour 3.5
The original plan was to create a frontend on my already existing website (kirstenmayland.me); however, after nearly 3 hours of attempting to connect my database to my website and encountering countless errors, I gave up and decided to just host it on the localhost. I later learned that the cause of my errors was because my website is hosted by Github Pages and thus does not support PHP, which I was attempting to work with.    
&nbsp;\
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/4d7dfb3b-693a-41bf-b7af-42956ac1783e)  
&nbsp;\
After giving up on hosting the frontend on my website, I turned my efforts towards hosting it on the localhost instead, using XAMPP. Errors continue to abound  
&nbsp;\
One Example Error:  
&nbsp;\
![Screenshot (34)](https://github.com/KirstenMayland/cs61databases/assets/102620915/28f61883-cf22-4dc7-9c4f-83c9c6df12f5)
&nbsp;\
Second Example Error:  
&nbsp;\
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/924eea3f-4e8a-4a50-b5e6-8384a9b8ad6d)

#### Hour 4.5
Finally got XAMPP webserver set up and running  
&nbsp;\
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/4d1769f5-6866-4f23-a9a8-b72b5b299a43)

#### Hour 5
Got the PHP to work, or at least connect, to the localhost  
&nbsp;\
![Screenshot (40)](https://github.com/KirstenMayland/cs61databases/assets/102620915/0889ce86-18bd-4503-876c-45981e489ab9)
&nbsp;\
Now that I have gotten the local host into a place where I can access my database I can actually plan what I'm trying to do:  

Thoughts-  
1) form to query database based on day + what's being lost; returns two values: the cumulative losses at that date and the losses in that specific day 

#### Hour 5.5
First successful query! That took much longer than anticipated, I know we did this rough idea as a classlab, but understanding how XAMPP and VSCode work together was a much bigger hurdle than anticipated.  
&nbsp;\
![Screenshot (45)](https://github.com/KirstenMayland/cs61databases/assets/102620915/c7d5dcd1-0671-4ea3-a879-0d48eb3fefa6)

#### Hour 6
Got cumulative loss query to work:  
&nbsp;\
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/9177a0a6-ca07-4d98-9bd3-1a52ae74a7bc)

#### Hour 6.5
Got daily loss query up and running:  
&nbsp;\
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/dc9a314d-0101-4810-a8e1-51cdb131f799)

At this point, things are starting to pick up speed because I have finally gotten a handle on php, but there are still a couple more things I want to add in terms of formatting and performance before I move on.  
Goals on the list:  
1) make it so that you can query any attribute, not just equip_loss attributes
2) better error handling if a non valid attribute or day is entered
3) try and get it to load the page automatically reset, or maybe defaulting to most recent day?
4) Add a -day 1, all 0's- to the equip_loss table so ppl can query day 2 daily loss
5) create a list of possible query options, maybe a click instead of type?
6) change to prepared statements to prevent injection
7) better format the output
8) add option to query by date instead of day
9) add over + about option if personnel is queried
10) change password from one I actually use
11) fix attribute inputs with spaces
12) add it so that if you chose to look at POW or cruise past day 64, it reads "untracked" as opposed to "0"

#### Hour 8.5
Achieved tasks 1, 2, 3, and 4 + a tiny bit of general formatting
1) Made it so that you can query an attribute in either `equip_loss` or `personnel_loss` tables
2) Better error handling if a non valid attribute or day is entered
3) Page loads with a "Please input values message"
4) Added to the `equip_loss` table a row (day(1), (all other attributes)(0)) so people could query day 2 daily loss  
&nbsp;\
![image](https://github.com/KirstenMayland/cs61databases/assets/102620915/442892cd-9e5a-4ee7-be17-1314b7791d13)  
  
#### Hour 9.75
Created a working button, which when pressed, writes its name into the attribute input box  
&nbsp;\
![Screenshot (53)](https://github.com/KirstenMayland/cs61databases/assets/102620915/02110dd1-a917-404a-a863-0bdf9aaf59b7)

#### Hour 11.25
Finally found the two API's I needed to make more than one button work (`.querySelectorAll` and `.currentTarget`) and consequently learned that javascript is a target language  
&nbsp;\
![Screenshot (50)](https://github.com/KirstenMayland/cs61databases/assets/102620915/9712bc76-282e-4195-b347-017509ccdd84)

#### Hour 12
Placed the two fieldsets next to each other instead of on top of each other (discovered and implemented flex boxes) and fixed residual text indent error. Finally finished task 5  
5) Create a list of possible query options, maybe a click instead of type?  
&nbsp;\
<img width="960" alt="Screenshot 2023-08-29 015005" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/831448a2-ba3d-4772-b7ac-24be18ba705d">

#### Hour 15
Writing documentation

#### Hour 17
Queries

#### Hour 19
Realized while working on the queries that a `vehicles_and_ft_analysis` was not fully normalized, so fixed that and updated [DESIGN.md](DESIGN.md) and [IMPLEMENTATION.md](IMPLEMENTATION.md) pages to match
