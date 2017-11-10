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
import AsteroidsView.AsteroidsMainMenu;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

/**
 *
 * @author Dylan
 */
class AsteroidsControlsController implements EventHandler<ActionEvent> {

    private AsteroidsControlsView theView;
    private Stage theStage;
    private AsteroidsControlsController ctrl = this;

    public void setView(AsteroidsControlsView view) {
        theView = view;
    }

    public void setStage(Stage stage) {
        theStage = stage;
    }

    @Override
    public void handle(ActionEvent event) {
        if (event.getSource().equals(theView.getBackButton())) {
            //set up the main menu maybe make that a method.
            Group root = new Group();
            Scene scene = new Scene(root);

            AsteroidsMainMenu view = new AsteroidsMainMenu();
            //AsteroidsMenuController ctrl = new AsteroidsMenuController(view);
//            ctrl.setStage(theStage);
//            ctrl.setView(view);

            view.setStage(theStage);
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
