package com.studynest.feedback_service.service;

import com.studynest.feedback_service.data.Feedback;
import com.studynest.feedback_service.data.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRep;

    public Feedback saveFeedback(Feedback feedback) {
        if (feedback.getMessage() == null || feedback.getMessage().isBlank()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Feedback message is required");
        }
        feedback.setFeedbackId(null);
        feedback.setSubmittedAt(LocalDateTime.now());
        return feedbackRep.save(feedback);
    }

    public List<Feedback> getAllFeedback() {
        return feedbackRep.findAll();
    }

    public List<Feedback> getFeedbackByUser(int userId) {
        return feedbackRep.findByUserId(userId);
    }
}