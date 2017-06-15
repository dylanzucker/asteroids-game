/* *****************************************
* Asteroids Game Side Project
* Spring 2017
*
*
* Date: May 3, 2017
* Time: 11:21:17 AM
*
* Project: asteroids-game
* Package: Models
* File: Bullet
* Description: Asteroids Game
*
* ****************************************
 */
package Models;

import javafx.scene.image.ImageView;

/**
 *
 * @author Dylan
 */
public class Bullet extends GamePiece {

    /**
     * How far the bullet has traveled
     */
    private double distanceTravelled;

    /**
     * How far the bullet can travel before it gets destroyed
     */
    private final double maxDistance = 650;

    public Bullet(ImageView view) {
        super(view);
        distanceTravelled = 0;
    }

    /**
     * Updates the coordinates and distanceTraveled of the bullet
     */
    @Override
    public void update() {
        double xOffset = velocity.getX() * 1.2;
        this.xPos += xOffset;
        double yOffset = velocity.getY() * 1.2;
        this.yPos += yOffset;
        this.distanceTravelled += Math.sqrt(Math.pow(xOffset, 2) + Math.pow(
                yOffset,
                2));
        if (xPos <= 0) {
            xPos = thePane.getWidth() - 1;
        }
        if (yPos <= 0) {
            yPos = thePane.getHeight() - 1;
        }
        xPos %= (thePane.getWidth());
        yPos %= (thePane.getHeight());
        updateUI();
        imageView.setFocusTraversable(true);

        if (distanceTravelled >= maxDistance) {
            this.setAlive(false);
            this.thePane.getChildren().remove(this.imageView);
        }

    }
}
