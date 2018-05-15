// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AUTO-ColorByWorldNormal"
{
	Properties
	{
		_DoNotTouch_RIGHT("(DoNotTouch)_RIGHT", Color) = (0.3455882,0.3455882,0.3455882,0)
		_DoNotTouch_BOTTOM("(DoNotTouch)_BOTTOM", Color) = (0,0,0,0)
		_Emissive_Top("Emissive_Top", Color) = (1,1,1,0)
		_DoNotTouch_LEFT("(DoNotTouch)_LEFT", Color) = (0.6544118,0.6544118,0.6544118,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldNormal;
		};

		uniform float4 _Emissive_Top;
		uniform float4 _DoNotTouch_LEFT;
		uniform float4 _DoNotTouch_RIGHT;
		uniform float4 _DoNotTouch_BOTTOM;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float4 lerpResult1 = lerp( ( _Emissive_Top + _DoNotTouch_LEFT ) , _Emissive_Top , ase_vertexNormal.y);
			float4 lerpResult5 = lerp( lerpResult1 , ( _Emissive_Top + _DoNotTouch_RIGHT ) , ase_vertexNormal.x);
			float4 lerpResult4 = lerp( lerpResult5 , ( _Emissive_Top + _DoNotTouch_RIGHT ) , ( ase_vertexNormal.x * -1.0 ));
			float4 lerpResult7 = lerp( lerpResult4 , ( _Emissive_Top + _DoNotTouch_BOTTOM ) , ( ase_vertexNormal.y * -1.0 ));
			o.Emission = lerpResult7.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13501
267;650;1305;384;2580.875;198.4649;2.301078;True;False
Node;AmplifyShaderEditor.CommentaryNode;15;-1342.438,-113.6454;Float;False;204;183;LEFT;1;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;20;-1698.605,42.08414;Float;False;Property;_DoNotTouch_LEFT;(DoNotTouch)_LEFT;-1;0;0.6544118,0.6544118,0.6544118,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;12;-1706.641,-216.2468;Float;False;Property;_Emissive_Top;Emissive_Top;-1;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;14;-1357.722,87.82471;Float;False;212.6405;176.0875;RIGHT;1;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;18;-1696.412,250.5359;Float;False;Property;_DoNotTouch_RIGHT;(DoNotTouch)_RIGHT;-1;0;0.3455882,0.3455882,0.3455882,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-1000.636,486.6131;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-1327.466,-58.04079;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.8235294,0.8235294,0.8235294,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-1307.722,137.8246;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;10,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;16;-1355.995,269.3311;Float;False;204;183;RIGHT_SHADOW;1;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;1;-1032.024,-137.7477;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-1305.995,319.331;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;10,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-707.7457,444.7539;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;5;-707.818,-143.4228;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;17;-1679.222,471.2549;Float;False;Property;_DoNotTouch_BOTTOM;(DoNotTouch)_BOTTOM;-1;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;13;-1352.631,472.7194;Float;False;204;183;BOTTOM;1;11;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-1302.631,522.7194;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.2426471,0.2426471,0.2426471,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-565.7519,539.5045;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;4;-516.3125,-19.98748;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;7;-302.4135,109.9829;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;25;-1417.06,-572.6069;Float;False;Constant;_Color0;Color 0;-1;0;0.125,0.125,0.125,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;AUTO-ColorByWorldNormal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;12;0
WireConnection;8;1;20;0
WireConnection;9;0;12;0
WireConnection;9;1;18;0
WireConnection;1;0;8;0
WireConnection;1;1;12;0
WireConnection;1;2;2;2
WireConnection;10;0;12;0
WireConnection;10;1;18;0
WireConnection;3;0;2;1
WireConnection;5;0;1;0
WireConnection;5;1;9;0
WireConnection;5;2;2;1
WireConnection;11;0;12;0
WireConnection;11;1;17;0
WireConnection;6;0;2;2
WireConnection;4;0;5;0
WireConnection;4;1;10;0
WireConnection;4;2;3;0
WireConnection;7;0;4;0
WireConnection;7;1;11;0
WireConnection;7;2;6;0
WireConnection;0;2;7;0
ASEEND*/
//CHKSM=C36BA9E726DB5A433A4D25AE6FE618E03FB0B5CD