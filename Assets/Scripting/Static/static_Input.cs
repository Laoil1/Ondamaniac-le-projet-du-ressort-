using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class static_Input {

	static bool isFire2Enter;
	static public bool AllFire2KeyDown () 
	{
		if (Input.GetAxis ("Fire2") > 0 && isFire2Enter == false) {
			isFire2Enter = true;
			return true;
		} 
		if (Input.GetAxis ("Fire2") <= 0) {
			isFire2Enter = false;
			return false;
		}
		return false;
	}
	static public bool AllFire2KeyUp () 
	{
		if (Input.GetAxis ("Fire2") <= 0 && isFire2Enter == true) {
			isFire2Enter = false;
			return true;
		} 
		if (Input.GetAxis ("Fire2") > 0) {
				isFire2Enter = true;
			return false;
		}                                                  
		return false;
	}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     

	static bool isFire1Enter;
	static public bool AllFire1KeyDown () 
	{
		if (Input.GetAxis ("Fire1") > 0 && isFire1Enter == false) {
			isFire1Enter = true;
			return true;
		} 
		if (Input.GetAxis ("Fire1") <= 0) {
			isFire1Enter = false;
			return false;
		}
		return false;
	}

}
