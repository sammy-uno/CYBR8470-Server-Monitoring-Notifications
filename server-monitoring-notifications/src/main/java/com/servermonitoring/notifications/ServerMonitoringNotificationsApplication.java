package com.servermonitoring.notifications;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class ServerMonitoringNotificationsApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServerMonitoringNotificationsApplication.class, args);
	}

}
