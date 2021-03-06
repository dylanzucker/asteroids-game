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
import AsteroidsView.AsteroidsMainMenu;
import Models.Asteroid;
import Models.Bullet;
import Models.GamePiece;
import Models.Ship;
import com.sun.corba.se.impl.orbutil.concurrent.Mutex;
import java.util.ArrayList;
import java.util.Random;
import javafx.concurrent.Task;
import javafx.event.EventHandler;
import javafx.geometry.Point2D;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

/**
 *
 * @author Dylan
 */
public class AsteroidsController implements EventHandler<KeyEvent> {

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
    private Stage thisStage;
    private Mutex mutex = new Mutex();

    public void onUpdate() throws InterruptedException {
        mutex.acquire();
        if (!gameOn) {
            for (Asteroid a : asteroids) {
                theView.getPane().getChildren().remove(a.getView());
            }
            for (Bullet b : bullets) {
                theView.getPane().getChildren().remove(b.getView());
            }
            asteroids.clear();
            bullets.clear();

        }
        else {
            for (Asteroid a : asteroids) {

                if ((!theView.getPane().getChildren().contains(a.getView()) && (a.isAlive()))) {
                    theView.getPane().getChildren().add(a.getView());
                    a.setPane(theView.getPane());
                }
                a.update();
                if (a.isColliding(ship)) {
                    gameOn = false;
                    gameOver();
                    break;
                }
                for (Bullet b : bullets) {
                    b.update();
                    if (b.isColliding(a)) {
                        score += 100;
                        theView.getScoreLabel().setText("Score: " + score);
                        b.setAlive(false);
                        a.setAlive(false);
                        theView.getPane().getChildren().remove(b.getView());
                        //                      if (a.getPieceWidth() == sizes[0]) {
                        theView.getPane().getChildren().remove(a.getView());
//                        }
//                        else {
//                            int childSize;
//                            if (a.getPieceWidth() == sizes[1]) {
//                                childSize = sizes[0];
//                            }
//                            else {
//                                childSize = sizes[1];
//                            }
//                            ImageView imgv = new ImageView();
//                            imgv.setImage(
//                                    new Image("newAsteroid.png", childSize,
//                                              childSize, true, true));
//
//                            Asteroid child1 = new Asteroid(imgv);
//                            Asteroid child2 = new Asteroid(imgv);
//                            child1.setPieceWidth(childSize);
//                            child1.setPieceHeight(childSize);
//                            child2.setPieceWidth(childSize);
//                            child2.setPieceHeight(childSize);
//                            child1.setXPos(a.getXPos());
//                            child1.setYPos(a.getYPos());
//                            child1.setVelocity(a.getVelocity());
//                            child2.setXPos(a.getXPos());
//                            child2.setYPos(a.getYPos());
//                            child2.setPieceWidth(childSize);
//                            child2.setPieceHeight(childSize);
//                            child1.setImageFile(a.getImageFile());
//                            child2.setImageFile(a.getImageFile());
//                            child2.setVelocity(new Point2D(0.5, 0.5));
//                            child1.setPane(theView.getPane());
//                            child2.setPane(theView.getPane());
//                            addAsteroid(child1);
//                            addAsteroid(child2);

                        // }
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
        mutex.release();

    }

    public void addAsteroid(Asteroid asteroid) {
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
        Group root = new Group();
        Scene scene = new Scene(root);

        scene.setFill(Color.BLACK);

        AsteroidsMainMenu menuView = new AsteroidsMainMenu();

        root.getChildren().add(menuView.getPane());

        thisStage.setTitle("ship_1.png");
        thisStage.setWidth(415);
        thisStage.setHeight(200);
        thisStage.setScene(scene);
        thisStage.sizeToScene();
        menuView.setStage(thisStage);
        thisStage.show();
    }

    public void setView(AsteroidsGameView view) {
        theView = view;
    }

    public void setStage(Stage stage) {
        thisStage = stage;
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
                mutex.acquire();
                ArrayList<Asteroid> newList = new ArrayList<>();
                newList = asteroids;
//                if (asteroids.size() > 70) { //Make it a max asteroids that collisionCheck number goes up as you play longer
//                    continue;
//                }
                if (score % 1000 == 0 && score != 0 && maxAsteroids < 17) {
                    score += 100;
                    maxAsteroids += 4;
                }
                else if (score % 2000 == 0 && score != 0) {
                    ImageView img = new ImageView();
                    img.setImage(new Image("ben.png", 250, 200, true, true));
                    Asteroid a = new Asteroid(img);
                    a.setImageFile("ben.png");
                    a.setXPos(0);
                    a.setYPos(
                            (Math.random() * (theView.getPane().getHeight() + 1)));
                    double xv = Math.sin(Math.toRadians(
                            Math.random() * 110 + 1));
                    double yv = -1 * Math.cos(
                            Math.toRadians(Math.random() * 110 + 1));
                    a.setVelocity(new Point2D(xv * 2.5, yv * 2.5));
                    addAsteroid(a);
                    score += 100;
                }
                else if (Math.random() < 0.09 && asteroids.size() < maxAsteroids) {

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
                        a.setYPos(
                                (Math.random() * (theView.getPane().getHeight() + 1)));
                        double xv = Math.sin(Math.toRadians(
                                Math.random() * 110 + 1));
                        double yv = -1 * Math.cos(
                                Math.toRadians(Math.random() * 110 + 1));
                        a.setVelocity(new Point2D(xv * 1.3, yv * 1.3));

                    }
                    else if (x > .25 && x <= .5) {
                        a.setXPos(1200);
                        a.setYPos(
                                (Math.random() * (theView.getPane().getHeight() + 1)));
                        double xv = Math.sin(Math.toRadians(
                                Math.random() * -110 - 1));
                        double yv = -1 * Math.cos(
                                Math.toRadians(Math.random() * 110 + 1));
                        a.setVelocity(new Point2D(xv * 1.4, yv * 1.4));
                    }
                    else if (x > .5 && x <= .75) {
                        a.setYPos(0);
                        a.setXPos(
                                (Math.random() * (theView.getPane().getWidth() + 1)));
                        double xv = Math.sin(Math.toRadians(
                                Math.random() * 110 + 1));
                        double yv = -1 * Math.cos(
                                Math.toRadians(Math.random() * -110 - 1));
                        a.setVelocity(new Point2D(xv * 1.3, yv * 1.3));
                    }
                    else {
                        a.setYPos(700);
                        a.setXPos(
                                (Math.random() * (theView.getPane().getWidth() + 1)));
                        double xv = Math.sin(Math.toRadians(
                                Math.random() * -110 - 1));
                        double yv = -1 * Math.cos(
                                Math.toRadians(Math.random() * 110 + 1));
                        a.setVelocity(new Point2D(xv * 1.1, yv * 1.1));
                    }

                    a.setImageFile("newAsteroid.png");
                    a.setPieceWidth(sizes[2]);
                    a.setPieceHeight(sizes[2]);

                    addAsteroid(a);

                }
                mutex.release();
            }

            return null;
        }
    };

}
