package com.studynest.feedback_service.controller;

import com.studynest.feedback_service.data.Feedback;
import com.studynest.feedback_service.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class FeedbackController {

    @Autowired
    private FeedbackService obj;

    @PostMapping("/feedback")
    public Feedback saveFeedback(@RequestBody Feedback feedback) {
        return obj.saveFeedback(feedback);
    }

    @GetMapping("/feedback")
    public List<Feedback> getAllFeedback() {
        return obj.getAllFeedback();
    }

    @GetMapping("/feedback/user/{userId}")
    public List<Feedback> getFeedbackByUser(@PathVariable("userId") int userId) {
        return obj.getFeedbackByUser(userId);
    }
}