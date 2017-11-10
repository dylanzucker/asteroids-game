/* *****************************************
* Asteroids Game Side Project
* Spring 2017
*
*
* Date: May 5, 2017
* Time: 2:37:30 PM
*
* Project: asteroids-game
* Package: AsteroidsController
* File: AsteroidsMenuController
* Description: Asteroids Game
*
* ****************************************
 */
package AsteroidsController;

import AsteroidsView.AsteroidsControlsView;
import AsteroidsView.AsteroidsGameView;
import AsteroidsView.AsteroidsMainMenu;
import Models.Ship;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.animation.AnimationTimer;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundImage;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

/**
 *
 * @author Dylan
 */
public class AsteroidsMenuController implements EventHandler<ActionEvent> {

    private AsteroidsMainMenu theView;
    private Stage theStage;

    public AsteroidsMenuController(AsteroidsMainMenu view) {
        theView = view;
        theView.getControlsButton().setOnAction(this);
        theView.getStartButton().setOnAction(this);
        theView.getHighScoresButton().setOnAction(this);
    }

    public void setView(AsteroidsMainMenu view) {
        theView = view;
    }

    public void setStage(Stage stage) {
        theStage = stage;
    }

    @Override
    public void handle(ActionEvent event) {
        Button source = (Button) event.getSource();

        if (source.getText().equalsIgnoreCase("Start")) {

            Group root = new Group();
            Scene scene = new Scene(root);

            AsteroidsGameView view = new AsteroidsGameView();
            AsteroidsController ctrl = new AsteroidsController();
            ctrl.setStage(theStage);
            // load the image
            Image image = new Image("ship.png");

            // simple displays ImageView the image as is
            ImageView iv1 = new ImageView();
            iv1.setImage(image);

            // resizes the image to have width of 100 while preserving the ratio and using
            // higher quality filtering method; this ImageView is also cached to
            // improve performance
            ImageView iv2 = new ImageView();
            iv2.setImage(image);
            iv2.setFitWidth(50);
            iv2.setPreserveRatio(true);
            iv2.setSmooth(true);
            iv2.setCache(true);

            // defines a viewport into the source image (achieving a "zoom" effect) and
            // displays it rotated
            Ship ship = new Ship(iv2);

            ship.setXPos(450);
            ship.setYPos(350);

            ctrl.instatiateShip(ship);

            view.getPane().getChildren().add(ship.getView());
            view.getPane().setBackground(new Background(new BackgroundImage(
                    new Image(
                            "space1.jpg"), null, null, null, null)));
            ctrl.setView(view);
            ship.setPane(view.getPane());
            root.getChildren().add(view.getPane());
            AnimationTimer theTimer = new AnimationTimer() {
                @Override
                public void handle(long now) {

                    try {
                        ctrl.onUpdate();
                    } catch (InterruptedException ex) {
                        Logger.getLogger(AsteroidsMenuController.class.getName()).log(
                                Level.SEVERE,
                                null,
                                ex);
                    }

                }
            };

            scene.setOnKeyPressed(ctrl);
            scene.setOnKeyReleased(ctrl);

            theStage.setWidth(415);
            theStage.setHeight(200);
            theStage.setScene(scene);
            theStage.sizeToScene();
            theStage.show();
            theTimer.start();
            ctrl.generateAsteroids();
        }

        else if (source.getText().equalsIgnoreCase("controls")) {
            Group root = new Group();
            Scene scene = new Scene(root);

            AsteroidsControlsView view = new AsteroidsControlsView();
            AsteroidsControlsController ctrl = new AsteroidsControlsController();
            ctrl.setStage(theStage);
            ctrl.setView(view);
            view.getBackButton().setOnAction(ctrl);

            scene.setFill(Color.BLACK);

            root.getChildren().add(view.getPane());

            theStage.setWidth(1000);
            theStage.setHeight(1000);
            theStage.setScene(scene);
            theStage.sizeToScene();
            theStage.show();
        }
    }
}
