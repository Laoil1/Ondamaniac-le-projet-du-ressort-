using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scr_Play_Controller : MonoBehaviour {


	public class_Mouvement move; 
	//public class_PhotoMode photoMode;

	// Use this for initialization
	void Start () {
		move.isOnTheGround = true;
		move.camTransform = Camera.main.transform;
		move.transform = transform;
		move.rgdbd = GetComponent <Rigidbody> ();
	}

	// Update is called once per frame
	void Update () {

		if (static_Input.AllFire1KeyDown ())
		{ 
			StartCoroutine (move.OrientionChange ());
		}

			//move.UpdateOrientation();
		if (static_Input.AllFire2KeyDown() && move.isOnTheGround == true){
			print ("Jump");
			move.UpdateJump ();
		}


		//if(move.)

		move.UpdateGravity ();
		move.UpdatePosition();

	}



}

