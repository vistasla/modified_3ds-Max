// ----------------------------------------- Header ------------------------------------------
#ifndef SFX_HLSL_5
	#define SFX_HLSL_5
#endif 
#ifndef _3DSMAX_
	#define _3DSMAX_
#endif 



#ifndef half 
	#define half float 
	#define half2 float2 
	#define half3 float3 
	#define half4 float4 
#endif 


float2 ShadowFilterTaps[10]
<
	string UIWidget = "None";
> = {float2(-0.84052, -0.073954), float2(-0.326235, -0.40583), float2(-0.698464, 0.457259), float2(-0.203356, 0.620585), float2(0.96345, -0.194353), float2(0.473434, -0.480026), float2(0.519454, 0.767034), float2(0.185461, -0.894523), float2(0.507351, 0.064963), float2(-0.321932, 0.595435)};



// ----------------------------------- Per Frame --------------------------------------
cbuffer UpdatePerFrame : register(b0)
{
	float4x4 viewI : ViewInverse < string UIWidget = "None"; >;

};

// --------------------------------------- Per Object -----------------------------------------
cbuffer UpdatePerObject : register(b1)
{
	float4x4 world : World < string UIWidget = "None"; >;

int ClampDynamicLights
	<
		float UIMin = 0;
		float UISoftMin = 0;
		float UIMax = 99;
		float UISoftMax = 99;
		float UIStep = 1;
		string UIName = "ClampDynamicLights";
		string UIWidget = "IntSpinner";
> = 99;

	float4x4 wvp : WorldViewProjection < string UIWidget = "None"; >;

};

// --------------------------------------- Attributes -----------------------------------------
cbuffer UpdateAttributes : register(b2)
{
float3 MyColor
	<
		string UIName = "MyColor";
		int UIOrder = 1;
		string UIWidget = "ColorSwatch";
> = {0.5,0.5,0.5};

float MyMultiplier
	<
		float UIMin = 0.0;
		float UISoftMin = 0.0;
		float UIMax = 99.0;
		float UISoftMax = 99.0;
		float UIStep = 0.01;
		string UIName = "MyMultiplier";
		int UIOrder = 2;
		string UIWidget = "FloatSpinner";
> = 1.0;

float3 OffsetColor
	<
		string UIName = "OffsetColor";
		int UIOrder = 3;
		string UIWidget = "ColorSwatch";
> = {0.5,0.5,0.5};

};

// ----------------------------------- Lights --------------------------------------
cbuffer UpdateLights : register(b3)
{
int Light0Type : LIGHTTYPE
	<
		string UIName =  "Light 0 Type (2:spot 3:omni 4:dir)";
		float UIMin = 0;
		float UIMax = 5;
		float UIStep = 1;
		int LightRef = 1;
	> = 3;

float3 Light0Color : LIGHTCOLOR
	<
		string UIWidget = "None";
		int LightRef = 1;
	> = {1.0, 1.0, 1.0};

float Light0Intensity : LIGHTINTENSITY
	<
		float UIMin = 0;
		float UIStep = 0.1;
		string UIWidget = "None";
		int LightRef = 1;
	> = 1.0;

float3 Light0Pos : POSITION
	<
		string UIName =  "Light 0 Position";
		string Space = "World";
		string UIWidget = "None";
		int RefID = 1;
		string Object = "PointLight";
	> = {1.0, 1.0, 1.0};

float3 Light0Dir : DIRECTION
	<
		string UIName =  "Light 0 Direction";
		string Space = "World";
		string UIWidget = "None";
		int RefID = 100;
		string Object = "TargetLight";
	> = {0.0, -1.0, 0.0};

float Light0Attenuation
	<
		float UIMin = 0;
		float UIStep = 1;
		string UIWidget = "None";
		int LightRef = 1;
	> = 0.0;

float Light0ConeAngle : LightHotSpot
	<
		float UIMin = 0;
		float UIMax = 1.571;
		float UIStep = 0.05;
		string Space = "World";
		string UIWidget = "None";
		int LightRef = 1;
	> = 0.46;

float Light0Falloff : LightFallOff
	<
		float UIMin = 0;
		float UIMax = 1.571;
		float UIStep = 0.05;
		string UIWidget = "None";
		int LightRef = 1;
	> = 0.7;

bool Light0ShadowOn : SHADOWFLAG
	<
		string UIWidget = "None";
		int LightRef = 1;
	> = true;

float4x4 Light0ViewPrj : SHADOWMAPMATRIX
	<
		string Object =  "Light 0";
		string UIName =  "Light 0 Matrix";
		string UIWidget = "None";
		int LightRef = 1;
	>;

float Light0ShadowBias : SHADOWBIAS
	<
		string UIWidget = "None";
		int LightRef = 1;
	> = 0.01;

float3 Light0ShadowColor : SHADOWCOLOR
	<
		string UIWidget = "None";
		int LightRef = 1;
	> = {0, 0, 0};

};

// ---------------------------------------- Textures -----------------------------------------
Texture2D Light0ShadowMap : SHADOWMAP
<
	string ResourceName = "";
	string ResourceType = "2D";
	string UIWidget = "None";
	int LightRef = 1;
>;

SamplerState Light0ShadowMapSampler : SHADOWMAPSAMPLER
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = BORDER;
	AddressV = BORDER;
	AddressW = BORDER;
	BorderColor = float4(1.0,1.0,1.0,1.0);
};


// ---------------------------------------- Functions -----------------------------------------
int GetLightType(int ActiveLightIndex) 
{ 

		return Light0Type; 
}

float3 GetLightColor(int ActiveLightIndex) 
{ 

		return Light0Color; 
}

float GetLightIntensity(int ActiveLightIndex) 
{ 

		return Light0Intensity; 
}

float3 GetLightPos(int ActiveLightIndex) 
{ 

		return Light0Pos; 
}

float3 GetLightDir(int ActiveLightIndex) 
{ 

		return Light0Dir; 
}

float GetLightAttenuation(int ActiveLightIndex) 
{ 

		return Light0Attenuation; 
}

float GetLightConeAngle(int ActiveLightIndex) 
{ 

		return Light0ConeAngle; 
}

float GetLightFalloff(int ActiveLightIndex) 
{ 

		return Light0Falloff; 
}

bool GetLightShadowOn(int ActiveLightIndex) 
{ 

		return Light0ShadowOn; 
}

float4x4 GetLightViewPrj(int ActiveLightIndex) 
{ 

		return Light0ViewPrj; 
}

float GetLightShadowBias(int ActiveLightIndex) 
{ 

		return Light0ShadowBias; 
}

Texture2D GetLightShadowMap(int ActiveLightIndex) 
{ 

		return Light0ShadowMap; 
}

float4 SampleFromShadowMap( int ActiveLightIndex, float2 UVs) 
{ 

		return Light0ShadowMap.SampleLevel(Light0ShadowMapSampler, UVs, 0); 
}

float3 GetLightShadowColor(int ActiveLightIndex) 
{ 

		return Light0ShadowColor; 
}


// -------------------------------------- MyColorFunctionFunction --------------------------------------
struct MyColorFunctionOutput
{
	float3 DiffuseColor;
};

MyColorFunctionOutput MyColorFunctionFunction(float3 ColorA, float Multiplier, float3 ColorB)
{
	MyColorFunctionOutput OUT;

	float3 AddOp = (ColorB + (ColorA * Multiplier));
	OUT.DiffuseColor = AddOp;

	return OUT;
}

// -------------------------------------- AmbientLightFunction --------------------------------------
struct AmbientLightOutput
{
	float3 LightColor;
};

AmbientLightOutput AmbientLightFunction(int ActiveLightIndex, float3 AlbedoColor, float3 LightColor, float LightIntensity)
{
	AmbientLightOutput OUT;

	float3 MulOp = (LightIntensity * (AlbedoColor * LightColor));
	OUT.LightColor = MulOp;

	return OUT;
}

// -------------------------------------- GetLightVectorFunction --------------------------------------
struct GetLightVectorOutput
{
	float3 Result;
};

GetLightVectorOutput GetLightVectorFunction(int ActiveLightIndex, float3 LightPosition, float3 VertexWorldPosition, int LightType, float3 LightDirection)
{
	GetLightVectorOutput OUT;

	bool IsDirectionalLight = (LightType == 4);
	float3 LerpOp = lerp((LightPosition - VertexWorldPosition), -(LightDirection), IsDirectionalLight);
	OUT.Result = LerpOp;

	return OUT;
}

// -------------------------------------- LambertDiffuseFunction --------------------------------------
struct LambertDiffuseOutput
{
	float3 Color;
};

LambertDiffuseOutput LambertDiffuseFunction(int ActiveLightIndex, float3 AlbedoColor, float3 Normal, float3 LightVector)
{
	LambertDiffuseOutput OUT;

	float SatOp = saturate(dot(Normal, LightVector));
	float3 Diffuse = (AlbedoColor * SatOp);
	OUT.Color = Diffuse;

	return OUT;
}

// -------------------------------------- LightDecayFunction --------------------------------------
struct LightDecayOutput
{
	float Attenuation;
};

LightDecayOutput LightDecayFunction(int ActiveLightIndex, float3 LightVectorUN, float Attenuation)
{
	LightDecayOutput OUT;

	bool IsAttenuationUsed = (Attenuation > 0.001);
	float DecayContribution463 = 0.0;
	if (IsAttenuationUsed)
	{
		float PowOp = pow(length(LightVectorUN), Attenuation);
		float DivOp = (1.0 / PowOp);
		DecayContribution463 = DivOp;
	}
	else
	{
		DecayContribution463 = 1.0;
	}
	OUT.Attenuation = DecayContribution463;

	return OUT;
}

// -------------------------------------- LightConeAngleFunction --------------------------------------
struct LightConeAngleOutput
{
	float ConeAngle;
};

LightConeAngleOutput LightConeAngleFunction(int ActiveLightIndex, float3 LightVector, float3 LightDirection, float ConeAngle, float ConeFalloff)
{
	LightConeAngleOutput OUT;

	float CosOp = cos(max(ConeFalloff, ConeAngle));
	float DotOp = dot(LightVector, -(LightDirection));
	float SmoothStepOp = smoothstep(CosOp, cos(ConeAngle), DotOp);
	OUT.ConeAngle = SmoothStepOp;

	return OUT;
}

// -------------------------------------- ShadowMapFunction --------------------------------------
struct ShadowMapOutput
{
	float LightGain;
};

ShadowMapOutput ShadowMapFunction(int ActiveLightIndex, float4x4 LightViewPrj, float ShadowMapBias, float3 VertexWorldPosition)
{
	ShadowMapOutput OUT;

	float IfElseOp546 = 0.0;
	float4 VectorConstruct = float4(VertexWorldPosition.x, VertexWorldPosition.y, VertexWorldPosition.z, 1.0);
	float4 MulOp = mul(VectorConstruct, LightViewPrj);
	float3 DivOp = (MulOp.xyz / MulOp.w);
	if (DivOp.x > -1.0 && DivOp.x < 1.0 && DivOp.y > -1.0 && DivOp.y < 1.0 && DivOp.z > 0.0 && DivOp.z < 1.0)
	{
		float Val = 0.5;
		float2 AddOp = ((DivOp.xy * Val) + Val);
		float SubOp = (DivOp.z - (ShadowMapBias / MulOp.w));
		float ShadowTotal = 0.0;
		for(int i=0; i<10; i+=1)
		{
			Texture2D _LightShadowMap = GetLightShadowMap(ActiveLightIndex);
			float2 MulOp586 = (ShadowFilterTaps[i] * 0.0009);
			float2 AddOp587 = (AddOp + MulOp586);
			float OneMinusOp = (1.0 - AddOp587.y);
			float2 VectorConstruct597 = float2(AddOp587.x, OneMinusOp);
			float4 Sampler = SampleFromShadowMap(ActiveLightIndex, VectorConstruct597.xy);
			float IfElseOp540 = ((SubOp - Sampler.x) >= 0.0) ? (0.0) : (0.1);
			ShadowTotal += IfElseOp540;
		}
		IfElseOp546 = ShadowTotal;
	}
	else
	{
		IfElseOp546 = 1.0;
	}
	OUT.LightGain = IfElseOp546;

	return OUT;
}

// -------------------------------------- LightContributionFunction --------------------------------------
struct LightContributionOutput
{
	float3 Light;
};

LightContributionOutput LightContributionFunction(int ActiveLightIndex, float3 VertexWorldPosition, float3 LightVectorUN)
{
	LightContributionOutput OUT;

	float _LightIntensity = GetLightIntensity(ActiveLightIndex);
	int _LightType = GetLightType(ActiveLightIndex);
	bool IsDirectionalLight = (_LightType == 4);
	float DecayMul509 = 0.0;
	if (IsDirectionalLight)
	{
		DecayMul509 = 1.0;
	}
	else
	{
		float _LightAttenuation = GetLightAttenuation(ActiveLightIndex);
		LightDecayOutput LightDecay457 = LightDecayFunction(ActiveLightIndex, LightVectorUN, _LightAttenuation);
		DecayMul509 = LightDecay457.Attenuation;
	}
	bool IsSpotLight = (_LightType == 2);
	float ConeMul511 = 1.0;
	if (IsSpotLight)
	{
		float3 NormOp = normalize(LightVectorUN);
		float3 _LightDir = GetLightDir(ActiveLightIndex);
		float _LightConeAngle = GetLightConeAngle(ActiveLightIndex);
		float _LightFalloff = GetLightFalloff(ActiveLightIndex);
		LightConeAngleOutput LightConeAngle399 = LightConeAngleFunction(ActiveLightIndex, NormOp, -_LightDir, _LightConeAngle, _LightFalloff);
		ConeMul511 = LightConeAngle399.ConeAngle;
	}
	bool _LightShadowOn = GetLightShadowOn(ActiveLightIndex);
	float ShadowMul512 = 1.0;
	if (_LightShadowOn)
	{
		float4x4 _LightViewPrj = GetLightViewPrj(ActiveLightIndex);
		float _LightShadowBias = GetLightShadowBias(ActiveLightIndex);
		ShadowMapOutput ShadowMap525 = ShadowMapFunction(ActiveLightIndex, _LightViewPrj, _LightShadowBias, VertexWorldPosition);
		float3 _LightShadowColor = GetLightShadowColor(ActiveLightIndex);
		float ShadowColorMix = lerp(ShadowMap525.LightGain, 1.0, _LightShadowColor.x);
		ShadowMul512 = ShadowColorMix;
	}
	float DecayShadowConeMul = (DecayMul509 * (ConeMul511 * ShadowMul512));
	float3 _LightColor = GetLightColor(ActiveLightIndex);
	float3 MulItensity = (_LightIntensity * (DecayShadowConeMul * _LightColor));
	OUT.Light = MulItensity;

	return OUT;
}

// -------------------------------------- BlinnSpecularFunction --------------------------------------
struct BlinnSpecularOutput
{
	float3 SpecularColor;
};

BlinnSpecularOutput BlinnSpecularFunction(int ActiveLightIndex, float3 LightVector, float3 Normal, float3 CameraVector, float SpecularPower, float3 SpecularColor)
{
	BlinnSpecularOutput OUT;

	float3 NormOp = normalize((LightVector + CameraVector));
	float SatOp = saturate(dot(Normal, NormOp));
	float3 BlinnSpec = (pow(SatOp, SpecularPower) * SpecularColor);
	float SatOp978 = saturate(dot(Normal, LightVector));
	float3 MulOp = (BlinnSpec * SatOp978);
	OUT.SpecularColor = MulOp;

	return OUT;
}

// -------------------------------------- DesaturateColorFunction --------------------------------------
struct DesaturateColorOutput
{
	float DesaturateColor;
};

DesaturateColorOutput DesaturateColorFunction(int ActiveLightIndex, float3 Color)
{
	DesaturateColorOutput OUT;

	float3 Col = float3(0.300008,0.6,0.100008);
	float DotOp = dot(saturate(Color), Col.xyz);
	OUT.DesaturateColor = DotOp;

	return OUT;
}

// -------------------------------------- DesaturateColorFunction --------------------------------------
DesaturateColorOutput DesaturateColorFunction(float3 Color)
{
	DesaturateColorOutput OUT;

	float3 Col = float3(0.300008,0.6,0.100008);
	float DotOp = dot(saturate(Color), Col.xyz);
	OUT.DesaturateColor = DotOp;

	return OUT;
}

// -------------------------------------- ShaderVertex --------------------------------------
struct APPDATA
{
	float3 Position : POSITION;
	float3 Normal : NORMAL;
};

struct SHADERDATA
{
	float4 Position : SV_Position;
	float4 Normal : NORMAL;
	float4 WorldPosition : TEXCOORD0;
};

SHADERDATA ShaderVertex(APPDATA IN)
{
	SHADERDATA OUT;

	OUT.Position = float4(IN.Position, 1);
	float3 MulOp = mul(IN.Normal, ((float3x3)world));
	float3 NormalN = normalize(MulOp);
	float4 WorldNormal = float4(NormalN.x, NormalN.y, NormalN.z, 1.0);
	OUT.Normal = WorldNormal;
	float4 WorldPos = mul(OUT.Position, world);
	OUT.WorldPosition = WorldPos;
	float4 WVSpace = mul(OUT.Position, wvp);
	OUT.Position = WVSpace;

	return OUT;
}

// -------------------------------------- ShaderPixel --------------------------------------
struct PIXELDATA
{
	float4 Color : SV_Target;
};

PIXELDATA ShaderPixel(SHADERDATA IN, bool FrontFace : SV_IsFrontFace)
{
	PIXELDATA OUT;

	float InvertSatMask = (1.0 - saturate(0.0));
	MyColorFunctionOutput MyColorFunction1268 = MyColorFunctionFunction(MyColor.xyz, MyMultiplier, OffsetColor.xyz);
	float3 ReplaceDiffuseWithReflection = (InvertSatMask * MyColorFunction1268.DiffuseColor);
	float3 NormOp = normalize(IN.Normal.xyz);
	float3 FlippedNormals = lerp(-(NormOp), NormOp, FrontFace);
	float ClampOpacity = saturate(1.0);
	float3 CameraPosition = viewI[3].xyz;
	float3 CamVec = (CameraPosition - IN.WorldPosition.xyz);
	float3 CamVecNorm = normalize(CamVec);
	float4 LightLoopTotal11 = float4(0,0,0,0);
	for (int ActiveLightIndex = 0; ActiveLightIndex < 1; ++ActiveLightIndex)
	{
		if (ActiveLightIndex >= ClampDynamicLights) {continue;}
		int _LightType = GetLightType(ActiveLightIndex);
		bool IsAmbientLight = (_LightType == 5);
		float4 IfAmbientLight384 = float4(0, 0, 0, 0);
		if (IsAmbientLight)
		{
			float3 _LightColor = GetLightColor(ActiveLightIndex);
			float _LightIntensity = GetLightIntensity(ActiveLightIndex);
			AmbientLightOutput AmbientLight389 = AmbientLightFunction(ActiveLightIndex, ReplaceDiffuseWithReflection, _LightColor, _LightIntensity);
			float3 PreMulAlphaAmbient = ((1.0 * AmbientLight389.LightColor) * ClampOpacity);
			float4 VectorConstruct = float4(PreMulAlphaAmbient.x, PreMulAlphaAmbient.y, PreMulAlphaAmbient.z, 0.0);
			IfAmbientLight384 = VectorConstruct;
		}
		else
		{
			float3 NoTranslucency = float3(0.0,0.0,0.0);
			float3 _LightPos = GetLightPos(ActiveLightIndex);
			float3 _LightDir = GetLightDir(ActiveLightIndex);
			GetLightVectorOutput GetLightVector848 = GetLightVectorFunction(ActiveLightIndex, _LightPos, IN.WorldPosition.xyz, _LightType, -_LightDir);
			float3 LightVecNorm = normalize(GetLightVector848.Result);
			LambertDiffuseOutput LambertDiffuse823 = LambertDiffuseFunction(ActiveLightIndex, ReplaceDiffuseWithReflection, FlippedNormals, LightVecNorm);
			LightContributionOutput LightContribution397 = LightContributionFunction(ActiveLightIndex, IN.WorldPosition.xyz, GetLightVector848.Result);
			float3 AddTranslucency = (NoTranslucency.xyz + (LambertDiffuse823.Color * LightContribution397.Light));
			float3 Col = float3(1.0,1.0,1.0);
			BlinnSpecularOutput BlinnSpecular966 = BlinnSpecularFunction(ActiveLightIndex, LightVecNorm, FlippedNormals, CamVecNorm, 20.0, Col.xyz);
			float3 SpecLightIntensity = (LightContribution397.Light * BlinnSpecular966.SpecularColor);
			float3 Diffuse_Spec = ((AddTranslucency * ClampOpacity) + SpecLightIntensity);
			DesaturateColorOutput DesaturateColor664 = DesaturateColorFunction(ActiveLightIndex, SpecLightIntensity);
			float4 Color_Alpha = float4(Diffuse_Spec.x, Diffuse_Spec.y, Diffuse_Spec.z, DesaturateColor664.DesaturateColor);
			IfAmbientLight384 = Color_Alpha;
		}
		float4 ApplyWeight395 = IfAmbientLight384;
		LightLoopTotal11 += ApplyWeight395;
	}
	float3 NoReflection = float3(0.0,0.0,0.0);
	float3 ReflectXmask = (0.0 * NoReflection.xyz);
	float3 DefaultEmissiveColor = float3(0.0,0.0,0.0);
	float3 DefaultIBLColor = float3(0.0,0.0,0.0);
	float3 PreMultipliedAlpha = ((DefaultEmissiveColor.xyz + DefaultIBLColor.xyz) * ClampOpacity);
	float3 AddReflection = (ReflectXmask + PreMultipliedAlpha);
	DesaturateColorOutput DesaturateColor363 = DesaturateColorFunction(ReflectXmask);
	float OpacityAndReflection = (ClampOpacity + DesaturateColor363.DesaturateColor);
	float4 TotalAmbientAndOpacity = float4(AddReflection.x, AddReflection.y, AddReflection.z, OpacityAndReflection);
	float4 LightLoopAndAfterLoop = (LightLoopTotal11 + TotalAmbientAndOpacity);
	float SatOp = saturate(LightLoopAndAfterLoop.w);
	float4 VectorConstruct = float4(LightLoopAndAfterLoop.xyz.x, LightLoopAndAfterLoop.xyz.y, LightLoopAndAfterLoop.xyz.z, SatOp);
	OUT.Color = VectorConstruct;

	return OUT;
}

// -------------------------------------- technique T0 ---------------------------------------
technique11 T0
<
	bool overridesDrawState = false;
	int isTransparent = 0;
>
{
	pass P0
	<
		string drawContext = "colorPass";
	>
	{
		SetVertexShader(CompileShader(vs_5_0, ShaderVertex()));
		SetPixelShader(CompileShader(ps_5_0, ShaderPixel()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
	}

}

