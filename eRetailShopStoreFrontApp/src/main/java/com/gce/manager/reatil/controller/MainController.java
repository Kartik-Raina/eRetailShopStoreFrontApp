/**
 * 
 */
package com.gce.manager.reatil.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Kartik Raina
 *
 */
@Controller
public class MainController {
	@RequestMapping("/")
	public String welcomeMessage() {
		return "welcome";
	}
	
	@RequestMapping("/addshop")
	public String addNewShop() {
		return "addshop";
	}
}