package com.gce.manager.reatil;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class ERetailShopStoreFrontAppApplication extends SpringBootServletInitializer {

	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(ERetailShopStoreFrontAppApplication.class);
	}
	
	public static void main(String[] args) {
		SpringApplication.run(ERetailShopStoreFrontAppApplication.class, args);
	}

}
