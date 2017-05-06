/* *****************************************
* Asteroids Game Side Project
* Spring 2017
*
*
* Date: May 5, 2017
* Time: 2:32:21 PM
*
* Project: asteroids-game
* Package: AsteroidsView
* File: AsteroidsMainMenu
* Description: Asteroids Game
*
* ****************************************
 */
package AsteroidsView;

import AsteroidsController.AsteroidsMenuController;
import javafx.scene.control.Button;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;

/**
 *
 * @author Dylan
 */
public class AsteroidsMainMenu {

    private Pane thePane;
    private Button controlsButton;
    private Button startButton;
    private Button viewHighScoresButton;
    private Button exitButton;
    private AsteroidsMenuController ctrl;
    private Stage theStage;

    public AsteroidsMainMenu() {

        thePane = new Pane();
        thePane.setPrefSize(1000, 1000);

        controlsButton = new Button("Controls");
        controlsButton.setLayoutX(500);
        controlsButton.setLayoutY(500);

        startButton = new Button("Start");
        startButton.setLayoutX(400);
        startButton.setLayoutY(500);

        viewHighScoresButton = new Button("High Scores");
        viewHighScoresButton.setLayoutX(600);
        viewHighScoresButton.setLayoutY(500);

        ctrl = new AsteroidsMenuController(this);

        thePane.getChildren().add(controlsButton);
        thePane.getChildren().add(startButton);
        thePane.getChildren().add(viewHighScoresButton);
    }

    public Pane getPane() {
        return thePane;
    }

    public void setPane(Pane thePane) {
        this.thePane = thePane;
    }

    public Button getControlsButton() {
        return controlsButton;
    }

    public void setControlButton(Button pauseButton) {
        this.controlsButton = pauseButton;
    }

    public Button getStartButton() {
        return startButton;
    }

    public void setStartButton(Button startButton) {
        this.startButton = startButton;
    }

    public Button getHighScoresButton() {
        return controlsButton;
    }

    public void setHighScoresButton(Button highScoresButton) {
        this.viewHighScoresButton = highScoresButton;
    }

    public void setStage(Stage stage) {
        theStage = stage;
        ctrl.setStage(theStage);
    }
}
