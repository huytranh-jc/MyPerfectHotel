Shader "FlatKit/Stylized Surface" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		[Space(10)] [KeywordEnum(None, Single, Steps, Curve)] _CelPrimaryMode ("Cel Shading Mode", Float) = 1
		_ColorDim ("[_CELPRIMARYMODE_SINGLE]Color Shaded", Vector) = (0.85023,0.85034,0.85045,0.85056)
		_ColorDimSteps ("[_CELPRIMARYMODE_STEPS]Color Shaded", Vector) = (0.85023,0.85034,0.85045,0.85056)
		_ColorDimCurve ("[_CELPRIMARYMODE_CURVE]Color Shaded", Vector) = (0.85023,0.85034,0.85045,0.85056)
		_SelfShadingSize ("[_CELPRIMARYMODE_SINGLE]Self Shading Size", Range(0, 1)) = 0.5
		_ShadowEdgeSize ("[_CELPRIMARYMODE_SINGLE]Shadow Edge Size", Range(0, 0.5)) = 0.05
		_Flatness ("[_CELPRIMARYMODE_SINGLE]Localized Shading", Range(0, 1)) = 1
		[IntRange] _CelNumSteps ("[_CELPRIMARYMODE_STEPS]Number Of Steps", Range(1, 10)) = 3
		_CelStepTexture ("[_CELPRIMARYMODE_STEPS][LAST_PROP_STEPS]Cel steps", 2D) = "black" {}
		_CelCurveTexture ("[_CELPRIMARYMODE_CURVE][LAST_PROP_CURVE]Ramp", 2D) = "black" {}
		[Space(10)] [Toggle(DR_CEL_EXTRA_ON)] _CelExtraEnabled ("Enable Extra Cel Layer", Float) = 0
		_ColorDimExtra ("[DR_CEL_EXTRA_ON]Color Shaded", Vector) = (0.85023,0.85034,0.85045,0.85056)
		_SelfShadingSizeExtra ("[DR_CEL_EXTRA_ON]Self Shading Size", Range(0, 1)) = 0.6
		_ShadowEdgeSizeExtra ("[DR_CEL_EXTRA_ON]Shadow Edge Size", Range(0, 0.5)) = 0.05
		_FlatnessExtra ("[DR_CEL_EXTRA_ON]Localized Shading", Range(0, 1)) = 1
		[Space(10)] [Toggle(DR_SPECULAR_ON)] _SpecularEnabled ("Enable Specular", Float) = 0
		[HDR] _FlatSpecularColor ("[DR_SPECULAR_ON]Specular Color", Vector) = (0.85023,0.85034,0.85045,0.85056)
		_FlatSpecularSize ("[DR_SPECULAR_ON]Specular Size", Range(0, 1)) = 0.1
		_FlatSpecularEdgeSmoothness ("[DR_SPECULAR_ON]Specular Edge Smoothness", Range(0, 1)) = 0
		[Space(10)] [Toggle(DR_RIM_ON)] _RimEnabled ("Enable Rim", Float) = 0
		[HDR] _FlatRimColor ("[DR_RIM_ON]Rim Color", Vector) = (0.85023,0.85034,0.85045,0.85056)
		_FlatRimLightAlign ("[DR_RIM_ON]Light Align", Range(0, 1)) = 0
		_FlatRimSize ("[DR_RIM_ON]Rim Size", Range(0, 1)) = 0.5
		_FlatRimEdgeSmoothness ("[DR_RIM_ON]Rim Edge Smoothness", Range(0, 1)) = 0.5
		[Space(10)] [Toggle(DR_GRADIENT_ON)] _GradientEnabled ("Enable Height Gradient", Float) = 0
		[HDR] _ColorGradient ("[DR_GRADIENT_ON]Gradient Color", Vector) = (0.85023,0.85034,0.85045,0.85056)
		_GradientCenterX ("[DR_GRADIENT_ON]Center X", Float) = 0
		_GradientCenterY ("[DR_GRADIENT_ON]Center Y", Float) = 0
		_GradientSize ("[DR_GRADIENT_ON]Size", Float) = 10
		_GradientAngle ("[DR_GRADIENT_ON]Gradient Angle", Range(0, 360)) = 0
		[Space(10)] [Toggle(DR_VERTEX_COLORS_ON)] _VertexColorsEnabled ("Enable Vertex Colors", Float) = 0
		_LightContribution ("[FOLDOUT(Advanced Lighting){4}]Light Color Contribution", Range(0, 1)) = 0
		[Header(Override light direction)] [Toggle] _OverrideLightmapDir ("[DR_ENABLE_LIGHTMAP_DIR]Enable", Float) = 0
		_LightmapDirectionPitch ("Pitch", Range(0, 360)) = 0
		_LightmapDirectionYaw ("Yaw", Range(0, 360)) = 0
		[HideInInspector] _LightmapDirection ("Override Light Direction", Vector) = (0,1,0,0)
		[KeywordEnum(None, Multiply, Color)] _UnityShadowMode ("[FOLDOUT(Unity Built-in Shadows){4}]Mode", Float) = 0
		_UnityShadowPower ("[_UNITYSHADOWMODE_MULTIPLY]Power", Range(0, 1)) = 0.2
		_UnityShadowColor ("[_UNITYSHADOWMODE_COLOR]Color", Vector) = (0.85023,0.85034,0.85045,0.85056)
		_UnityShadowSharpness ("Sharpness", Range(1, 10)) = 1
		[Space(10)] _MainTex ("[FOLDOUT(Texture maps){4}]Albedo", 2D) = "white" {}
		[KeywordEnum(Multiply, Add)] _TextureBlendingMode ("Blending Mode", Float) = 0
		_TextureImpact ("Texture Impact", Range(0, 1)) = 1
		[Space(10)] _BumpMap ("Bump Map", 2D) = "bump" {}
		[HideInInspector] _Surface ("__surface", Float) = 0
		[HideInInspector] _Blend ("__blend", Float) = 0
		[HideInInspector] _AlphaClip ("__clip", Float) = 0
		[HideInInspector] _SrcBlend ("__src", Float) = 1
		[HideInInspector] _DstBlend ("__dst", Float) = 0
		[HideInInspector] _ZWrite ("__zw", Float) = 1
		[HideInInspector] _Cull ("__cull", Float) = 2
		[HideInInspector] _QueueOffset ("Queue offset", Float) = 0
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200

		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _MainTex_ST;

			struct Vertex_Stage_Input
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.uv = (input.uv.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				output.pos = mul(unity_MatrixVP, mul(unity_ObjectToWorld, input.pos));
				return output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			float4 _Color;

			struct Fragment_Stage_Input
			{
				float2 uv : TEXCOORD0;
			};

			float4 frag(Fragment_Stage_Input input) : SV_TARGET
			{
				return _MainTex.Sample(sampler_MainTex, input.uv.xy) * _Color;
			}

			ENDHLSL
		}
	}
	Fallback "Diffuse"
	//CustomEditor "StylizedSurfaceEditor"
}