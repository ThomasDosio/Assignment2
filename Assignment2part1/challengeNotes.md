# Challenges and notes #

- Name: Thomas Dosio
- Student ID: s2683470
- Tutorial group: Group 4
- Tutor: Rohit Allen
- Date: 2024-03-10

* [Stewie's sequence: + * - / + * - /](#stewies-sequence-)
* [The absent-minded linguist](#the-absent-minded-linguist-)
* [Hodorize a String](#hodorize-a-string-)
* [Superstitious hotel elevator](#superstitious-hotel-elevator-)
* [The code-golfer way of searching a library](#the-code-golfer-way-of-searching-a-library-)
* [Calculate the day number of the year](#calculate-the-day-number-of-the-year-)
* [The struggling college student's GPA Calculator](#the-struggling-college-students-gpa-calculator-)
* [Rotate every row and column in a matrix](#rotate-every-row-and-column-in-a-matrix-)


## Stewie's sequence ##

[Stewie's sequence: + * - / + * - /](https://codegolf.stackexchange.com/questions/101145/stewies-sequence "Stewie's sequence")

### Initial thoughts and feelings ###

This is an interesting challeghe but I would rather use Haskell to solve it. My two designs are both quite basic.

### Initial idea for a design ###

For loop and print at the end. Have a funtion that returns the operator we want to use with mod 4.

### Ideas for alternative designs ###

Use the same operator function but use an arraylist and print that.

### Later thoughts and feelings ###

My two designs are both quite basic.

## The absent-minded linguist ##

[The absent-minded linguist](https://codegolf.stackexchange.com/questions/69084/the-absent-minded-linguist "The absent-minded linguist")

### Initial thoughts and feelings ###

This is a challneg I would have to think about how to solve.

### Initial idea for a design ###

Work through the string checking for each string if every sentence is valid

### Ideas for alternative designs ###

Make a list of all the possible string splits and only pick the valid ones. Then check if those satisfy certain conditions.

### Later thoughts and feelings ###

This can be explained well in a diagram

## Hodorize a String ##

[Hodorize a String](https://codegolf.stackexchange.com/questions/48907/hodorize-a-string "Hodorize a String")

### Initial thoughts and feelings ###

It seems relatively straightforward, I imgaine the codegolf solutions will be quite good for this.

### Initial idea for a design ###

Join the strings and use ifs to avoid the caveats.

### Ideas for alternative designs ###

Have one function that returns the right punctuation for mod 4 instead of 4 separate ifs.

### Later thoughts and feelings ###

This looks like it won't be very fun to make 

## Superstitious hotel elevator ##

[Superstitious hotel elevator](https://codegolf.stackexchange.com/questions/68866/superstitious-hotel-elevator "Superstitious hotel elevator")

### Initial thoughts and feelings ###

This looks doable. 

### Initial idea for a design ###

Use ifs to remove the forbidden characters

### Ideas for alternative designs ###

Make a filter function that takes the list of numbers and removes the charcters we don't want by using tricks (ie every multiple of ten summed with 4 has a 4)

### Later thoughts and feelings ###

This isn't as fun as some of the other ones

## The code-golfer way of searching a library ##

[The code-golfer way of searching a library](https://codegolf.stackexchange.com/questions/118128/the-code-golfer-way-of-searching-a-library "The code-golfer way of searching a library")

### Initial thoughts and feelings ###

I have no initial ideas on how to solve this.

### Initial idea for a design ###

Maybe I could write an algorithm that gives the first two characters as the instructions did unless it contains punctuation, in which case out that or if ti starts with the

### Ideas for alternative designs ###

Create a function that makes all the possible substrings and then checks if one is shorter than the others and selects that. 

### Later thoughts and feelings ###

I think this is above my level for now. 

## Calculate the day number of the year ##

[Calculate the day number of the year](https://codegolf.stackexchange.com/questions/70400/calculate-the-day-number-of-the-year "Calculate the day number of the year")

### Initial thoughts and feelings ###

This is quite fun but can be done better by the built ins so it's not that fun or reusable.

### Initial idea for a design ###

Set up an int associated with each month which is the number of days before the start of that month and then add the day of the month to that.

### Ideas for alternative designs ###

Work through the year and sum how many days until the date matches usign a loop with an iterator that increases and is then returned.

### Later thoughts and feelings ###

The other challenges are more interesting.

## The struggling college student's GPA Calculator ##

[The struggling college student's GPA Calculator](https://codegolf.stackexchange.com/questions/150370/the-struggling-college-students-gpa-calculator "The struggling college student's GPA Calculator")

### Initial thoughts and feelings ###

This is an easy challenge

### Initial idea for a design ###

Read inputs and then convert letter to number and calculated weighted average

### Ideas for alternative designs ###

I really can't think of a different way of doing this, its too basic. Maybe a different way of handling input 

### Later thoughts and feelings ###

I can't think of how I could use this to teach a beginner

## Rotate every row and column in a matrix ##

[Rotate every row and column in a matrix](https://codegolf.stackexchange.com/questions/74900/rotate-every-row-and-column-in-a-matrix "Rotate every row and column in a matrix")

### Initial thoughts and feelings ###

This seems like a fun challenge

### Initial idea for a design ###

Make a function that rotates a row or a column by an int and then apply the function for each integer on the list

### Ideas for alternative designs ###

Just make one function for rotating a row and then after every number rotate the rows up by one and transpose if necessary.

### Later thoughts and feelings ###

This would be fun to do but I prefer the other ones and I feel it's not that useful for teaching beginners

<STYLE>
* { /* Don't leave any empty lines or IntelliJ might not render correctly */
  /* Text size */
  font-size:   1.1rem;
  /*font-size:   1.2rem;*/
  /* Zenburn dark theme */
  background-color: #2A252A;
  color:            #D5DAD5;
  /* One Dark theme */
  /*background-color: #282C34;
  color:            #ABB2BF;*/
  /* white-ish on dull blue-ish */
  /*background-color: DarkSlateGray;
    color:            AntiqueWhite;*/
  /* white on black */
  /*background-color: black;
  color: white;*/
  /* black on white */
  /*background-color: white;
  color: black;*/
  /* nearly black on bright yellow */
  /*background-color: #FFFFAA;
  color:            #080808;*/
  /* black on bright blue */  
  /*background-color: #99CCFF;
  color:            black;*/
}
body {
  /* width of the text column */
  width: 80%;
  /* line spacing */
  line-height: 180%;
  /*line-height: 200%;*/
  /* Font styles: */
  /* Default sans serif */
  /*font-family: sans-serif;*/
  /* Default serif */
  font-family: serif;
  /* Specific font with generic fall-back */
  /* font-family: "Calibri Light", sans-serif; */
  /*font-family: "OpenDyslexic", sans-serif;*/
}
pre,
code,
pre code {
  /* line spacing */
  line-height: 150%;
  /* Default monospace */
  font-family: monospace;
  /* Specific fixed-width font with generic fall-back */
  /*font-family: "Consolas", monospace;*/
  /*font-family: "OpenDyslexicMono", monospace;*/
}
ol,
ol ol,
ol ol ol { /* Nested lists all use decimal numbering */
  list-style-type: decimal;
}
em {
  /* if you want underlining instead of italics */
  /*font-style: normal;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  padding-bottom:      2px;*/
  text-decoration-skip-ink: auto;
}
h2 { /* Put a horizontal line above major headings to assist screen viewing */
  border-top:  1px solid #D5DAD5;
  margin-top:  80px;
  padding-top: 20px;
  }
</STYLE>