using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scr_Play_Controller : MonoBehaviour {


	public class_Mouvement move; 
	//public class_PhotoMode photoMode;

	// Use this for initialization
	void Start () {
		move.isOnTheGround = true;
		//move.camTransform = Camera.main.transform;
		move.transform = transform;
		move.rgdbd = GetComponent <Rigidbody> ();
		move.resetJump ();
	}

	// Update is called once per frame
	void Update () {

		if (static_Input.AllFire1KeyDown ())
		{ 
			StartCoroutine (move.OrientionChange ());
		}

			//move.UpdateOrientation();


		if (static_Input.AllFire2KeyUp() && move.isOnTheGround == true){
			move.UpdateJump ();
			move.resetJump ();
		}

		if(Input.GetAxis ("Fire2")>0){
			move.AugmentationJump ();
		}
		/*if (static_Input.AllFire2KeyDown ()){
			print ("gogopowerrangers"); 
			move.Jump ();
		}*/
		//if(move.)

		move.UpdateGravity ();
		move.UpdatePosition();

	}



}

