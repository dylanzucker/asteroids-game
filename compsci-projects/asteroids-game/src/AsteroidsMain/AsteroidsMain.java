/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AsteroidsMain;

import AsteroidsView.AsteroidsMainMenu;
import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

/**
 *
 * @author Dylan
 */
public class AsteroidsMain extends Application {

    @Override
    public void start(Stage stage) {

        Group root = new Group();
        Scene scene = new Scene(root);

        scene.setFill(Color.BLACK);

        AsteroidsMainMenu menuView = new AsteroidsMainMenu();

        root.getChildren().add(menuView.getPane());

        stage.setTitle("Asteroids Game!!!");
        stage.setWidth(415);
        stage.setHeight(200);
        stage.setScene(scene);
        stage.sizeToScene();
        menuView.setStage(stage);
        stage.show();
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }

}
