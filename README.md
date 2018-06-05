# SCNTechniqueGlow

Very basic example of drawing a glow outline around a SceneKit node.
Uses SCNTechnique with Metal shaders.

Code quality not guaranteed.

Based on / inspired by these nice SCNTechnique examples.
https://github.com/lachlanhurst/SCNTechniqueTest
https://github.com/kosua20/Technique-iOS



<img width="300" src="screenshot.jpg">



## FAQ
### How do I make the blur larger? 
For now you will have to manually add blur passes in NodeTechnique.plist. Check the 'sequence' key. This is where the blur passes are defined. Each blur stage requires two blur passes: a horizontal + vertical pass. So make sure to add 'pass_blur_h' along with 'pass_blur_v' or you will end up with an uneven glow. 

### How do I change the blur color? 
For now you need to manually edit the NodeTechnique.plist here: 
https://github.com/laanlabs/SCNTechniqueGlow/blob/master/SCNTechniqueGlow/NodeRender.metal#L69
You can make this modifiable at run time by exposing the variable through the technique; feel free to submit a pull request for this.
