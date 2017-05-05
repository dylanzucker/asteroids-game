/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AsteroidsMain;




import AsteroidsController.AsteroidsController;
import Models.GamePiece;
import Models.Ship;
import javafx.animation.AnimationTimer;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Point2D;
import javafx.geometry.Rectangle2D;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.StackPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

/**
 *
 * @author Dylan
 */
public class AsteroidsMain extends Application {
    
    @Override
    public void start(Stage stage) {
        AsteroidsController ctrl = new AsteroidsController();
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
         
         
         ship.setXPos(200);
         ship.setYPos(200);
         
         ctrl.instatiateShip(ship);
         
          
         Group root = new Group();
         Scene scene = new Scene(root);
         
         scene.setFill(Color.BLACK);
         Pane box = new Pane();
         
         box.setPrefSize(1000, 1000);
         //box.getChildren().add(iv1);
         box.getChildren().add(ship.getView());
         ctrl.setView(box);
         ship.setPane(box);
         root.getChildren().add(box);
         
         stage.setTitle("ship_1.png");
         stage.setWidth(415);
         stage.setHeight(200);
         stage.setScene(scene); 
         stage.sizeToScene(); 
         AnimationTimer theTimer = new AnimationTimer() {
                @Override
                public void handle(long now) {
                    
                        ctrl.onUpdate();
                        
                        
                       
                        
                        
                    }
                };
           scene.setOnKeyPressed(ctrl);
            scene.setOnKeyReleased(ctrl);
            stage.show();
            theTimer.start();
            ctrl.generateAsteroids();

    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    
}
