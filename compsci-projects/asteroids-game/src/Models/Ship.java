package Models;

import javafx.geometry.Point2D;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;

/* *****************************************
* Asteroids Game Side Project
* Spring 2017
*
*
* Date: May 2, 2017
* Time: 11:10:26 PM
*
* Project: asteroids-game
* Package: Models
* File: Ship
* Description: Asteroids Game
*
* ****************************************
 */
/**
 *
 * @author Dylan
 */
public class Ship extends GamePiece {

    private double acc = 1;
    private Pane thePane;
    /**
     * How much of the super meter the ship has
     */
    private int superMeter = 0;

    public Ship(ImageView image) {
        super(image);
    }

    /**
     * Moves the ship based on its current acceleration and rotation.
     *
     */
    public void move() {
        double x = Math.sin(Math.toRadians(this.getView().getRotate()));
        //System.out.println(y);
        double y = - 1 * Math.cos(Math.toRadians(this.getView().getRotate()));
        this.setVelocity(new Point2D(x * .8, y * .8)
        );
        //System.out.println(velocity.getX());
        this.xPos = xPos + acc * velocity.getX();
        this.yPos = yPos + acc * velocity.getY();
        if (xPos <= 0) {
            xPos = thePane.getWidth() - 1;
        }
        if (yPos <= 0) {
            yPos = thePane.getHeight() - 1;
        }
        xPos %= (thePane.getWidth());
        yPos %= (thePane.getHeight());
        if (acc <= 7) {
            acc += .17;
        }
        this.updateUI();
        imageView.setFocusTraversable(true);
    }

    /**
     * Keeps the ship moving while decelerating to give frictionless feeling
     *
     */
    public void keepMoving() {
        this.xPos = xPos + acc * velocity.getX();
        this.yPos = yPos + acc * velocity.getY();
        if (xPos <= 0) {
            xPos = thePane.getWidth() - 1;
        }
        if (yPos <= 0) {
            yPos = thePane.getHeight() - 1;
        }
        xPos %= (thePane.getWidth());
        yPos %= (thePane.getHeight());
        this.updateUI();
        imageView.setFocusTraversable(true);
    }

    /**
     * Decreases the acc of the ship
     */
    public void slowDown() {
        if (this.acc >= 0) {
            this.acc -= .06;
        }
        this.updateUI();
        imageView.setFocusTraversable(true);
    }

    /**
     * Resets the acc back to 1
     */
    public void resetAcc() {
        this.acc = 1.0;
    }

    /**
     * Instantiates a new Bullet object and gives it the position of the ship
     *
     * @return bullet - the Bullet object
     */
    public Bullet shoot() {
        double x = this.getDirectionX();
        double y = this.getDirectionY();
        ImageView imgv = new ImageView();
        imgv.setImage(
                new Image("newBullet.png", 20, 20, true, true));
        //imgv.setRotate(ship.getRotate());
        Bullet bullet = new Bullet(imgv);
        bullet.setVelocity(new Point2D(x * 3, y * 3));
        bullet.setXPos(
                xPos + this.imageView.getFitWidth() / 2.1);
        bullet.setYPos(
                this.getYPos());
        bullet.getView().relocate(xPos, yPos);
        bullet.setPane(thePane);
        return bullet;
    }

    public int getSuperMeter() {
        return superMeter;
    }

    /**
     * Adds superNum to superMeter. If superMeter is greater than 100, resets it
     * back to 100
     *
     * @param superNum
     */
    public void incrementSuperMeter(int superNum) {
        if (superMeter < 100) {
            superMeter += superNum;
        }
        if (superMeter > 100) {
            superMeter = 100;
        }
    }

    /**
     * Resets the superMeter back to 0
     */
    public void useSuper() {
        superMeter = 0;
    }

    public double getAcc() {
        return this.acc;
    }

    public void setPane(Pane pane) {
        thePane = pane;
    }
}
