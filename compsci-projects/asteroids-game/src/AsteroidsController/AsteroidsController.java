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

import Models.Asteroid;
import Models.Bullet;
import Models.GamePiece;
import Models.Ship;

import java.util.ArrayList;
import javafx.event.EventHandler;
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
    private Pane theView;
    
    public void onUpdate() {
        for(Asteroid a: asteroids) {
            a.update();
        }
        for(Bullet b: bullets) {
            b.update();
        }
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
    
    public void addAsteroid(Asteroid asteroid){
        asteroids.add(asteroid);
        addPiece(asteroid);
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
            if (event.getCode() == KeyCode.W) {
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
            if (event.getCode() == KeyCode.W) {
                shoot = false;
            }
        }
    }

    public void instatiateShip(Ship theShip) {
        ship = theShip;
    }

    private void addBullet(Bullet bullet) {
        bullets.add(bullet);
        addPiece(bullet);
    }
    
        /**
     * Adds a GamePiece object to the screen
     *
     * @param piece - the GamePiece to be added
     */
    public void addPiece(GamePiece piece) {
        piece.getView().setX(piece.getXPos());
        piece.getView().setY(piece.getYPos());
        theView.getChildren().add(piece.getView());
        
    }
    
    public void setView(Pane view){
        theView = view;
    }

    
}
