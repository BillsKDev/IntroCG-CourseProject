using UnityEngine;

public class ToggleGameObjects : MonoBehaviour
{
    [SerializeField] GameObject[] _lightingToggle;
    [SerializeField] GameObject _globalVolumeObject;
    [SerializeField] KeyCode _toggleKey = KeyCode.E;
    [SerializeField] KeyCode _volumeToggleKey = KeyCode.G;
    [SerializeField] bool _setActive = true;

    private void Start()
    {
        SetObjectsActive(_setActive);
    }

    private void Update()
    {
        if (Input.GetKeyDown(_toggleKey))
            ToggleObjects();
            
        if (Input.GetKeyDown(_volumeToggleKey))
            ToggleGlobalVolume();
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

    public void SetObjectsActive(bool active)
    {
        foreach (GameObject obj in _lightingToggle)
        {
            if (obj != null)
                obj.SetActive(active);
        }
    }
}