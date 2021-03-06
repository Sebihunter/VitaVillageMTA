// shader_lightSpotVeh.fx
// Author: Ren712/AngerMAN

float2 gDistFade = float2(250, 150);
float gBrightness = 1;

#include "light_config.txt"
#include "lightutil.fx"

//---------------------------------------------------------------------
// Available point/spot lights
//---------------------------------------------------------------------

float gLight0Enable = 0;
int gLight0Type = 1;  // 1 - point 2 - spot
float3 gLight0Position = float3(0,0,0);
float4 gLight0Diffuse = float4(0,0,0,1);
float gLight0Attenuation = 0;
// Spotlight speciffic
float3 gLight0Direction = float3(0.0, 0.0, -1.0);
float gLight0Falloff  = 1.0;
float gLight0Theta = 0;  // inner cone angle
float gLight0Phi = 0;  // outer cone angle

#if (iLightNumber>=2)
float gLight1Enable = 0;
int gLight1Type = 1;
float3 gLight1Position = float3(0,0,0);
float4 gLight1Diffuse = float4(0,0,0,1);
float gLight1Attenuation = 0;
// Spotlight speciffic
float3 gLight1Direction = float3(0.0, 0.0, -1.0);
float gLight1Falloff  = 1.0;
float gLight1Theta = 0;
float gLight1Phi = 0; 

float gLight2Enable = 0;
int gLight2Type = 1;
float3 gLight2Position = float3(0,0,0);
float4 gLight2Diffuse = float4(0,0,0,1);
float gLight2Attenuation = 0;
// Spotlight speciffic
float3 gLight2Direction = float3(0.0, 0.0, -1.0);
float gLight2Falloff  = 1.0;
float gLight2Theta = 0;
float gLight2Phi = 0; 
#endif

#if (iLightNumber>=5)
float gLight3Enable = 0;
int gLight3Type = 1;
float3 gLight3Position = float3(0,0,0);
float4 gLight3Diffuse = float4(0,0,0,1);
float gLight3Attenuation = 0;
// Spotlight speciffic
float3 gLight3Direction = float3(0.0, 0.0, -1.0);
float gLight3Falloff  = 1.0;
float gLight3Theta = 0;
float gLight3Phi = 0; 

float gLight4Enable = 0;
int gLight4Type = 1;
float3 gLight4Position = float3(0,0,0);
float4 gLight4Diffuse = float4(0,0,0,1);
float gLight4Attenuation = 0; 
// Spotlight speciffic
float3 gLight4Direction = float3(0.0, 0.0, -1.0);
float gLight4Falloff  = 1.0;
float gLight4Theta = 0;
float gLight4Phi = 0; 

float gLight5Enable = 0;
int gLight5Type = 1;
float3 gLight5Position = float3(0,0,0);
float4 gLight5Diffuse = float4(0,0,0,1);
float gLight5Attenuation = 0; 
// Spotlight speciffic
float3 gLight5Direction = float3(0.0, 0.0, -1.0);
float gLight5Falloff  = 1.0;
float gLight5Theta = 0;
float gLight5Phi = 0; 
#endif

#if (iLightNumber>=8)
float gLight6Enable = 0;
int gLight6Type = 1;
float3 gLight6Position = float3(0,0,0);
float4 gLight6Diffuse = float4(0,0,0,1);
float gLight6Attenuation = 0; 
// Spotlight speciffic
float3 gLight6Direction = float3(0.0, 0.0, -1.0);
float gLight6Falloff  = 1.0;
float gLight6Theta = 0;
float gLight6Phi = 0; 

float gLight7Enable = 0;
int gLight7Type = 1;
float3 gLight7Position = float3(0,0,0);
float4 gLight7Diffuse = float4(0,0,0,1);
float gLight7Attenuation = 0; 
// Spotlight speciffic
float3 gLight7Direction = float3(0.0, 0.0, -1.0);
float gLight7Falloff  = 1.0;
float gLight7Theta = 0;
float gLight7Phi = 0; 

float gLight8Enable = 0;
int gLight8Type = 1;
float3 gLight8Position = float3(0,0,0);
float4 gLight8Diffuse = float4(0,0,0,1);
float gLight8Attenuation = 0; 
// Spotlight speciffic
float3 gLight8Direction = float3(0.0, 0.0, -1.0);
float gLight8Falloff  = 1.0;
float gLight8Theta = 0;
float gLight8Phi = 0; 
#endif

#if (iLightNumber>=11)
float gLight9Enable = 0;
int gLight9Type = 1;
float3 gLight9Position = float3(0,0,0);
float4 gLight9Diffuse = float4(0,0,0,1);
float gLight9Attenuation = 0; 
// Spotlight speciffic
float3 gLight9Direction = float3(0.0, 0.0, -1.0);
float gLight9Falloff  = 1.0;
float gLight9Theta = 0;
float gLight9Phi = 0; 

float gLight10Enable = 0;
int gLight10Type = 1;
float3 gLight10Position = float3(0,0,0);
float4 gLight10Diffuse = float4(0,0,0,1);
float gLight10Attenuation = 0; 
// Spotlight speciffic
float3 gLight10Direction = float3(0.0, 0.0, -1.0);
float gLight10Falloff  = 1.0;
float gLight10Theta = 0;
float gLight10Phi = 0; 

float gLight11Enable = 0;
int gLight11Type = 1;
float3 gLight11Position = float3(0,0,0);
float4 gLight11Diffuse = float4(0,0,0,1);
float gLight11Attenuation = 0; 
// Spotlight speciffic
float3 gLight11Direction = float3(0.0, 0.0, -1.0);
float gLight11Falloff  = 1.0;
float gLight11Theta = 0;
float gLight11Phi = 0; 
#endif

#if (iLightNumber>=14)
float gLight12Enable = 0;
int gLight12Type = 1;
float3 gLight12Position = float3(0,0,0);
float4 gLight12Diffuse = float4(0,0,0,1);
float gLight12Attenuation = 0; 
// Spotlight speciffic
float3 gLight12Direction = float3(0.0, 0.0, -1.0);
float gLight12Falloff  = 1.0;
float gLight12Theta = 0;
float gLight12Phi = 0; 

float gLight13Enable = 0;
int gLight13Type = 1;
float3 gLight13Position = float3(0,0,0);
float4 gLight13Diffuse = float4(0,0,0,1);
float gLight13Attenuation = 0; 
// Spotlight speciffic
float3 gLight13Direction = float3(0.0, 0.0, -1.0);
float gLight13Falloff  = 1.0;
float gLight13Theta = 0;
float gLight13Phi = 0; 

float gLight14Enable = 0;
int gLight14Type = 1;
float3 gLight14Position = float3(0,0,0);
float4 gLight14Diffuse = float4(0,0,0,1);
float gLight14Attenuation = 0; 
// Spotlight speciffic
float3 gLight14Direction = float3(0.0, 0.0, -1.0);
float gLight14Falloff  = 1.0;
float gLight14Theta = 0;
float gLight14Phi = 0; 
#endif

// Directional light
bool gDirLightEnable = false;
float4 gDirLightDiffuse = float4(0,0,0,1);
float3 gDirLightDirection = float3(0.0, 0.0, -1.0);

//---------------------------------------------------------------------
// Pass some common stuff
//---------------------------------------------------------------------
float4x4 gWorld : WORLD;
float4x4 gView : VIEW;
float4x4 gProjection : PROJECTION;
float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;
float3 gCameraPosition : CAMERAPOSITION;
texture gTexture0 < string textureState="0,Texture"; >;
int CUSTOMFLAGS <string createNormals = "yes"; string skipUnusedParameters = "yes"; >;
   
//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------

sampler Sampler0 = sampler_state
{
    Texture = (gTexture0);
};

//---------------------------------------------------------------------
//-- Structure of data sent to the vertex shader
//--------------------------------------------------------------------- 
 
 struct VSInput
{
    float4 Position : POSITION; 
    float3 TexCoord : TEXCOORD0;
    float4 Normal : NORMAL0;
    float4 Diffuse : COLOR0; 
};

//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------

struct PSInput
{
    float4 Position : POSITION0;
    float2 TexCoord : TEXCOORD0;	
    float DistFade : TEXCOORD1;
    float3 WorldPos : TEXCOORD2;
    float4 Diffuse : TEXCOORD3;
    float3 Normal : TEXCOORD4;
    float4 ViewPos : TEXCOORD5;
    float4 VertLight : TEXCOORD6;
};

//------------------------------------------------------------------------------------------
// - Some states for BuildingDiffuse
//------------------------------------------------------------------------------------------

int gLighting                      < string renderState="LIGHTING"; >; 
int gDiffuseMaterialSource         < string renderState="DIFFUSEMATERIALSOURCE"; >;           //  = 145,
int gAmbientMaterialSource         < string renderState="AMBIENTMATERIALSOURCE"; >;           //  = 147,
int gEmissiveMaterialSource        < string renderState="EMISSIVEMATERIALSOURCE"; >;          //  = 148,

float4 gGlobalAmbient       < string renderState="AMBIENT"; >;                    //  = 139
float4 gMaterialAmbient     < string materialState="Ambient"; >;
float4 gMaterialDiffuse     < string materialState="Diffuse"; >;
float4 gMaterialEmissive    < string materialState="Emissive"; >;

//------------------------------------------------------------------------------------------
// MTACalcGTABuildingDiffuse
// - Calculate GTA lighting for buildings
//------------------------------------------------------------------------------------------

float4 MTACalcGTABuildingDiffuse( float4 InDiffuse )
{
    float4 OutDiffuse;

    if ( !gLighting )
    {
        // If lighting render state is off, pass through the vertex color
        OutDiffuse = InDiffuse;
    }
    else
    {
        // If lighting render state is on, calculate diffuse color by doing what D3D usually does
        float4 ambient  = gAmbientMaterialSource  == 0 ? gMaterialAmbient  : InDiffuse;
        float4 diffuse  = gDiffuseMaterialSource  == 0 ? gMaterialDiffuse  : InDiffuse;
        float4 emissive = gEmissiveMaterialSource == 0 ? gMaterialEmissive : InDiffuse;
        OutDiffuse = gGlobalAmbient * saturate( ambient + emissive );
        OutDiffuse.a *= diffuse.a;
    }
    return OutDiffuse;
}

float4 createDirLight(float3 Normal, float3 LightDir, float4 LightDiffuse)
{		 
    // Compute the direction to the light:
    float3 vLight = normalize( LightDir );
	
    // Determine the final colour:
    float NdotL = saturate( max( 0.0f, dot( Normal, -vLight ) ));
	 
    // The final attenuation is the product of both types 
    // previously evaluated:
	 
    return  NdotL * LightDiffuse;
}

float4 createLight(float3 Normal, float3 WorldPos, int LightType, float3 LightPos, float3 LightDir, float4 LightDiffuse, float Attenuation, float LightPhi, float LightTheta, float LightFalloff )
{	
    // Compute the distance attenuation factor:
	float fDistance = distance( LightPos, WorldPos );

    // Compute the attenuation:
    float fAttenuation = 1 - saturate(fDistance / Attenuation);
    fAttenuation = pow( fAttenuation, 2); 	
	
    // Compute the direction to the light:
    float3 vLight = normalize( LightPos - WorldPos );

    // Determine the angle between the current sample
    // and the light's direction:
    float angle = acos( dot ( -vLight, normalize( LightDir )));
	
    // Compute the spot attenuation factor:
    float fSpotAtten = 0.0f;
    if ( angle > LightPhi ) fSpotAtten = 0.0f;
    else if ( angle < LightTheta) fSpotAtten = 1.0f;
    else fSpotAtten = pow( smoothstep( LightPhi, LightTheta, angle ), LightFalloff );
	 
    // ..If it's going to be a spotlight:	 
    if (LightType==2) fAttenuation *= fSpotAtten;

    // Determine the final colour:
    float NdotL = saturate( max( 0.0f, dot( Normal, vLight ) ));
	 
    // The final attenuation is the product of both types 
    // previously evaluated:
	 
    return  NdotL * fAttenuation * LightDiffuse;

}

float MTAUnlerp( float from, float to, float pos )
{
    if ( from == to )
        return 1.0;
    else
        return ( pos - from ) / ( to - from );
}

int gFogEnable                     < string renderState="FOGENABLE"; >;
float4 gFogColor                   < string renderState="FOGCOLOR"; >;
float gFogStart                    < string renderState="FOGSTART"; >;
float gFogEnd                      < string renderState="FOGEND"; >;
 
float3 MTAApplyFog( float3 texel, float3 worldPos )
{
    if ( !gFogEnable )
        return texel;
 
    float DistanceFromCamera = distance( gCameraPosition, worldPos );
    float FogAmount = ( DistanceFromCamera - gFogStart )/( gFogEnd - gFogStart );
    texel.rgb = lerp(texel.rgb, gFogColor, saturate( FogAmount ) );
    return texel;
}

//-----------------------------------------------------------------------------
//-- VertexShader
//-----------------------------------------------------------------------------
PSInput VertexShaderSB(VSInput VS)
{
    PSInput PS = (PSInput)0;
	
    // The usual stuff
    PS.Position = mul(VS.Position, gWorldViewProjection);
    PS.ViewPos = PS.Position;
    PS.WorldPos = mul(float4(VS.Position.xyz,1), gWorld).xyz; 
    PS.Normal = mul( VS.Normal, (float3x3)gWorld );
    PS.TexCoord = VS.TexCoord;
   
    float DistanceFromCamera = distance( gCameraPosition, PS.WorldPos );
    PS.DistFade = MTAUnlerp ( gDistFade[0], gDistFade[1], DistanceFromCamera );
    PS.Diffuse =  MTACalcGTABuildingDiffuse( VS.Diffuse );
    if (gDirLightEnable) PS.VertLight = saturate( createDirLight( normalize(PS.Normal), gDirLightDirection, gDirLightDiffuse));

    return PS;
}

//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
struct PSOutput
{
    float4 color : COLOR0;
    float depth : DEPTH;
};

PSOutput PixelShaderSBsm3(PSInput PS)
{
    PSOutput output = (PSOutput)0;
	
    float4 texel = tex2D(Sampler0, PS.TexCoord);
    float4 texLight = 0;
    // 24 slots per light
#if (iLightNumber>=14)
    if (gLight14Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight14Type, gLight14Position, gLight14Direction, gLight14Diffuse, gLight14Attenuation, gLight14Phi, gLight14Theta, gLight14Falloff );	
    if (gLight13Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight13Type, gLight13Position, gLight13Direction, gLight13Diffuse, gLight13Attenuation, gLight13Phi, gLight13Theta, gLight13Falloff );	
    if (gLight12Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight12Type, gLight12Position, gLight12Direction, gLight12Diffuse, gLight12Attenuation, gLight12Phi, gLight12Theta, gLight12Falloff );	
#endif
#if (iLightNumber>=11)
    if (gLight11Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight11Type, gLight11Position, gLight11Direction, gLight11Diffuse, gLight11Attenuation, gLight11Phi, gLight11Theta, gLight11Falloff );	
    if (gLight10Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight10Type, gLight10Position, gLight10Direction, gLight10Diffuse, gLight10Attenuation, gLight10Phi, gLight10Theta, gLight10Falloff );	
    if (gLight9Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight9Type, gLight9Position, gLight9Direction, gLight9Diffuse, gLight9Attenuation, gLight9Phi, gLight9Theta, gLight9Falloff );	
#endif
#if (iLightNumber>=8)
    if (gLight8Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight8Type, gLight8Position, gLight8Direction, gLight8Diffuse, gLight8Attenuation, gLight8Phi, gLight8Theta, gLight8Falloff );	
    if (gLight7Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight7Type, gLight7Position, gLight7Direction, gLight7Diffuse, gLight7Attenuation, gLight7Phi, gLight7Theta, gLight7Falloff );	
    if (gLight6Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight6Type, gLight6Position, gLight6Direction, gLight6Diffuse, gLight6Attenuation, gLight6Phi, gLight6Theta, gLight6Falloff );	
#endif
#if (iLightNumber>=5)
    if (gLight5Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight5Type, gLight5Position, gLight5Direction, gLight5Diffuse, gLight5Attenuation, gLight5Phi, gLight5Theta, gLight5Falloff );	
    if (gLight4Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight4Type, gLight4Position, gLight4Direction, gLight4Diffuse, gLight4Attenuation, gLight4Phi, gLight4Theta, gLight4Falloff );	
    if (gLight3Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight3Type, gLight3Position, gLight3Direction, gLight3Diffuse, gLight3Attenuation, gLight3Phi, gLight3Theta, gLight3Falloff );	
#endif
#if (iLightNumber>=2)
    if (gLight2Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight2Type, gLight2Position, gLight2Direction, gLight2Diffuse, gLight2Attenuation, gLight2Phi, gLight2Theta, gLight2Falloff );	
    if (gLight1Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight1Type, gLight1Position, gLight1Direction, gLight1Diffuse, gLight1Attenuation, gLight1Phi, gLight1Theta, gLight1Falloff );	
#endif
    if (gLight0Enable) texLight += createLight(PS.Normal, PS.WorldPos, gLight0Type, gLight0Position, gLight0Direction, gLight0Diffuse, gLight0Attenuation, gLight0Phi, gLight0Theta, gLight0Falloff );		
    if (gDirLightEnable) texLight += PS.VertLight;
	
    float4 light = texel * texLight * saturate( PS.DistFade );
    texel = saturate( light );
    texel.rgb = MTAApplyFog( texel.rgb, PS.WorldPos );
    output.color = saturate(texel);
    output.color.a *= PS.Diffuse.a;
    output.depth = calculateLayeredDepth(PS.ViewPos);
    return output;
}

//-----------------------------------------------------------------------------
//-- Techniques
//-----------------------------------------------------------------------------

technique flashLight_v06_SM3
{
    pass P0
    {
        SrcBlend = SRCALPHA;
        DestBlend = ONE;
        AlphaRef = 1;
        AlphaBlendEnable = TRUE;
        VertexShader = compile vs_3_0 VertexShaderSB();
        PixelShader = compile ps_3_0 PixelShaderSBsm3();
    }
}

technique fallback
{
    pass P0
    {
    }
}
