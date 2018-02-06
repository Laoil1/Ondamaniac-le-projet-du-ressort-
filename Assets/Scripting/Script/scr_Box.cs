using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scr_Box : MonoBehaviour {

	void OnTriggerEnter(Collider other){
		//creer des matos en doublons avec un opaque et un transparent
		Color opak = other.GetComponent<Renderer> ().material.color;
		opak.a = 0.5f;
		other.GetComponent<Renderer> ().material.color = opak;

	}
	void OnTriggerExit(Collider other){
		Color opak = other.GetComponent<Renderer> ().material.color;
		opak.a = 1f;
		other.GetComponent<Renderer> ().material.color = opak;
	}
	
	// Update is called once per frame

}
