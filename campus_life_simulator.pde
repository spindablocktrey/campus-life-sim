//images variable
PFont gameFont;
PImage photo;
PImage menuBackground;
PImage tempCharacter1, tempCharacter2;
PImage dormBg, campusBg, libraryBg, commonsBg, racBg;
PImage cursor;


PImage[] maleCharacters, femaleCharacters, nonBinaryCharacters;
PImage selectedCharacterSprite;

PImage[] getCharacterArray() {
  if (selectedGender.equals("Male")) {
    return maleCharacters;
  } else if (selectedGender.equals("Female")) {
    return femaleCharacters;
  } else if (selectedGender.equals("Non-Binary")) {
    return nonBinaryCharacters;
  }
  return new PImage[0];
}


//variables declared

int gameState = 0;
int currentCharacterIndex = 0;

int currentHour = 8; //a day starts at 8 am
int currentDay = 1;
int currentWeek = 1;

int week = 1;
int day = 1;
int time = 9;
boolean gameWon = false;
boolean gameLost = false;





//strings for menu 
String playerName = ""; //tracks the players name

String selectedMajor = ""; //tracks the selected major is, cs, bta

String selectedGender = ""; //tracks the gender

String location = "Campus";

String[][] dormOptionSets = {
  {"Relax", "Sleep", "Study"},
  {"Meditate", "Nap", "Do Homework"},
  {"Watch TV", "Read a Book", "Clean Room"}
};

String[][] commonsOptionSets = {
  {"Eat", "Socialize", "Study"},
  {"Get Coffee", "Meet Friends", "Browse Shops"},
  {"Grab a Snack", "Chat with Peers", "Do Group Study"}
};

String[][] libraryOptionSets = {
  {"Study", "Study with Friends", "Read Books"},
  {"Research", "Practice Coding", "Plan a Project"},
  {"Write a Report", "Borrow a Book", "Use Computer"}
};

String[][] racOptionSets = {
  {"Workout", "Jog", "Play Sports"},
  {"Swim", "Stretch", "Lift Weights"},
  {"Join a Class", "Do Yoga", "Practice Skills"}
};

// Track current set index
int dormOptionIndex = 0;
int commonsOptionIndex = 0;
int libraryOptionIndex = 0;
int racOptionIndex = 0;












void setup() {
  size(700, 500);
  gameFont = createFont("Gameplay.ttf", 16);
  textFont(gameFont);
  photo = loadImage("jpeg2000ex.jpg"); //temp game bg image
  menuBackground = loadImage("jpeg2000ex.jpg"); //temp main menu bg image
  dormBg = loadImage("dorm.jpg");
  commonsBg = loadImage("lunch.jpg");
  libraryBg = loadImage("library.jpg");
  racBg = loadImage("rac.jpg");
  campusBg = loadImage("campus.jpg");
  cursor = loadImage("cursor.png");
  noCursor();
  
  
  //can add more characters by increasing the array size of the characters below
  maleCharacters = new PImage[4];
  femaleCharacters = new PImage[4];
  nonBinaryCharacters = new PImage[4];
  
  maleCharacters[0] = loadImage("guymenu.png"); //tempcharacter currently a placeholder
  maleCharacters[1] = loadImage("guymenu2.png"); //placeholder
  maleCharacters[2] = loadImage("guymenu3.png");
  maleCharacters[3] = loadImage("guymenu4.png");
  
  femaleCharacters[0] = loadImage("girlmenu3.png"); //placeholder
  femaleCharacters[1] = loadImage("girlmenu2.png"); //placeholder
  femaleCharacters[2] = loadImage("girlmenu4.png");
  femaleCharacters[3] = loadImage("girlmenu5.png");
  
  nonBinaryCharacters[0] = loadImage("nbmenu.png"); //placeholder
  nonBinaryCharacters[1] = loadImage("nbmenu2.png"); //placeholder
  nonBinaryCharacters[2] = loadImage("nbmenu3.png"); //placeholder
  nonBinaryCharacters[3] = loadImage("nbmenu4.png"); //placeholder

}


void draw() {
  if (gameState == 0) {
    drawMenu(); 
  } else if (gameState == 1) {
    drawMajor();
  } else if (gameState == 2) {
    drawGenderSelection();
  } else if (gameState == 3) {
    drawGameScreen();
  } else if (gameState == 4) {
    drawCharacterChoosing();
  } else if (gameState == 5) {
    drawDormLocation();
  } else if (gameState == 6) {
    drawCommonsLocation();
  } else if (gameState == 7) {
    drawLibraryLocation();
  } else if (gameState == 8) {
    drawRACLocation();
  } else if (gameState == 9) {
  drawLoseScreen("your grades reached 0");
} else if (gameState == 10) {
  drawLoseScreen("your happiness reached 0");
} else if (gameState == 11) {
  drawLoseScreen("your money reached 0");
} else if (gameState == 12) {
  drawWinScreen();
}
    
    //draw for rest of the stuff
    image(cursor, mouseX, mouseY, 32, 32);
  } 


void drawGameScreen() {
  image(campusBg, 0, 0, width, height); // Display the campus background
  drawUI(); // Display the UI elements
  drawBottomPanel(); // Display the location buttons
   
   
   
   fill(30);
   rect(width - 150, 0, 150, height); //black sidebar
   drawBars();
    
  
   
   //variables for the option button size
   int optionX = width - 140;
   int optionStartY = 200;
   int optionWidth = 120;
   int optionHeight = 30;
   int optionSpacing = 50;
   
   //options shape
   fill(255);
   textSize(9.2);
   String[] options = {"Go to the Library", "Relax at your Dorm", "Study for a Test"};
   
   for (int i = 0; i < options.length; i++) {
     fill(50);
     rect(optionX, optionStartY + i * optionSpacing, optionWidth, optionHeight, 8);
     
     //text for options
     fill(255);
     textAlign(CENTER, CENTER);
     text(options[i], optionX + optionWidth / 2, optionStartY + i * optionSpacing + optionHeight / 2);
   }
   
  
   

   if (gameState == 5) location = "Dorm";
   else if (gameState == 6) location = "Commons";
   else if (gameState == 7) location = "Library";
   else if (gameState == 8) location = "RAC";
   
   drawBottomPanel();
}



void drawBottomPanel() {
  fill(50);
  rect(0, height - 80, width, 80);
  
  int buttonWidth = 120;
  int buttonHeight = 40;
  int spacing = 20;
  int startX = (width - (4 * buttonWidth + 3 * spacing)) / 2;
  int startY = height - 60;
  
  
  textSize(12);
  textAlign(CENTER, CENTER);
  
  //dorm button
  fill(173, 216, 230);
  rect(startX, startY, buttonWidth, buttonHeight, 8);
  fill(0);
  text("Dorm", startX + buttonWidth / 2, startY + buttonHeight / 2);
  
  //commons button
  fill(255, 228, 181);
  rect(startX + buttonWidth + spacing, startY, buttonWidth, buttonHeight, 8);
  fill(0);
  text("Commons", startX + buttonWidth + spacing + buttonWidth / 2, startY + buttonHeight / 2);
  
  //library button
  fill(144, 238, 144);
  rect(startX + 2 * (buttonWidth + spacing), startY, buttonWidth, buttonHeight, 8);
  fill(0);
  text("Library", startX + 2 * (buttonWidth + spacing) + buttonWidth / 2, startY + buttonHeight / 2);
  
  //rac button
  fill(255, 192, 203);
  rect(startX + 3 * (buttonWidth + spacing), startY, buttonWidth, buttonHeight, 8);
  fill(0);
  text("RAC", startX + 3 * (buttonWidth + spacing) + buttonWidth / 2, startY + buttonHeight / 2);
}






//draw the background for the gamescreen
void drawScreen() {
  image(photo, 0, 0, width, height); //gamestate 3 screen background temp bg
}


  int grades = 100;
  int happiness = 100;
  int money = 100;

void drawBars() {
 
  int barWidth = 120;
  int barHeight = 20;
  int startX = width - 150;
  int startY = 40;
  int spacing = 40;
  int cornerRadius = 5;
  
  textAlign(CENTER, BOTTOM);
  textSize(8);
  fill(255);
  
  
  //grade bar
 text("Grade", startX + barWidth / 2, startY - 5);
 fill(30);
 rect(startX, startY, barWidth, barHeight, cornerRadius);
 fill(116, 250, 162);
 rect(startX, startY, grades * barWidth / 100, barHeight, cornerRadius);
  
  //happiness bar
  fill(255);
  text("Happiness", startX + barWidth / 2, startY + spacing - 5);
  fill(30);
  rect(startX, startY + spacing, barWidth, barHeight, cornerRadius);
  fill(232, 193, 143);
  rect(startX, startY + spacing, happiness * barWidth / 100, barHeight, cornerRadius);
  
  //money bar
  fill(255);
  text("Money", startX + barWidth / 2, startY + 2 * spacing - 5);
  fill(30);
  rect(startX, startY + 2 * spacing, barWidth, barHeight, cornerRadius);
  fill(153, 143, 252);
  rect(startX, startY + 2 * spacing, money * barWidth / 100, barHeight, cornerRadius); 
}


void drawUI() {
  // Top bar with location, time, week, and day
  fill(220);
  rect(width / 2 - 150, 10, 300, 40);
  fill(0);
  textSize(12);
  textAlign(CENTER, CENTER);
  text("Location: " + location + " | Time: " + time + ":00 | Day: " + day + " | Week: " + week, width / 2, 25);

  // Right panel with bars
  fill(30);
  rect(width - 150, 0, 150, height);
  drawBars();

  // Bottom panel with location buttons
  drawBottomPanel();

}


String formatTime(int hour) {
  if (hour == 12) return hour + " PM";
  if (hour > 12) return (hour - 12) + " PM";
  return hour + " AM";
}


void progressTime(int hoursSpent) {
  currentHour += hoursSpent;

  // Move to next day if past 24 hours
  if (currentHour >= 12) {
    currentHour = 8;  // Reset to 8 AM
    currentDay++;
    
    // Cycle through option sets
    dormOptionIndex = (dormOptionIndex + 1) % dormOptionSets.length;
    commonsOptionIndex = (commonsOptionIndex + 1) % commonsOptionSets.length;
    libraryOptionIndex = (libraryOptionIndex + 1) % libraryOptionSets.length;
    racOptionIndex = (racOptionIndex + 1) % racOptionSets.length;
  }

  // Move to next week if 7 days pass
  if (currentDay > 7) {
    currentDay = 1;  // Reset to Day 1
    currentWeek++;
  }

  // Check for end of game (Week 16)
  if (currentWeek == 16) {
    gameState = 12; // Win screen
  }
}
























//beginning of the game starting with the menu 
//everything else falls down in order of screens
void drawMenu() {
  background(0);
  textAlign(CENTER, CENTER);
  //game title 
  textSize(30); 
  fill(255);
  text("Campus Life Simulator", width / 2, height / 3);
  textSize(20); 
  text("Created by College Innovators", width / 2, height / 2);

  //begin button
  fill(0, 255, 0);
  rect(width / 2 - 75, height / 2 + 50, 150, 50);
  fill(0);
  textSize(15);
  text("Begin", width / 2, height / 2 + 75);
}


void drawMajor() {
  background(0);
  textAlign(CENTER, CENTER);
  
  textSize(20);
  fill(255);
  text("Choose Your Major", width / 2, height / 4);
  
  textSize(18);
  // is major
  fill(0,255,0);
  rect(width / 2 - 150, height / 2 - 50, 120, 50);
  fill(0);
  text("IS", width / 2 - 90, height / 2 - 25);
  
  //cs major 
  fill(0, 0, 255);
  rect(width / 2 - 20, height / 2 - 50, 120, 50); 
  fill(0);
  text("CS", width / 2 + 40, height / 2 - 25);

  //bta major
  fill(255, 165, 0);
  rect(width / 2 + 110, height / 2 - 50, 120, 50); 
  fill(0);
  text("BTA", width / 2 + 170, height / 2 - 25);
}


void drawGenderSelection() {
  background(0);
  textAlign(CENTER, CENTER);
  
  textSize(28);
  fill(255);
  text("Character Selection", width / 2, height / 5);
  
  
  //name input
  textSize(14);
  //prompt to enter name
  text("Enter Your Name:", width / 2, height / 3);
  fill(255);
  //input box 
  rect(width / 2 - 100, height / 3 + 30, 200, 40, 8);
  
  fill(0);
  text(playerName, width / 2, height / 3 + 50);
  
  
  //male button
  fill(0, 0, 255);
  rect(width / 2 - 170, height / 2, 100, 50);
  fill(255);
  text("Male", width / 2 - 120, height / 2 + 25);
  
  //female button
  fill(240, 24, 226);
  rect(width / 2 + 70, height / 2, 100, 50);
  fill(255);
  text("Female", width / 2 + 120, height / 2 + 25);
  
  //non binary button
  fill(128, 0, 128);
  rect(width / 2 - 50, height / 2, 100, 50);
  fill(255);
  text("Non-Binary", width / 2 + 1, height / 2 + 25);
 
  
  //selected character 
  fill(255);
  textSize(14);
  text("Selected: " + selectedGender, width / 2, height / 2 + 80);
  
 
  //confirm button  
  fill(0, 255, 0);
  rect(width / 2 - 75, height * 3 / 4, 150, 50);
  fill(255);
  text("Confirm?", width / 2, height * 3 / 4 + 25);
  text("Note: You cannot change your gender, character, or name when you start!", width / 2 - 5, height * 3 / 4 + 85);
}


void drawCharacterChoosing() {
  background(200, 220, 256);
  textAlign(CENTER, CENTER);
  
  textSize(36);
  fill(0);
  text("Choose Your Character", width / 2, height / 5);
  
  //displays the character
  if (selectedGender.equals("Male")) {
    image(maleCharacters[currentCharacterIndex], width / 2 - 75, height / 2 - 100, 150, 200);
  } else if (selectedGender.equals("Female")) {
    image(femaleCharacters[currentCharacterIndex], width / 2 - 75, height / 2 - 100, 150, 200);
  } else if (selectedGender.equals("Non-Binary")) {
    image(nonBinaryCharacters[currentCharacterIndex], width / 2 - 75, height / 2 - 100, 150, 200);
  }

//arrows for navigating through characters
  fill(0);
  textSize(24);
  text("<", width / 2 - 200, height / 2); //left arrow
  text(">", width / 2 + 200, height / 2); //right arrow
  
  //confirm button
  fill(0, 255, 0);
  rect(width / 2 - 75, height * 3 /4, 150, 50);
  fill(0);
  textSize(18);
  text("Confirm", width / 2, height * 3 / 4 + 25);
}



void drawDormLocation() { //draws the dorm screen/location
  image(dormBg, 0, 0, width, height);
  drawUI();
  drawOptions(dormOptionSets[dormOptionIndex]);

}
  


void drawCommonsLocation() { //draws the commons screen/location
  image(commonsBg, 0, 0, width, height);
 drawUI();
 drawOptions(commonsOptionSets[commonsOptionIndex]);
}

void drawLibraryLocation() {
  image(libraryBg, 0, 0, width, height);
  drawUI();
 drawOptions(libraryOptionSets[libraryOptionIndex]);

}

void drawRACLocation() {
  image(racBg, 0, 0, width, height);
 drawUI();
  drawOptions(racOptionSets[racOptionIndex]);
}


void drawOptions(String[] options) {
  int optionX = width - 140;
  int optionY = 200;
  int buttonWidth = 120;
  int buttonHeight = 30;
  int spacing = 20;

  textAlign(CENTER, CENTER);
  textSize(10);

  for (int i = 0; i < options.length; i++) {
    fill(50); // Option button color
    rect(optionX, optionY + i * (buttonHeight + spacing), buttonWidth, buttonHeight, 8);
    fill(255); // Text color
    text(options[i], optionX + buttonWidth / 2, optionY + i * (buttonHeight + spacing) + buttonHeight / 2);
  }
}




void checkGameStatus() {
  if (grades <= 0) {
    gameLost = true;
    gameState = 9; // Lose screen for grades
  } else if (happiness <= 0) {
    gameLost = true;
    gameState = 10; // Lose screen for happiness
  } else if (money <= 0) {
    gameLost = true;
    gameState = 11; // Lose screen for money
  } else if (week > 15) {
    gameWon = true;
    gameState = 12; // Win screen
  }
}


void drawWinScreen() {
  background(0, 255, 0);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Congratulations! You survived 15 weeks!", width / 2, height / 2);
}

void drawLoseScreen(String reason) {
  background(255, 0, 0);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Game Over! You lost because " + reason + ".", width / 2, height / 2);
}









void mousePressed() {
  if (gameState == 0) { // Main menu
    if (mouseX > width / 2 - 75 && mouseX < width / 2 + 75 && mouseY > height / 2 + 50 && mouseY < height / 2 + 100) {
      gameState = 1; // Sends user to major selection screen
    }
  } else if (gameState == 1) { // Major selection
    // IS Button
    if (mouseX > width / 2 - 150 && mouseX < width / 2 - 30 && mouseY > height / 2 - 50 && mouseY < height / 2) {
      selectedMajor = "IS";
      gameState = 2;
    }
    // CS Button
    else if (mouseX > width / 2 - 20 && mouseX < width / 2 + 100 && mouseY > height / 2 - 50 && mouseY < height / 2) {
      selectedMajor = "CS";
      gameState = 2;
    }
    // BTA Button
    else if (mouseX > width / 2 + 110 && mouseX < width / 2 + 230 && mouseY > height / 2 - 50 && mouseY < height / 2) {
      selectedMajor = "BTA";
      gameState = 2;
    }
  } else if (gameState == 2) { // Gender selection screen
    // Male button
    if (mouseX > width / 2 - 150 && mouseX < width / 2 - 50 && mouseY > height / 2 && mouseY < height / 2 + 50) {
      selectedGender = "Male";
    }
    // Female button
    else if (mouseX > width / 2 + 50 && mouseX < width / 2 + 150 && mouseY > height / 2 && mouseY < height / 2 + 50) {
      selectedGender = "Female";
    }
    // Non-binary button
    else if (mouseX > width / 2 - 50 && mouseX < width / 2 + 50 && mouseY > height / 2 && mouseY < height / 2 + 50) {
      selectedGender = "Non-Binary";
    }
    // Confirm button
    if (mouseX > width / 2 - 75 && mouseX < width / 2 + 75 && mouseY > height * 3 / 4 && mouseY < height * 3 / 4 + 50) {
      // Load the selected character sprite
      if (selectedGender.equals("Male")) {
        selectedCharacterSprite = maleCharacters[currentCharacterIndex];
      } else if (selectedGender.equals("Female")) {
        selectedCharacterSprite = femaleCharacters[currentCharacterIndex];
      } else if (selectedGender.equals("Non-Binary")) {
        selectedCharacterSprite = nonBinaryCharacters[currentCharacterIndex];
      }
      gameState = 4;
    }
  } else if (gameState == 4) { // Character selection screen
    // Left arrow
    if (mouseX > width / 2 - 200 && mouseX < width / 2 - 180 && mouseY > height / 2 - 20 && mouseY < height / 2 + 20) {
      currentCharacterIndex = (currentCharacterIndex - 1 + getCharacterArray().length) % getCharacterArray().length;
    }
    // Right arrow
    else if (mouseX > width / 2 + 180 && mouseX < width / 2 + 200 && mouseY > height / 2 - 20 && mouseY < height / 2 + 20) {
      currentCharacterIndex = (currentCharacterIndex + 1) % getCharacterArray().length;
    }
    // Confirm button
    else if (mouseX > width / 2 - 75 && mouseX < width / 2 + 75 && mouseY > height * 3 / 4 && mouseY < height * 3 / 4 + 50) {
      if (selectedGender.equals("Male")) {
        selectedCharacterSprite = maleCharacters[currentCharacterIndex];
      } else if (selectedGender.equals("Female")) {
        selectedCharacterSprite = femaleCharacters[currentCharacterIndex];
      } else if (selectedGender.equals("Non-Binary")) {
        selectedCharacterSprite = nonBinaryCharacters[currentCharacterIndex];
      }
      gameState = 3;
    }
  } else if (gameState == 3 || gameState >= 5 && gameState <= 8) { // Game and location screens
    int buttonWidth = 120;
    int buttonHeight = 40;
    int spacing = 20;
    int startX = (width - (4 * buttonWidth + 3 * spacing)) / 2;
    int startY = height - 60;

    // Location buttons
    if (mouseY > startY && mouseY < startY + buttonHeight) {
      if (mouseX > startX && mouseX < startX + buttonWidth) {
        location = "Dorm";
        gameState = 5;
      } else if (mouseX > startX + buttonWidth + spacing && mouseX < startX + 2 * buttonWidth + spacing) {
        location = "Commons";
        gameState = 6;
      } else if (mouseX > startX + 2 * (buttonWidth + spacing) && mouseX < startX + 3 * buttonWidth + 2 * spacing) {
        location = "Library";
        gameState = 7;
      } else if (mouseX > startX + 3 * (buttonWidth + spacing) && mouseX < startX + 4 * buttonWidth + 3 * spacing) {
        location = "RAC";
        gameState = 8;
      }
    }

    // Options buttons
    int optionX = width - 140;
    int optionY = 200;
    int optionWidth = 120;
    int optionHeight = 30;
    int spacingOption = 20;

    for (int i = 0; i < 3; i++) {
      if (mouseX > optionX && mouseX < optionX + optionWidth &&
          mouseY > optionY + i * (optionHeight + spacingOption) && mouseY < optionY + i * (optionHeight + spacingOption) + optionHeight) {
        
        // Example effects on bars
        if (i == 0) { // First option
          grades = max(0, grades - 5); // Decrease grades
          happiness = min(100, happiness + 10); // Increase happiness
          money = max(0, money - 10); // Decrease money
        } else if (i == 1) { // Second option
          grades = min(100, grades + 10); // Increase grades
          happiness = max(0, happiness - 5); // Decrease happiness
          money = max(0, money - 5); // Decrease money
        } else if (i == 2) { // Third option
          grades = max(0, grades - 5);
          happiness = max(0, happiness - 5);
          money = min(100, money + 15);
        }

        // Check for win/lose conditions
        if (grades <= 0 || happiness <= 0 || money <= 0) {
          gameState = 9; // Lose screen
        } else if (week == 15 && day == 7) {
          gameState = 10; // Win screen
        }

        // Progress time
        time += 3; // Example: Each option takes 3 hours
        if (time >= 24) { // Move to next day
          time = 0;
          day++;
          if (day > 7) { // Move to next week
            day = 1;
            week++;
          }
        }
      }
    }
  }
}
void keyPressed() {
  if (gameState == 2) { // Only process letters/numbers in the character selection screen
    if (key != CODED) { // Ignores the arrow keys (key != CODED)
      if (key == BACKSPACE && playerName.length() > 0) {
        playerName = playerName.substring(0, playerName.length() - 1); // Allows backspace to work
      } else if (key != ENTER && playerName.length() < 12 && Character.isLetterOrDigit(key)) {
        playerName += key; // Adds only valid alphanumeric keys
      }
    }
    return; // Prevents any other keys from being processed in this game state
  }

  // Developer keys for testing
  if (key == 'w' || key == 'W') {
    gameState = 12; // Win screen
    println("Developer Key: Win Screen Activated");
  }
  if (key == 'l' || key == 'L') {
    gameState = 9; // Lose screen
    println("Developer Key: Lose Screen Activated");
  }

  // Testing bar values
  if (key == 'g' || key == 'G') {
    grades = 0; // Force grades to 0
    checkGameStatus(); // Ensure the lose condition triggers
    println("Developer Key: Grades set to 0");
  }
  if (key == 'h' || key == 'H') {
    happiness = 0; // Force happiness to 0
    checkGameStatus(); // Ensure the lose condition triggers
    println("Developer Key: Happiness set to 0");
  }
  if (key == 'm' || key == 'M') {
    money = 0; // Force money to 0
    checkGameStatus(); // Ensure the lose condition triggers
    println("Developer Key: Money set to 0");
  }

  // Skip weeks or days
  if (key == 'd' || key == 'D') {
    day++;
    if (day > 7) {
      day = 1;
      week++;
    }
    println("Developer Key: Skipped to next day. Day: " + day + ", Week: " + week);
  }
  if (key == 'k' || key == 'K') {
    week++;
    if (week > 15) {
      week = 15; // Ensure the maximum week is capped at 15
    }
    println("Developer Key: Skipped to next week. Week: " + week);
  }
}
