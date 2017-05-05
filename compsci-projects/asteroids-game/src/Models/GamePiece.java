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
* File: GamePiece
* Description: Asteroids Game
*
* ****************************************
 */
package Models;

/**
 *
 * @author Dylan
 */

import javafx.geometry.Point2D;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;

public class GamePiece {
    protected double width;
    protected double height;
    
    protected Pane thePane;
    /**
     * The x-coordinate of the GamePiece
     */
    protected double xPos;
    /**
     * The y-coordinate of the GamePiece
     */
    protected double yPos;
    /**
     * The image used to represent the GamePiece
     */
    protected Image theImage;
    /**
     * The x component of the velocity
     */
    protected double changeX;
    /**
     * The y-component of the velocity
     */
    protected double changeY;
    /**
     * Node containing the imageView and the coordinates of the
     */
    protected ImageView imageView;
    /**
     * The velocity of the GamePiece
     */
    protected Point2D velocity = new Point2D(0, 0);
    /**
     * Determines whether the GamePiece should be destroyed or not
     */
    protected boolean alive;
    /**
     * The name of the file containing the imageView
     */
    protected String imageFile;
    public GamePiece(ImageView view) {
        //this.imageView = imageView;
        //this.imageView.setViewport(new Rectangle2D(xPos, yPos, width, height));
        //this.getParent().add(imageView);
        this.imageView = view;
        this.theImage = view.getImage();
        alive = true;
    }
    /**
     * Determines whether the GamePiece is colliding with another GamePiece
     * piece
     *
     * @param piece - the other GamePiece used to check for collisions
     * @return true if the two pieces are colliding
     */
    public boolean isColliding(GamePiece piece) {
       return piece.getView().getBoundsInParent().intersects(this.getView().getBoundsInParent());
    }
    /**
     * Updates the x and y positions (xPos / yPos) of the GamePiece
     */
    public void update() {
        this.xPos = xPos + velocity.getX() * 1.2;
        this.yPos = yPos + velocity.getY() * 1.2;
        if (xPos <= 0) {
            xPos = thePane.getWidth() - 1;
        }
        if (yPos <= 0) {
            yPos = thePane.getHeight()- 1;
        }
        xPos %= (thePane.getWidth());
        yPos %= (thePane.getHeight());
        updateUI();
       imageView.setFocusTraversable(true);
        
    }
    /**
     * Updates the image of the GamePiece
     */
    public void updateUI() {
        imageView.setX(xPos);
        imageView.setY(yPos);
        imageView.relocate(xPos, yPos);
    }
    /**
     * Returns the x component of the velocity of the GamePiece
     *
     * @return
     */
    public double getDirectionX() {
        return Math.sin(Math.toRadians(this.getView().getRotate()));
    }
    /**
     * Returns the y component of the velocity of the GamePiece
     *
     * @return
     */
    public double getDirectionY() {
        return -1 * Math.cos(Math.toRadians(this.getView().getRotate()));
    }
    public void setVelocity(Point2D v) {
        this.velocity = v;
    }
    public Point2D getVelocity() {
        return velocity;
    }
    public void setView(ImageView v) {
        this.imageView = v;
    }
    /**
     * Gets the value representing the rotation of the GamePiece
     *
     * @return
     */
    public double getRotate() {
        return imageView.getRotate();
    }
    /**
     * Rotates the GamePiece slightly to the right
     */
    public void rotateRight() {
        imageView.setRotate((imageView.getRotate() + 7) % 360);
    }
    /**
     * Rotates the GamePiece slightly to the left
     */
    public void rotateLeft() {
        imageView.setRotate((360 + (imageView.getRotate() - 7)) % 360);
    }
    public double getPieceWidth() {
        return width;
    }
    public double getPieceHeight() {
        return height;
    }
    public void setPieceWidth(double w) {
        this.width = w;
    }
    public void setPieceHeight(double h) {
        this.height = h;
    }
    public double getXPos() {
        return xPos;
    }
    public double getYPos() {
        return yPos;
    }
    public ImageView getView() {
        return imageView;
    }
    public boolean isAlive() {
        return alive;
    }
    /**
     * Returns true if alive == false and false if alive == true
     *
     * @return !alive
     */
    public boolean isNotAlive() {
        return !alive;
    }
    public void setAlive(boolean aliveOrDead) {
        alive = aliveOrDead;
    }
    public Image getImageView() {
        return theImage;
    }
    /**
     * Sets both the x and y coordinates
     *
     * @param xPos - new x coordinate
     * @param yPos - new y coordinate
     */
    public void setPos(double xPos, double yPos) {
        this.xPos = xPos;
        this.yPos = yPos;
    }
    public void setXPos(double i) {
        xPos = i;
    }
    public void setYPos(double i) {
        yPos = i;
    }
    public void setImageFile(String fileName) {
        imageFile = fileName;
    }
    public String getImageFile() {
        return imageFile;
    }
    public void setPane(Pane pane) {
        thePane = pane;
    }
}
    

