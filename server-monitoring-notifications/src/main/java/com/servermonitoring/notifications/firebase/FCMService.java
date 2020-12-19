package com.servermonitoring.notifications.firebase;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.firebase.messaging.*;
import com.servermonitoring.notifications.model.NotificationRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class FCMService {

    private Logger logger = LoggerFactory.getLogger(FCMService.class);
        
    @Value("#{${app.notifications.defaults}}")
    private Map<String, String> defaults;
    
    
	@EventListener(ApplicationReadyEvent.class)
	public void sendNotitication() {
		List<NotificationRequest> requests = getNotifications();
		requests.stream().forEach((notification) -> {
			try {
				sendMessage(notification);
				Thread.sleep(15000);
			} catch (Exception ex) {
				logger.error("Error sending notification" + ex.getMessage());
			}
		});
	}
    
	List<NotificationRequest> getNotifications() {
		ObjectMapper mapper = new ObjectMapper();
		List<NotificationRequest> notifications = null;
		TypeReference<List<NotificationRequest>> typeReference = new TypeReference<List<NotificationRequest>>() {
		};
		InputStream inputStream = TypeReference.class.getResourceAsStream("/json/notifications.json");
		try {
			notifications = mapper.readValue(inputStream, typeReference);
		} catch (IOException e) {
			logger.error("Unable to read notifications json file: " + e.getMessage());
		}
		return notifications;
	}
    
	@SuppressWarnings("unchecked")
    public void sendMessage(NotificationRequest request) throws InterruptedException, ExecutionException {
    	logger.info("Sending Notification ...." + request.getSeverity());
    	
    	ObjectMapper m = new ObjectMapper();
    	Map<String,String> data = m.convertValue(request, Map.class);
    	AndroidConfig androidConfig = getAndroidConfig(defaults.get("topic"));
    	
    	Message.Builder builder = Message.builder();   	
    	builder.setAndroidConfig(androidConfig);
    	builder.setNotification(new Notification(defaults.get("title"), defaults.get("body")));
    	builder.putAllData(data);
    	builder.setTopic(defaults.get("topic"));
    	
    	Message message = builder.build();
    	
        String response = sendAndGetResponse(message);
        logger.info("Message sent with data. Topic: " + defaults.get("topic") + ", " + response);

    }
    

    private String sendAndGetResponse(Message message) throws InterruptedException, ExecutionException {
        return FirebaseMessaging.getInstance().sendAsync(message).get();
    }

    private AndroidConfig getAndroidConfig(String topic) {
        return AndroidConfig.builder()
                .setTtl(Duration.ofMinutes(2).toMillis()).setCollapseKey(topic)
                .setPriority(AndroidConfig.Priority.HIGH)
                .setNotification(AndroidNotification.builder().setSound(NotificationParameter.SOUND.getValue())
                        .setColor(NotificationParameter.COLOR.getValue()).setTag(topic).build()).build();
    }


}
