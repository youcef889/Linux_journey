+++
date = '2025-08-29T06:26:19+01:00'
draft = false
title = 'Working With Files and Tabs in Vim'
categories =["tutorial","Linux Basics"]
tags=['vim','text editor']
+++

### Into  

What's going on guys youcef here and today we work with files and tabs  in vim .as well as how to open and save files in different ways .

Vim does have tabs just like many other text editors do  and to deal with the tabs we have to use command though as you kow there's no button to just click on to open new tab and the way that we would open new tab in vim .

### Open new tab 

Is of course using a command so we need our `:` from normal mode and the command is `:tabnew ` which will go ahead and open a new  tab to the right of whatever the last tab that you were just  working with was.

### Navigate between tabs

In order to navigate between these tabs so we can do `:tabprevious` to go back to the prevoius tab  and we can do  `:tabnext` to go back to the next tab we can also abbreviate these command  a little bit  by useing `:tabp` and `:tabn`  .
but went you use  this command the name of new tab is **no name** and this is because there isn't actualy any file open here  doesn't actualy have a file name yet .
what if we  start inputting  some text here and then  you want it to save this but you wanted to also be able to give it file name . 

### Save File

well the command to save is ` : write` in order to give it a name we simply have to do is to hit space and then filename  for example `:write filename.txt`
or`:w filename.txt`.    

### Open file in vim 

We are inside of vim we can open up a file from inside of here the command for us to do that is `:edit [filename]`by the way edit can be shortened to just the latter `:e` . to show  all different files in the directory we write `:e [hit tab button] ` and this going to output all of the file that are in that current  directory .

### Multiple  Vim tabs  

If you have open multipe tabs and  you do not went to do  tabp three times in order to do that simplly `: tabfirst ` and this automaticlly jump us back to first tab and the opposite in `:tablast` .

We can move our tabs around as well the command for that is `:tabmove [numbre for where you want it to go]` and  postions start at 0 like in programming.

### Quit vim 

And to quit vim you need only to type`:q` to save and quit `:wq` and quit without saveing `:q!` 

