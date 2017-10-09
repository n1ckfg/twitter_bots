/*
 * Press the mouse to post the current frame to Twitter
 * Graphics taken from Processing's RandomBook example
 * Inspired by the earlier tutorial by blprnt
 * See http://twitter4j.org/javadoc/ for in-depth documentation
 */
import gohai.simpletweet.*;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.TwitterException;
import twitter4j.User;

SimpleTweet simpletweet;
ArrayList<Status> tweets;

String cKey, cSecret, aToken, aTokenSecret;
Settings settings;

void setup() {
  size(500, 500);
  settings = new Settings("settings.txt");
  println(cKey);
  println(cSecret);
  println(aToken);
  println(aTokenSecret);
  frameRate(0.5);
  simpletweet = new SimpleTweet(this);

  /*
   * Create a new Twitter app on https://apps.twitter.com/
   * then go to the tab "Keys and Access Tokens"
   * copy the consumer key and secret and fill the values in below
   * click the button to generate the access tokens for your account
   * copy and paste those values as well below
   */
  simpletweet.setOAuthConsumerKey(cKey);
  simpletweet.setOAuthConsumerSecret(cSecret);
  simpletweet.setOAuthAccessToken(aToken);
  simpletweet.setOAuthAccessTokenSecret(aTokenSecret);
  
  tweets = search("#sun");
}

void draw() {
  background(255);
  
  for (int i=0; i<100; i++) {
    float r = random(1.0);
    if(r < 0.2) {
      stroke(255); 
    } else {
      stroke(0); 
    }
    float sw = pow(random(1.0), 12);
    strokeWeight(sw * 260); 
    float x1 = random(-200, -100);
    float x2 = random(width+100, width+200);
    float y1 = random(-100, height+100);
    float y2 = random(-100, height+100);
    line(x1, y1, x2, y2);
  }
  
  Status current = tweets.get(frameCount % tweets.size());
  String message = current.getText();
  User user = current.getUser();
  String username = user.getScreenName();

  fill(0);
  text(message + "by @" + username, 2, (height/2)+2);
  fill(255);
  text(message + "by @" + username, 0, height/2);
}

ArrayList<Status> search(String keyword) {
  // request 100 results
  Query query = new Query(keyword);
  query.setCount(100);

  try {
    QueryResult result = simpletweet.twitter.search(query);
    ArrayList<Status> tweets = (ArrayList)result.getTweets();
    // return an ArrayList of Status objects
   return tweets;
  } catch (TwitterException e) {
    println(e.getMessage());
    return new ArrayList<Status>();
  }
}

void mousePressed() {
  String tweet = simpletweet.tweetImage(get(), "Made with Processing");
  println("Posted " + tweet);
}