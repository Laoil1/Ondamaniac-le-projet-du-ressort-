// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ColorByWorldNormal"
{
	Properties
	{
		_Right_Color("Right_Color", Color) = (0.2156863,0.4705882,0.4588235,0)
		_Bottom_Color("Bottom_Color", Color) = (0,0.4470588,0.427451,0)
		_Top_Color("Top_Color", Color) = (0,1,0.9568627,0)
		_Diffuse_keep_black_for_no_influence("Diffuse_(keep_black_for_no_influence)", Color) = (0,0,0,0)
		_Left_Color("Left_Color", Color) = (0.2862745,0.5960785,0.5803922,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldNormal;
		};

		uniform float4 _Diffuse_keep_black_for_no_influence;
		uniform float4 _Left_Color;
		uniform float4 _Top_Color;
		uniform float4 _Right_Color;
		uniform float4 _Bottom_Color;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Diffuse_keep_black_for_no_influence.rgb;
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float4 lerpResult28 = lerp( _Left_Color , _Top_Color , ase_vertexNormal.y);
			float4 lerpResult60 = lerp( lerpResult28 , _Right_Color , ase_vertexNormal.x);
			float4 lerpResult63 = lerp( lerpResult60 , _Right_Color , ( ase_vertexNormal.x * -1.0 ));
			float4 lerpResult61 = lerp( lerpResult63 , _Bottom_Color , ( ase_vertexNormal.y * -1.0 ));
			o.Emission = lerpResult61.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD6;
				float3 worldNormal : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	/*CustomEditor "ASEMaterialInspector"*/
}
/*ASEBEGIN
Version=13501
331;457;1267;556;2816.604;438.6102;4.466196;True;True
Node;AmplifyShaderEditor.ColorNode;25;-952.2487,-352.0152;Float;False;Property;_Top_Color;Top_Color;-1;0;0,1,0.9568627,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;59;-948.7819,-13.25933;Float;False;Property;_Left_Color;Left_Color;-1;0;0.2862745,0.5960785,0.5803922,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.NormalVertexDataNode;56;-553.4752,191.1654;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;28;-287.0638,-336.8096;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;57;-948.9864,156.3665;Float;False;Property;_Right_Color;Right_Color;-1;0;0.2156863,0.4705882,0.4588235,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-260.5834,149.3064;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;60;-65.37941,-290.2516;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-118.5896,244.0575;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;58;-950.6772,-182.1902;Float;False;Property;_Bottom_Color;Bottom_Color;-1;0;0,0.4470588,0.427451,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;63;126.1262,-166.8167;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;77;384.4394,749.8604;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-74.1753,1030.764;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;74;-20.96511,496.4547;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;79;-618.1355,572.0351;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;10,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;82;-618.7916,859.3834;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;10,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-618.8214,769.0186;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;10,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;80;-618.8199,672.1901;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;10,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;69;-928.4147,425.5237;Float;False;Property;_Default;Default;-1;0;0,1,0.9568627,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;61;340.0251,-36.84642;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;67;34.96991,-659.5052;Float;False;Property;_Diffuse_keep_black_for_no_influence;Diffuse_(keep_black_for_no_influence);-1;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;71;-242.6495,449.8967;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;75;170.5405,619.89;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-216.1691,936.0132;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;1;FLOAT
Node;AmplifyShaderEditor.NormalVertexDataNode;68;-509.0609,977.8723;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;599.8067,-75.17847;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ColorByWorldNormal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0.0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;59;0
WireConnection;28;1;25;0
WireConnection;28;2;56;2
WireConnection;64;0;56;1
WireConnection;60;0;28;0
WireConnection;60;1;57;0
WireConnection;60;2;56;1
WireConnection;65;0;56;2
WireConnection;63;0;60;0
WireConnection;63;1;57;0
WireConnection;63;2;64;0
WireConnection;77;0;75;0
WireConnection;77;1;82;0
WireConnection;77;2;76;0
WireConnection;76;0;68;2
WireConnection;74;0;71;0
WireConnection;74;1;80;0
WireConnection;74;2;68;1
WireConnection;79;0;69;0
WireConnection;82;0;69;0
WireConnection;81;0;69;0
WireConnection;80;0;69;0
WireConnection;61;0;63;0
WireConnection;61;1;58;0
WireConnection;61;2;65;0
WireConnection;71;0;79;0
WireConnection;71;1;69;0
WireConnection;71;2;68;2
WireConnection;75;0;74;0
WireConnection;75;1;81;0
WireConnection;75;2;73;0
WireConnection;73;0;68;1
WireConnection;0;0;67;0
WireConnection;0;2;61;0
ASEEND*/
//CHKSM=F51428A7C2BAC026BF10D3589EE9318D9E8950ED