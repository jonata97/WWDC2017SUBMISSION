//#-hidden-code
import PlaygroundSupport

func comunication(_ message: String) {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.string(message))
    }
}



comunication ("go")
//#-end-hidden-code


/*: Terraform intro
 
 # Welcome to I86f
 
 
 
Using coordinates from the space probe [Voyager 2](glossary://Voyager%202) you found a planet named I86f that has the required characteristics to go through the process of terraforming where you create a safe enviroment to human life in a usually uninhabitable planet. Now you need to collect the resources to build the mechanism developed by scientists to create the necessary atmosphere to life. Explore the planet and find these resources before it's too late.


 There are 3 crystals that represent 3 types of elements, which are required to create an atmosphere. Collect each one of them and create the machine that will save the human race.
 

 The `blue crystal` represents [oxigen](glossary://Oxigen):
 
 ![Playground icon](blueCrystal.png)
 
 
 The `pink crystal` represents [nitrogen](glossary://Nitrogen):
 
 ![Playground icon](pinkCrystal.png)
 
 
 The `yellow crystal` represents [carbon](glossary://Carbon):
 
 ![Playground icon](yellowCrystal.png)
 
 
 PS: Your suit is smart, it can teleports you back to your ship everytime you encounter a threat, plus you don't loose your crystals in the process.
 
 PS2: It can take long but it compiles.
 


 `The game was meant to play in fullscreen`
 
 

 */



