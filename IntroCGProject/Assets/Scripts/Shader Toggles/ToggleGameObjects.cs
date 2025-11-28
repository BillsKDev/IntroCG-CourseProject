using UnityEngine;
using System.Collections.Generic;

public class ToggleGameObjects : MonoBehaviour
{
    [SerializeField] GameObject[] _lightingToggle;
    [SerializeField] GameObject _globalVolumeObject;
    [SerializeField] KeyCode _toggleKey = KeyCode.E;
    [SerializeField] KeyCode _volumeToggleKey = KeyCode.G;
    [SerializeField] KeyCode _textureToggleKey = KeyCode.T;
    [SerializeField] bool _setActive = true;
    
    [SerializeField] bool _includeInactiveObjects = true;
    [SerializeField] LayerMask _layer = -1; 
    [SerializeField] Material _untexturedMaterial;
    
    List<Renderer> _allRenderers = new List<Renderer>();
    Dictionary<Renderer, Material[]> _originalMaterials = new Dictionary<Renderer, Material[]>();
    bool _texturesEnabled = true;

    private void Start()
    {
        SetObjectsActive(_setActive);
        FindAllRenderersInScene();
    }

    private void Update()
    {
        if (Input.GetKeyDown(_toggleKey))
            ToggleObjects();
            
        if (Input.GetKeyDown(_volumeToggleKey))
            ToggleGlobalVolume();
            
        if (Input.GetKeyDown(_textureToggleKey))
            ToggleTextures();
    }

    public void ToggleObjects()
    {
        foreach (GameObject obj in _lightingToggle)
        {
            if (obj != null)
                obj.SetActive(!obj.activeSelf);
        }
    }

    public void ToggleGlobalVolume()
    {
        if (_globalVolumeObject != null)
            _globalVolumeObject.SetActive(!_globalVolumeObject.activeSelf);
    }
    
    public void ToggleTextures()
    {
        _texturesEnabled = !_texturesEnabled;
        
        foreach (Renderer renderer in _allRenderers)
        {
            if (renderer != null)
            {
                if (_texturesEnabled)
                {
                    // Restore original materials
                    if (_originalMaterials.ContainsKey(renderer))
                    {
                        renderer.materials = _originalMaterials[renderer];
                    }
                }
                else
                {
                    // Apply untextured material
                    if (_untexturedMaterial != null)
                    {
                        renderer.material = _untexturedMaterial;
                    }
                }
            }
        }
    }

    public void SetObjectsActive(bool active)
    {
        foreach (GameObject obj in _lightingToggle)
        {
            if (obj != null)
                obj.SetActive(active);
        }
    }
    
    private void FindAllRenderersInScene()
    {
        _allRenderers.Clear();
        _originalMaterials.Clear();
        
        // Find all renderers in the scene (including inactive ones if specified)
        Renderer[] allRenderers = FindObjectsOfType<Renderer>(_includeInactiveObjects);
        
        foreach (Renderer renderer in allRenderers)
        {
            // Filter by layer if needed
            if (_layer == (_layer | (1 << renderer.gameObject.layer)))
            {
                _allRenderers.Add(renderer);
                _originalMaterials[renderer] = renderer.materials;
            }
        }
    }
}