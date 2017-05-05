/* *****************************************
* Asteroids Game Side Project
* Spring 2017
*
*
* Date: May 5, 2017
* Time: 12:05:35 AM
*
* Project: asteroids-game
* Package: AsteroidsView
* File: AsteroidsView
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
public class AsteroidsView {
    
    private Pane thePane;
    private Label scoreLabel;
    private Button pauseButton;
    private Label superPowerLabel;
    
    public AsteroidsView() {
       
        thePane = new Pane();
        thePane.setPrefSize(1000, 1000);
        scoreLabel = new Label("Score:");
        scoreLabel.setTextFill(Paint.valueOf("WHITE"));
        scoreLabel.setMinSize(40, 40);
        scoreLabel.setLayoutX(thePane.getWidth() + 10);
        scoreLabel.setLayoutY(thePane.getHeight() + 10);
        thePane.getChildren().add(scoreLabel);
        
    }
    
    public Pane getPane() {
        return thePane;
    }

    public void setPane(Pane thePane) {
        this.thePane = thePane;
    }

    public Label getScoreLabel() {
        return scoreLabel;
    }

    public void setScoreLabel(Label scoreLabel) {
        this.scoreLabel = scoreLabel;
    }

    public Button getPauseButton() {
        return pauseButton;
    }

    public void setPauseButton(Button pauseButton) {
        this.pauseButton = pauseButton;
    }

    public Label getSuperPowerLabel() {
        return superPowerLabel;
    }

    public void setSuperPowerLabel(Label superPowerLabel) {
        this.superPowerLabel = superPowerLabel;
    }
    
    
    
    
    
    
}
