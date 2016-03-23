Resource: Dynamic Lighting v1.3.7
contact: knoblauch700@o2.pl
Update v1.3.7
-the directional light settings are now properly applied when the shaders are off.
(Forcing the effects on or using any other lights is still required for directional light to work)
Update v1.3.6
-added a per vertex directional light.
-divided effect files for different shader models.
Update v1.3.5
-gWorldNormalShading option is now applied before the world effect is compiled
-added setWorldNormalShading and setMaxLights exported functions
Update v1.3.4
-reversed back to 1.3.2
Update v1.3.3
-applied an experimental function createCubeLight
Update v1.3.2
-reconfigured setShaderNightMod, added setShaderPedDiffuse
Update v1.3.1
-applied setShaderDayTime and setShaderNightMod functions ( more info soon)
Update v1.2.9
-added setTextureBrightness, setLightsDistFade, setLightsEffectRange
Update v1.2.8
-added setGenerateBumpNormals function
Update v1.2.7
-Fixed output light sorting issue
Update v1.2.6
-Alpha fix

This resource lets You create dynamic lights in MTA. It gives you a list of exported functions
that You can use to create per pixel pointlights and spotlights.

Check out mta wiki for details:
https://wiki.multitheftauto.com/wiki/Resource:Dynamic_lighting

exported functions:

createPointLight(posX,posY,posZ,colorR,colorG,colorB,colorA,attenuation,[bool normalShadowing = true])
	Creates a pointlight.
createSpotLight(float posX,posY,posZ,colorR,colorG,colorB,colorA,dirX,dirY,dirZ,bool isEuler,float falloff,theta,phi,attenuation,[bool normalShadowing = true])
	Creates a spotlight.
createCubeLight(posX,posY,posZ,colorR,colorG,colorB,colorA,attenuation)
	Creates a thin fog.
destroyLight(lightElement)
	Destroys the light element.
setLightDirection(element lightElement,float dirX,dirY,dirZ,[isEuler])
	Direction that the light is pointing in world space. This member has meaning only for spotlights. 
setLightPosition(element lightElement,float posX,posY,posZ)
	Position of the light in world space,
setLightColor(lightElement,colorR,colorG,colorB,colorA)
	RGBA diffuse color emitted by the light. 
setLightAttenuation(element lightElement,float attenuation)
	Value specifying how the light intensity changes over distance.
setLightFalloff(element lightElement,float falloff)
	Decrease in illumination between a spotlight's inner cone (the angle specified by Theta) and the outer 
	edge of the outer cone (the angle specified by Phi). 
setLightTheta(element lightElement,float theta)
	Angle, in radians, of a spotlight's inner cone - that is, the fully illuminated spotlight cone. 
	This value must be in the range from 0 through the value specified by Phi.
setLightPhi(element lightElement,float phi)
	Angle, in radians, defining the outer edge of the spotlight's outer cone. Points outside this cone 
	are not lit by the spotlight. This value must be between 0 and pi.
setLightNormalShadowing(element lightElement,bool normalShadow)
	Determine if the light source should be obscured when lighting a surface on opposite angles..
setNormalShadowingAmount(float)
	Determine global shadowing value (1-full 0-nil)
setGenerateBumpNormals(bool isTrue,[int textureSize = 512, float normalStrength.x = 1, float normalStrength.y = 1])
	Should the shader effect generate bump normals from texture0. Doesn't work when normal shadowing is set to false.
setTextureBrightness(float brightness)
	Set the world and ped textures brightness  1 - full 0 - none. Is currently not applied to vehicles, but can be managed
	by an external non layered vehicle effect.
setLightsDistFade(int MaxEffectFade,int MinEffectFade)
	Set the Max distance of the light to sync and the distance on which the light starts to fade out.
setLightsEffectRange(int MaxEffectRange)
	Set the Max distance from the camera the shader effects are applied to.
setShaderForcedOn(bool)
	Should the shader effect turn off when no lightsources
setShaderTimeOut(int)
	Should the shader effect turn off after number of seconds (when no lightsources)
setShaderNightMod(bool)
	Enable nightMod effect - requires proper manipulation of setTextureBrightness and SetShaderDayTime, also some additional shaders.
setShaderDayTime(float)
	Another additional variable to control texture colors - requires setShaderNightMod(true)
setShaderPedDiffuse(bool)
	Enable or disable gta directional lights for ped. 