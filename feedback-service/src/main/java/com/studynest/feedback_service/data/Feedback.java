package src.main.java.com.studynest.feedback_service.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document(collection = "studynest_feedback")
public class Feedback {

    @Id
    private String feedbackId;

    private int userId;
    private String message;
    private LocalDateTime submittedAt;

    // Generate getters and setters: Alt+Insert → Getter and Setter → select all fields
    
}