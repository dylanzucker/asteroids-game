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
import javafx.scene.layout.Pane;
import javafx.scene.paint.Paint;

/**
 *
 * @author Dylan
 */
public class AsteroidsControlsView {

    private Pane thePane;
    private Label controlsLabel;
    private Button backButton;
    private Label leftLabel;

    public AsteroidsControlsView() {

        thePane = new Pane();
        thePane.setPrefSize(1000, 1000);
        controlsLabel = new Label("CONTROLS");
        controlsLabel.setTextFill(Paint.valueOf("WHITE"));
        controlsLabel.setMinSize(40, 40);
        controlsLabel.setLayoutX(thePane.getWidth() + 50);
        controlsLabel.setLayoutY(thePane.getHeight() + 10);
        thePane.getChildren().add(controlsLabel);

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
