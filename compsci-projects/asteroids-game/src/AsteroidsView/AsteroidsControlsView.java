/* *****************************************
* Asteroids Game Side Project
* Spring 2017
*
*
* Date: Jun 15, 2017
* Time: 2:11:41 PM
*
* Project: asteroids-game
* Package: AsteroidsView
* File: AsteroidsControlsView
* Description: Asteroids Game
*
* ****************************************
 */
package AsteroidsView;

import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundImage;
import javafx.scene.layout.BackgroundPosition;
import javafx.scene.layout.BackgroundRepeat;
import javafx.scene.layout.BackgroundSize;
import javafx.scene.layout.Pane;

/**
 *
 * @author Dylan
 */
public class AsteroidsControlsView {

    private Pane thePane;
    private Label controlsLabel;
    private Button backButton;
    private Label leftLabel;
    private Label keysLabel;

    public AsteroidsControlsView() {

        thePane = new Pane();
        thePane.setPrefSize(1000, 1000);

        //Set the Background Image
        Image image = new Image("controlsBackground.jpg");
        BackgroundSize backgroundSize = new BackgroundSize(1000, 1000, true,
                                                           true, true, false);
        BackgroundImage backgroundImage = new BackgroundImage(image,
                                                              BackgroundRepeat.REPEAT,
                                                              BackgroundRepeat.REPEAT,
                                                              BackgroundPosition.DEFAULT,
                                                              backgroundSize);
        thePane.setBackground(new Background(backgroundImage));

//        controlsLabel = new Label("CONTROLS");
//        controlsLabel.setTextFill(Paint.valueOf("WHITE"));
//        controlsLabel.setMinSize(40, 40);
//        controlsLabel.setLayoutX(thePane.getWidth() + 500);
//        controlsLabel.setLayoutY(thePane.getHeight() + 50);
//
//        thePane.getChildren().add(controlsLabel);
//
//        keysLabel = new Label(" Move: Arrows\nFire: Space Bar");
//        keysLabel.setTextFill(Paint.valueOf("WHITE"));
//        keysLabel.setMinSize(40, 40);
//        keysLabel.setLayoutX(500);
//        keysLabel.setLayoutY(200);
//        thePane.getChildren().add(keysLabel);
        backButton = new Button("Back");
        backButton.setTranslateX(465);
        backButton.setTranslateY(445);
        thePane.getChildren().add(backButton);

    }

    public Pane getPane() {
        return thePane;
    }

    public void setPane(Pane thePane) {
        this.thePane = thePane;
    }

    public Label getControlsLabel() {
        return controlsLabel;
    }

    public void setControlsLabel(Label controlsLabel) {
        this.controlsLabel = controlsLabel;
    }

    public Button getBackButton() {
        return backButton;
    }

    public void setBackButton(Button backButton) {
        this.backButton = backButton;
    }

    public Label getLeftLabel() {
        return leftLabel;
    }

    public void setLeftLabel(Label leftLabel) {
        this.leftLabel = leftLabel;
    }

}
