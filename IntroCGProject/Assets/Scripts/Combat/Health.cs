using System;
using System.Collections;
using UnityEngine;

public class Health : MonoBehaviour
{
    [SerializeField] int _maxHealth = 100;
    [SerializeField] Healthbar _healthbar;
    
    [SerializeField] bool _isPlayer = true;
    [SerializeField] Renderer[] _playerRenderers;
    [SerializeField] Renderer[] _enemyRenderers;
    [SerializeField] Material _rimMaterial;
    [SerializeField] float _rimDuration = 0.3f;
    
    public int health;
    bool _isInvulnerable;
    
    private Material[] _originalMaterials;
    private Renderer[] _activeRenderers;
    private Coroutine _rimCoroutine;
    
    public event Action OnTakeDamage;
    public event Action OnDie;
    public bool IsDead => health == 0;
    
    void Start()
    {
        health = _maxHealth;
        _activeRenderers = _isPlayer ? _playerRenderers : _enemyRenderers;
        
        if (_activeRenderers != null && _activeRenderers.Length > 0)
        {
            _originalMaterials = new Material[_activeRenderers.Length];
            for (int i = 0; i < _activeRenderers.Length; i++)
                if (_activeRenderers[i] != null) _originalMaterials[i] = _activeRenderers[i].material;
            
            SetupRimMaterialWithTextures();
        }
    }

    public void SetInvulnerable(bool isInvulnerable) => this._isInvulnerable = isInvulnerable;

    public void DealDamage(int damage)
    {
        if (health == 0) { return; }
        
        if (_isInvulnerable) { return; }
        health = Mathf.Max(health - damage, 0);
        
        OnTakeDamage?.Invoke();
        _healthbar.UpdateHeathBar(_maxHealth, health);
        
        if (_activeRenderers != null && _activeRenderers.Length > 0 && _rimMaterial != null)
        {
            if (_rimCoroutine != null)
                StopCoroutine(_rimCoroutine);
            _rimCoroutine = StartCoroutine(RimEffectCoroutine());
        }
        
        if (health == 0)
            OnDie?.Invoke();
        
        Debug.Log(health);
    }
    
    private void SetupRimMaterialWithTextures()
    {
        if (_rimMaterial != null && _activeRenderers != null && _activeRenderers.Length > 0)
        {
            foreach (var renderer in _activeRenderers)
            {
                if (renderer != null && renderer.material != null && renderer.material.mainTexture != null)
                {
                    _rimMaterial.SetTexture("_MainTex", renderer.material.mainTexture);
                    break;
                }
            }
        }
    }
    
    private IEnumerator RimEffectCoroutine()
    {
        for (int i = 0; i < _activeRenderers.Length; i++)
        {
            if (_activeRenderers[i] != null)
            {
                if (_originalMaterials[i] != null && _originalMaterials[i].mainTexture != null)
                {
                    _rimMaterial.SetTexture("_MainTex", _originalMaterials[i].mainTexture);
                }
                _activeRenderers[i].material = _rimMaterial;
            }
        }
        
        yield return new WaitForSeconds(_rimDuration);
        
        for (int i = 0; i < _activeRenderers.Length; i++)
        {
            if (_activeRenderers[i] != null && _originalMaterials[i] != null)
                _activeRenderers[i].material = _originalMaterials[i];
        }
    }
}