import 'package:angular/angular.dart';
import 'dart:html';

@NgController(selector: '[meal-list]', publishAs: 'MealCtrl')
class MealController {
    
    // MealCtrl 's attributes  
    String moment='';
    List<Meal> meals;
 
    // construcutor
    MealController() {
        // init sample data-set of meals
        meals = [
          new Meal(1, 'Rice congee', 30, 'rice-congee.jpg', "love", "morning"),
          new Meal(2, 'Omelet on rice', 20, 'omelet-on-rice.jpg', "hungry", "evening"),
          new Meal(3, 'Thai fried rice', 35, 'thai-fried-rice.jpg', "confuse", "lunch"),
          new Meal(4, 'Chicken rice', 40, 'chicken-rice.jpg', "love", "evening"),
          new Meal(5, 'Noodles pad Thai', 45, 'noodles-pad-thai.jpg', "confuse", "night"),
          new Meal(6, 'Boat noodles', 25, 'boat-noodles.jpg', "hungry", "night"),
          new Meal(7, 'Green curry', 60, 'green-curry.jpg', "confuse", "morning"),
          new Meal(8, 'Massaman curry', 80, 'massaman-curry.jpg', "love", "lunch"),
          new Meal(9, 'Bitter melon soup', 40, 'bitter-melon-soup.jpg', "hungry", "lunch")
        ];
        // shuffle sample data-set
        meals.shuffle();
  }
}
 
// Meal class
class Meal {
    
      // Meal (object)'s attributes
      int id;  
      String name;
      int price;
      String image;
      String verb;
      String time;
     
      // construcutor
      Meal(this.id, this.name, this.price, this.image, this.verb, this.time);
}

@NgFilter(name: 'preferredprice')
class PreferredPrice {
    call(price){
        if(price is num){
            // meanual check preferred price
            if(price <= 30){
                return '*preferred price! just ' + price.toString() + 'Baht';
            }
        }
        return price.toString() + 'Baht';
    }
}

@NgFilter(name: 'preferredtime')
class PreferredTime {
    // receive meal.name and meal.time
    call(meal, time){
        DateTime now = new DateTime.now();
        int hour = now.hour;
        // check meal time using manual hours conditions
        if(hour >= 5 && hour <= 9){
            if(time == 'morning') return meal + ' *preferred time!';
        }else if(hour >= 11 && hour <= 14){
            if(time == 'lunch') return meal + ' *preferred time!';
        }else if(hour >= 17 && hour <= 22){
            if(time == 'evening') return meal + ' *preferred time!';
        }else if(hour >= 23 && hour <= 2){
            if(time == 'night') return meal + ' *preferred time!';
        }
        return meal;
    }
}

@NgDirective(selector: 'input[type=text][words-token]')
class WordsTokens {
    // input element
    var input;
    
    // constructor
    WordsTokens(Element this.input){
        // keyup event listening
        input.onKeyUp.listen((_) => tokenizer());
    }
    
    // method: tokenizer
    void  tokenizer(){
        String moment = input.value;
        List<String> words = moment.split(" ");
        // To-Do find verbs
        
        // test hard-code
        if(words.contains('love')){
            List<Element> eles =  querySelectorAll('.love');
            for(Element ele in eles){
                ele.setAttribute('style', 'color:#c0392b;font-weight:400;');
            }
        }else if(words.contains('hungry')){
            List<Element> eles =  querySelectorAll('.hungry');
            for(Element ele in eles){
                ele.setAttribute('style', 'color:#2980b9;font-weight:400;');
            } 
        }else if(words.contains('confuse')){
            List<Element> eles =  querySelectorAll('.confuse');
            for(Element ele in eles){
                ele.setAttribute('style', 'color:#d35400;font-weight:400;');
            } 
        }else{
            List<Element> eles =  querySelectorAll('.v');
            for(Element ele in eles){
                ele.setAttribute('style', 'color:black;font-weight:300;');
            }   
        }
    }
}
 
// create a module called AppModule
class AppModule extends Module {
    
    // constructor
    AppModule() {
        // create set of types for binding and injecting
        type(MealController);
        type(PreferredPrice);
        type(PreferredTime);
        type(WordsTokens);
    }
}

// method: main 
main() {
  // run angulardart 's bootstrap with registerred module
  ngBootstrap(module: new AppModule());
}