Shader "Shaders/Illumination"
{
    Properties
    {
        _Texture ("Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _MetallicMap ("Metallic Map", 2D) = "white" {}
        _Metallic ("Metallic", Range(0, 1)) = 0.5
        _Smoothness ("Smoothness", Range(0, 1)) = 0.5
        _SpecColor ("Specular Color", Color) = (1,1,1,1)
        _Shininess ("Shininess", Range(0.1, 100)) = 16
        _LightingMode ("Lighting Mode", Float) = 1
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalPipeline" }

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS   : NORMAL;
                float4 tangentOS  : TANGENT;
                float2 uv         : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float3 normalWS    : TEXCOORD0;
                float3 viewDirWS   : TEXCOORD1;
                float2 uv          : TEXCOORD2;
                float3 tangentWS   : TEXCOORD3;
                float3 bitangentWS : TEXCOORD4;
            };

            TEXTURE2D(_Texture);
            SAMPLER(sampler_Texture);
            TEXTURE2D(_NormalMap);
            SAMPLER(sampler_NormalMap);
            TEXTURE2D(_MetallicMap);
            SAMPLER(sampler_MetallicMap);

            CBUFFER_START(UnityPerMaterial)
                float4 _SpecColor;
                float _Shininess;
                float _LightingMode;
                float _Metallic;
                float _Smoothness;
                float4 _Texture_ST;
                float4 _NormalMap_ST;
                float4 _MetallicMap_ST;
            CBUFFER_END

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                float3 worldPos = TransformObjectToWorld(IN.positionOS.xyz);
                OUT.positionHCS = TransformWorldToHClip(worldPos);
                OUT.normalWS = TransformObjectToWorldNormal(IN.normalOS);
                OUT.tangentWS = TransformObjectToWorldDir(IN.tangentOS.xyz);
                OUT.bitangentWS = cross(OUT.normalWS, OUT.tangentWS) * IN.tangentOS.w;
                OUT.viewDirWS = normalize(GetCameraPositionWS() - worldPos);
                OUT.uv = TRANSFORM_TEX(IN.uv, _Texture);
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                half4 texColor = SAMPLE_TEXTURE2D(_Texture, sampler_Texture, IN.uv);
                
                // Sample normal map and convert to world space
                float3 normalTS = UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, IN.uv));
                float3x3 TBN = float3x3(IN.tangentWS, IN.bitangentWS, IN.normalWS);
                float3 N = normalize(mul(normalTS, TBN));
                
                // Sample metallic map
                float metallic = SAMPLE_TEXTURE2D(_MetallicMap, sampler_MetallicMap, IN.uv).r * _Metallic;
                
                float3 V = SafeNormalize(IN.viewDirWS);
                Light mainLight = GetMainLight();
                float3 L = normalize(mainLight.direction);
                
                half3 ambient = SampleSH(N);
                half3 diffuse = mainLight.color.rgb * saturate(dot(N, L));
                
                // Adjust specular based on metallic value
                float3 reflectDir = reflect(-L, N);
                float specFactor = pow(saturate(dot(reflectDir, V)), _Shininess * _Smoothness);
                half3 specular = lerp(_SpecColor.rgb, texColor.rgb, metallic) * specFactor * mainLight.color.rgb;
                
                if (_LightingMode == 0) return texColor; // no lighting
                else if (_LightingMode == 1) return half4(texColor * diffuse, 1.0); // diffuse
                else if (_LightingMode == 2) return half4(texColor.rgb * ambient, 1.0); // ambient
                else if (_LightingMode == 3) return half4(specular, 1.0); // specular
                else if (_LightingMode == 4) // ambient/specular
                {
                    half3 finalColor = (texColor.rgb * ambient) + specular;
                    return half4(finalColor, 1.0);
                }
                
                return texColor;
            }
            ENDHLSL
        }
    }
}