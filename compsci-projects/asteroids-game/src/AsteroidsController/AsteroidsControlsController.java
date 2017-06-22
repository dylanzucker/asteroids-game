/* *****************************************
* Asteroids Game Side Project
* Spring 2017
*
*
* Date: Jun 19, 2017
* Time: 11:25:05 AM
*
* Project: asteroids-game
* Package: AsteroidsController
* File: AsteroidsControlsController
* Description: Asteroids Game
*
* ****************************************
 */
package AsteroidsController;

import AsteroidsView.AsteroidsControlsView;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.stage.Stage;

/**
 *
 * @author Dylan
 */
class AsteroidsControlsController implements EventHandler<ActionEvent> {

    private AsteroidsControlsView theView;
    private Stage thisStage;
    private AsteroidsControlsController ctrl = this;

    public void setView(AsteroidsControlsView view) {
        theView = view;
    }

    public void setStage(Stage stage) {
        thisStage = stage;
    }

    @Override
    public void handle(ActionEvent event) {
        if (event.getSource().equals(theView.getBackButton())) {
            //set up the main menu maybe make that a method.
        }
    }

}
