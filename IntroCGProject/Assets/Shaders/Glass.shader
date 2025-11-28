Shader "Custom/URPGlassWithProperExtrusion"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BumpMap ("Normalmap", 2D) = "bump" {}
        _ScaleUV ("Scale", Range(1,20)) = 1
        _BumpExtrusion ("Bump Extrusion", Range(0, 0.1)) = 0.01  
        _FresnelIntensity ("Fresnel Intensity", Range(0, 2)) = 1
        _TintIntensity ("Tint Intensity", Range(1, 5)) = 1.5
        _Transparency ("Transparency", Range(0, 1)) = 0.5
        _ColorShift ("Color Shift", Color) = (1, 1, 1, 1)
        _Brightness ("Brightness", Range(0, 2)) = 1
        _ReflectionStrength ("Reflection Strength", Range(0, 5)) = 0.3
        _ReflectionTint ("Reflection Tint", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderPipeline" = "UniversalRenderPipeline" }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 uvgrab : TEXCOORD1;
                float2 uvbump : TEXCOORD2;
                float4 vertex : SV_POSITION;
                float3 viewDirWS : TEXCOORD3;
                float3 normalWS : TEXCOORD4;
            };
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            float4 _MainTex_ST;
            TEXTURE2D(_BumpMap);
            SAMPLER(sampler_BumpMap);
            float4 _BumpMap_ST;
            TEXTURE2D(_GrabTexture);
            SAMPLER(sampler_GrabTexture);
            float4 _GrabTexture_TexelSize;
            float _ScaleUV;
            float _BumpExtrusion;  
            float _FresnelIntensity;
            float _TintIntensity;
            float _Transparency;
            
            float4 _ColorShift;
            float _Brightness;
            float _ReflectionStrength;
            float4 _ReflectionTint;
            
            v2f vert(appdata v)
            {
                v2f o;
                float3 worldPos = TransformObjectToWorld(v.vertex.xyz);
                float3 normalWS = normalize(TransformObjectToWorldNormal(v.normal));
                worldPos += normalWS * _BumpExtrusion;  
                o.vertex = TransformWorldToHClip(worldPos);
                #if UNITY_UV_STARTS_AT_TOP
                float scale = -1.0;
                #else
                float scale = 1.0f;
                #endif
                o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y * scale) + o.vertex.w) * 0.5;
                o.uvgrab.zw = o.vertex.zw;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uvbump = TRANSFORM_TEX(v.uv, _BumpMap);
                o.normalWS = normalWS;
                o.viewDirWS = normalize(_WorldSpaceCameraPos - worldPos);
                return o;
            }
            half4 frag(v2f i) : SV_Target
            {
                half3 normalTS = UnpackNormal(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, i.uvbump));
                float3 normalWS = normalize(normalTS + i.normalWS);
                float viewNormalDot = saturate(dot(i.viewDirWS, normalWS));
                float fresnelFactor = pow(1.0 - abs(viewNormalDot), _FresnelIntensity);
                
                half4 col = SAMPLE_TEXTURE2D(_GrabTexture, sampler_GrabTexture, i.uvgrab.xy / i.uvgrab.w);
                half4 tint = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv);
                
                float3 reflectDir = reflect(-i.viewDirWS, normalWS);
                float2 reflectUV = i.uv + reflectDir.xy * 0.2;
                half4 reflection = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, reflectUV);
                
                half4 reflectionColor = reflection * _ReflectionTint * fresnelFactor * _ReflectionStrength;
                col.rgb += reflectionColor.rgb;
                
                col.rgb += fresnelFactor * tint.rgb;
                col *= tint * _TintIntensity;
                col.rgb *= _ColorShift.rgb;
                col.rgb *= _Brightness;
                col.rgb = pow(col.rgb, 1.0 / 2.2);
                col.a = 1.0 - _Transparency;
                return col;
            }
            ENDHLSL
        }
    }
}