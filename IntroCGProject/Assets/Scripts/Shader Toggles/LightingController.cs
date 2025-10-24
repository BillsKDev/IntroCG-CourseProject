using UnityEngine;

public class LightingController : MonoBehaviour
{
    [SerializeField] Material[] roomMaterials;
    
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha0))
        {
            Debug.Log("Switched to No Lighting");
            SetLightingMode(0f);
        }

        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            Debug.Log("Switched to Diffuse");
            SetLightingMode(1f);
        }

        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            Debug.Log("Switched to Ambient");
            SetLightingMode(2f);
        }

        if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            Debug.Log("Switched to Specular");
            SetLightingMode(3f);
        }

        if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            Debug.Log("Switched to Ambient + Specular");
            SetLightingMode(4f);
        }
    }

    void SetLightingMode(float mode)
    {
        foreach (Material mat in roomMaterials)
            mat.SetFloat("_LightingMode", mode);
    }
}