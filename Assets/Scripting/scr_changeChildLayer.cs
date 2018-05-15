using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scr_changeChildLayer : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
        gameObject.layer = transform.parent.gameObject.layer;
        //print("bite");

	}
}
