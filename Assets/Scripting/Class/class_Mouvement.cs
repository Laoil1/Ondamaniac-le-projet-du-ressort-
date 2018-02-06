using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[System.Serializable]

public class class_Mouvement {

	public enum Direction {
		Up,Down,Left,Right
	};

	[HideInInspector] 
	public bool isOnTheGround;

	[HideInInspector]
	public Transform camTransform;

	[HideInInspector]
	public Transform transform;

	[HideInInspector]
	public Rigidbody rgdbd;

	public Transform[] rayOrig;
	public float mouseSpeed = 5;
	public float playerSpeed = 1;
	public float jumpForce = 10;
	float gravityforce = -10;
	public float cameraChangeTime = 0.2f;
	public float cameraChangeStep = 10;

	public void UpdatePosition(/*int playerSpeed*/)
	{
		//on récupère les input sur les axes de déplacement
		float depZ = - Input.GetAxisRaw("Horizontal");
		float depX = Input.GetAxisRaw("Vertical");

		rgdbd.velocity = new Vector3 (depX * playerSpeed, rgdbd.velocity.y, depZ * playerSpeed);	
		/*
		transform.position += new Vector3 (depX * playerSpeed,0,0);
		transform.position += new Vector3 (0, 0, depZ * playerSpeed);*/
	}

	public void UpdateJump()
	{
		rgdbd.AddForce (transform.up*jumpForce,ForceMode.Impulse);

	}

	public void UpdateGravity (){
		
		rgdbd.AddForce (transform.up*gravityforce, ForceMode.Impulse);
		isOnTheGround = false;

		if (DetectGround (rayOrig[0])){
			isOnTheGround = true;
			Debug.Log ("OLB0");
			PlayerOrientationUpdate (Direction.Up);
		}

		if (DetectGround (rayOrig[1])){
			isOnTheGround = true;
			Debug.Log ("OLB1");
			PlayerOrientationUpdate (Direction.Down);
		}

	}



	public void PlayerOrientationUpdate(Direction dir){
		Quaternion tempQua = Quaternion.Euler (0,0,0);
		if (dir == Direction.Right){
			tempQua = Quaternion.Euler (-90, 0, 0);
		}
		if (dir == Direction.Up){
			tempQua = Quaternion.Euler (0, 0, 0);
		}
		if (dir == Direction.Left){
			tempQua = Quaternion.Euler (90, 0, 0);
		}
		if (dir == Direction.Down){
			tempQua = Quaternion.Euler (180, 0, 0);
		}
			
		transform.rotation = tempQua;
	}

	bool DetectGround(Transform boxOrig){

		Collider[] col = Physics.OverlapBox (boxOrig.position,new Vector3(0.4f,0.4f,0.4f),Quaternion.identity);
		if(col!=null){
		for (int i = 0; i < col.Length; i++) {
			if (col[i].tag != "Player"){
					return true;
			}
		}
	}
		return false;
	}

	public IEnumerator Jump (){

		for (int i = 0; i < 10; i++) {
			rgdbd.AddForce (transform.up*jumpForce,ForceMode.Impulse);
			//transform.position += transform.up; 
			yield return new WaitForSeconds (Time.deltaTime);
		}

		yield break; 
	}

	public IEnumerator OrientionChange (){
		Vector3 currentRotation = camTransform.eulerAngles; 
		float targetRot = -90;
		int decal;

		if (currentRotation.x<90){
			targetRot = -90;
		}

		if (currentRotation.x>90){
			targetRot = 90;
		}

		for (int i = 0; i < cameraChangeStep; i++) {
			camTransform.Rotate (targetRot/cameraChangeStep,0,0);
			yield return new WaitForSeconds (cameraChangeTime/cameraChangeStep);
		}


		yield break;
	}
}
