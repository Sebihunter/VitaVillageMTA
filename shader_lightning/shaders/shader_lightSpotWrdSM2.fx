// shader_lightSpotWrd.fx
// Author: Ren712/AngerMAN

float2 gDistFade = float2(250, 150);
float gBrightness = 1;
float gDayTime = 1;
// normal
float gNormalShadingAmount = 1;
// bump mapping
float gTextureSize = 512.0;
float2 gNormalStrength = float2(1,1);

#include "light_config.txt"
#if (wrdLayered==1)
	#include "lightutil.fx"
#endif

//---------------------------------------------------------------------
// Available point/spot lights
//---------------------------------------------------------------------

float gLight0Enable = 0;
int gLight0Type = 1;  // 1 - point 2 - spot
float3 gLight0Position = float3(0,0,0);
float4 gLight0Diffuse = float4(0,0,0,1);
float gLight0Attenuation = 0;
bool gLight0NormalShadow = true;
// Spotlight speciffic
float3 gLight0Direction = float3(0.0, 0.0, -1.0);
float gLight0Falloff  = 1.0;
float gLight0Theta = 0;  // inner cone angle
float gLight0Phi = 0;  // outer cone angle

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
float4x4 gWorldInverseTranspose : WORLDINVERSETRANSPOSE;
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
    float4 Position : POSITION0; 
    float3 TexCoord : TEXCOORD0;
    float4 Normal : NORMAL0;
    float4 Diffuse : COLOR0; 
};

//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------

struct PSInput
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;	
    float DistFade : TEXCOORD1;
    float3 WorldPos : TEXCOORD2;
    float4 Diffuse : COLOR0;
    float4 ViewPos : TEXCOORD4;
    float4 VertLight : TEXCOORD5;
#if (wrdNormalShading==1)
    float3 Normal : TEXCOORD3;
#endif
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

float4 createLight(float3 Normal, float3 WorldPos, int LightType, float3 LightPos, float3 LightDir, float4 LightDiffuse, float Attenuation, float LightPhi, float LightTheta, float LightFalloff, bool LightNormalShadow )
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
    float NdotL = 1;
#if (wrdNormalShading==1)
    NdotL = saturate( max( 0.0f, dot( Normal / gNormalShadingAmount , vLight ) ));
#endif 
    // The final attenuation is the product of both types 
    // previously evaluated:
	 
    if (LightNormalShadow) return  NdotL * fAttenuation * LightDiffuse;
    else return fAttenuation * LightDiffuse ;
}

float MTAUnlerp( float from, float to, float pos )
{
    if ( from == to )
        return 1.0;
    else
        return ( pos - from ) / ( to - from );
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
    PS.TexCoord = VS.TexCoord;
#if (wrdNormalShading==1)
    PS.Normal = mul(VS.Normal, gWorldInverseTranspose);
#endif   
    float DistanceFromCamera = distance( gCameraPosition, PS.WorldPos );
    PS.DistFade = MTAUnlerp ( gDistFade[0], gDistFade[1], DistanceFromCamera );
    float4 Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse );
#if (nightMod==1)  
    float diffGray = ( Diffuse.r + Diffuse.g + Diffuse.b )/3;
    Diffuse = lerp( float4(diffGray, diffGray, diffGray, Diffuse.a ), Diffuse, saturate( pow( gDayTime + 0.001, 1.4 )));
#endif	
    if (gDirLightEnable) PS.VertLight = saturate( createDirLight( normalize(PS.Normal), gDirLightDirection, gDirLightDiffuse));
	
    PS.Diffuse = Diffuse;
    return PS;
}

//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
struct PSOutput
{
    float4 color : COLOR0;
#if (wrdLayered==1)
    float depth : DEPTH;
#endif
};


PSOutput PixelShaderSBsm2(PSInput PS)
{
    PSOutput output = (PSOutput)0;
	
    float4 texel = tex2D(Sampler0, PS.TexCoord);

    float4 texLight = 0;
    float3 Normal = 0;
#if (wrdNormalShading==1)
    Normal = normalize(PS.Normal);	
#endif
	// 24 slots per light
    if (gLight0Enable) texLight += createLight(Normal, PS.WorldPos, gLight0Type, gLight0Position, gLight0Direction, gLight0Diffuse, gLight0Attenuation, gLight0Phi, gLight0Theta, gLight0Falloff, gLight0NormalShadow );		
    if (gDirLightEnable) texLight += PS.VertLight;
	
    texLight *= PS.Diffuse.a;
    float4 light = texel * texLight * saturate( PS.DistFade );
#if (wrdLayered==1)
    texel = 0;
#endif
#if (wrdLayered==0)
#if (nightMod==0) 
    texel.rgb *= PS.Diffuse.rgb;
#endif
#endif
#if (nightMod==0) 
    texel.rgb *= gBrightness;
#endif
#if (nightMod==1)  	
    float colorGray = ( texel.r, texel.g, texel.b )/3;
    texel = lerp(float4( colorGray, colorGray, colorGray, texel.a ), texel, saturate( pow( gDayTime + 0.001, 1.4 )));
    texel.rgb *= lerp( 0.5 , PS.Diffuse.rgb, saturate( gDayTime + 0.3 ) ) * saturate( gDayTime + gBrightness );
#endif  
    texel.rgb += saturate( light.rgb );
#if (wrdLayered==1)
    texel.a = light.a;
    output.color = saturate(texel);
    output.depth = calculateLayeredDepth(PS.ViewPos);
#else
    output.color = saturate(texel);
#endif
    output.color.a *= PS.Diffuse.a; 
    return output;
}

//-----------------------------------------------------------------------------
//-- Techniques
//-----------------------------------------------------------------------------

technique flashLight_v06_SM2
{
    pass P0
    {
        #if (wrdLayered==1)        
            AlphaRef = 1;
            SrcBlend = SRCALPHA;
            DestBlend = ONE;
        #endif
        AlphaBlendEnable = TRUE;
        VertexShader = compile vs_2_0 VertexShaderSB();
        PixelShader = compile ps_2_0 PixelShaderSBsm2();
    }
}

technique fallback
{
    pass P0
    {
    }
}
