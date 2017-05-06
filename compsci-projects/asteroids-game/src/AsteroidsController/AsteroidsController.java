/* *****************************************
* Asteroids Game Side Project
* Spring 2017
*
*
* Date: May 2, 2017
* Time: 11:53:10 PM
*
* Project: asteroids-game
* Package: AsteroidController
* File: AstroidController
* Description: Asteroids Game
*
* ****************************************
 */
package AsteroidsController;

import AsteroidsView.AsteroidsGameView;
import Models.Asteroid;
import Models.Bullet;
import Models.GamePiece;
import Models.Ship;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;
import javafx.concurrent.Task;
import javafx.event.EventHandler;
import javafx.event.EventType;
import javafx.geometry.Point2D;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.Pane;

/**
 *
 * @author Dylan
 */
public class AsteroidsController implements EventHandler<KeyEvent>{
    
    private ArrayList<Asteroid> asteroids = new ArrayList<>();
    private ArrayList<Bullet> bullets = new ArrayList<>();
    private boolean shoot;
    private boolean right;
    private boolean up;
    private boolean left;
    private Ship ship;
    private AsteroidsGameView theView;
    private Thread th;
    private boolean gameOn = true;
    private int[] sizes = {40, 100, 130};
    private int maxAsteroids = 7;
    private int score = 0;
    private AsteroidsController ctrl = this;
   
    
    public void onUpdate() {
        if(gameOn == false) {
            for(Asteroid a : asteroids) {
                theView.getPane().getChildren().remove(a.getView());
            }
            for(Bullet b : bullets) {
                theView.getPane().getChildren().remove(b.getView());
            }
            asteroids.clear();
            bullets.clear();
            
            
        }
        else{
        for(Asteroid a: asteroids){
           
            if(!theView.getPane().getChildren().contains(a.getView())){
                theView.getPane().getChildren().add(a.getView());
                a.setPane(theView.getPane());
            }
            a.update();
            if(a.isColliding(ship)) {
                gameOver();
                break;
            }
            for(Bullet b: bullets) {
                b.update();
                if(b.isColliding(a)){
                    score += 100;
                    theView.getScoreLabel().setText("Score: " + score);
                    b.setAlive(false);
                    a.setAlive(false);
                    theView.getPane().getChildren().remove(b.getView());
                    theView.getPane().getChildren().remove(a.getView());
                }
                
            }
        }
        asteroids.removeIf(GamePiece::isNotAlive);
        bullets.removeIf(GamePiece::isNotAlive);
        
        
        
        if (up) {
            ship.move();
            
        }
        else {
            ship.slowDown();
            ship.keepMoving();
        }
        if (right) {
            ship.rotateRight();
            
        }
        else if (left) {
            ship.rotateLeft();
            
        }
    }
    
    }
    
    public void addAsteroid(Asteroid asteroid){
        asteroids.add(asteroid);
        asteroid.getView().setX(asteroid.getXPos());
        asteroid.getView().setY(asteroid.getYPos());
    }
    public void instatiateShip(Ship theShip) {
        ship = theShip;
    }

    private void addBullet(Bullet bullet) {
        bullets.add(bullet);
        addPiece(bullet);
    }
    /**
     * Handler for different key presses that moves the Ship, shoots a bullet,
     * or uses the super
     *
     * @param event - the KeyEvent
     */
    @Override
    public void handle(KeyEvent event) { //add if collisionCheck fire button is pressed with another button
        if (event.getEventType() == KeyEvent.KEY_PRESSED) {
            if (event.getCode() == KeyCode.SPACE) {
                if (!shoot) {
                    shoot = true;
                    addBullet(ship.shoot());
                }
            }
            if (event.getCode() == KeyCode.RIGHT) {
                right = true;
            }
            if (event.getCode() == KeyCode.UP) {
                
                if (!up) {
                    ship.resetAcc();
                }
                up = true;
            }
            if (event.getCode() == KeyCode.LEFT) {
                left = true;
            }
            
            
        }
        else if (event.getEventType() == KeyEvent.KEY_RELEASED) {
            if (event.getCode() == KeyCode.UP) {
                up = false;
            }
            if (event.getCode() == KeyCode.RIGHT) {
                right = false;
            }
            if (event.getCode() == KeyCode.LEFT) {
                left = false;
            }
            if (event.getCode() == KeyCode.SPACE) {
                shoot = false;
            }
        }
    }

    
        /**
     * Adds a GamePiece object to the screen
     *
     * @param piece - the GamePiece to be added
     */
    public void addPiece(GamePiece piece) {
        
        piece.getView().setX(piece.getXPos());
        piece.getView().setY(piece.getYPos());
        theView.getPane().getChildren().add(piece.getView());
        
        
        
    }
    
    public void gameOver() {
        gameOn = false;
    }
    
    public void setView(AsteroidsGameView view){
        theView = view;
    }
    
    
      /**
     * Called from a task, generates new Asteroid objects
     */
    public void generateAsteroids() {
        th = new Thread(task);
        th.setDaemon(true);
        th.start();
        

    }
    Task<Void> task = new Task<Void>() {
        @Override
        protected Void call() throws Exception {

            while (gameOn) {
                

//                if (asteroids.size() > 70) { //Make it a max asteroids that collisionCheck number goes up as you play longer
//                    continue;
//                }
                if (score % 1000 == 0 && score != 0 && maxAsteroids < 17) {
                    score += 100;
                    maxAsteroids += 4;
                }
                if (score % 1500 == 0 && score != 0) {
                    ImageView img = new ImageView();
                    img.setImage(new Image("Dancy.png", 250, 200, true, true));
                    Asteroid a = new Asteroid(img);
                    a.setImageFile("Dancy.png");
                    a.setXPos(0);
                    a.setYPos((Math.random() * (theView.getPane().getHeight() + 1)));
                    double xv = Math.sin(Math.toRadians(
                            Math.random() * 110 + 1));
                    double yv = -1 * Math.cos(
                            Math.toRadians(Math.random() * 110 + 1));
                    a.setVelocity(new Point2D(xv * 2.5, yv * 2.5));
                    addAsteroid(a);
                    score += 100;
                }
                if (score % 2000 == 0 && score != 0) {
                    ImageView img = new ImageView();
                    img.setImage(new Image("ben.png", 250, 200, true, true));
                    Asteroid a = new Asteroid(img);
                    a.setImageFile("ben.png");
                    a.setXPos(0);
                    a.setYPos((Math.random() * (theView.getPane().getHeight() + 1)));
                    double xv = Math.sin(Math.toRadians(
                            Math.random() * 110 + 1));
                    double yv = -1 * Math.cos(
                            Math.toRadians(Math.random() * 110 + 1));
                    a.setVelocity(new Point2D(xv * 2.5, yv * 2.5));
                    addAsteroid(a);
                    score += 100;
                }
                
                if (Math.random() < 0.09 && asteroids.size() < maxAsteroids) {
                    
                    Random generator = new Random();
                    int i = generator.nextInt(sizes.length);
                    int size = sizes[i];
                    ImageView imgv = new ImageView();
                    imgv.setImage(
                            new Image("newAsteroid.png", size, size, true, true));
                    

                    Asteroid a = new Asteroid(imgv);
                    a.setPane(theView.getPane());
               
                    double x = Math.random();
                    
                    
                    if (x <= 0.25) {
                       
                        a.setXPos(0);
                        a.setYPos((Math.random() * (theView.getPane().getHeight() + 1)));
                        double xv = Math.sin(Math.toRadians(
                                Math.random() * 110 + 1));
                        double yv = -1 * Math.cos(
                                Math.toRadians(Math.random() * 110 + 1));
                        a.setVelocity(new Point2D(xv * 1.3, yv * 1.3));
                        
                    }
                    else if (x > .25 && x <= .5) {
                        a.setXPos(1200);
                        a.setYPos((Math.random() * (theView.getPane().getHeight() + 1)));
                        double xv = Math.sin(Math.toRadians(
                                Math.random() * -110 - 1));
                        double yv = -1 * Math.cos(
                                Math.toRadians(Math.random() * 110 + 1));
                        a.setVelocity(new Point2D(xv * 1.4, yv * 1.4));
                    }
                    else if (x > .5 && x <= .75) {
                        a.setYPos(0);
                        a.setXPos((Math.random() * (theView.getPane().getWidth() + 1)));
                        double xv = Math.sin(Math.toRadians(
                                Math.random() * 110 + 1));
                        double yv = -1 * Math.cos(
                                Math.toRadians(Math.random() * -110 - 1));
                        a.setVelocity(new Point2D(xv * 1.3, yv * 1.3));
                    }
                    else {
                        a.setYPos(700);
                        a.setXPos((Math.random() * (theView.getPane().getWidth() + 1)));
                        double xv = Math.sin(Math.toRadians(
                                Math.random() * -110 - 1));
                        double yv = -1 * Math.cos(
                                Math.toRadians(Math.random() * 110 + 1));
                        a.setVelocity(new Point2D(xv * 1.1, yv * 1.1));
                    }
                    
                    a.setImageFile("newAsteroid.png");
                    addAsteroid(a);
                    
                    
                }
            }
        
           

            return null;
    }
    };


    
}
